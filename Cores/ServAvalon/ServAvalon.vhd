-- MIT License
--
-- Copyright (c) 2022 ARIES Embedded GmbH
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ServAvalon is
	generic (
		C_RESET_VECTOR : std_logic_vector(31 downto 0) := x"00000010";
		C_INTERRUPTS : natural range 1 to 32 := 8;
		C_TIMER_WIDTH : natural range 33 to 64 := 64
	);
	port (
		clk     : in  std_logic;
		resetn  : in  std_logic;
		-- Avalon Instruction Master
		avalon_ibus_address       : out std_logic_vector(31 downto 0);
		avalon_ibus_read          : out std_logic;
		avalon_ibus_readdata      : in  std_logic_vector(31 downto 0);
		avalon_ibus_readdatavalid : in  std_logic;
		avalon_ibus_waitrequest   : in  std_logic                                  := '0';
		-- Avalon Data Master
		avalon_dbus_address       : out std_logic_vector(31 downto 0);
		avalon_dbus_byteenable    : out std_logic_vector(3 downto 0);
		avalon_dbus_read          : out std_logic;
		avalon_dbus_readdata      : in  std_logic_vector(31 downto 0) := (others => '0');
		avalon_dbus_write         : out std_logic;
		avalon_dbus_writedata     : out std_logic_vector(31 downto 0);
		avalon_dbus_waitrequest   : in  std_logic                                  := '0';
		avalon_dbus_readdatavalid : in  std_logic;
		-- Avalon Slave - Interrupt Controller
		avalon_ic_address       : in std_logic_vector(3 downto 0);
		avalon_ic_readdata      : out std_logic_vector(31 downto 0);
		avalon_ic_readdatavalid : out std_logic;
		avalon_ic_read          : in std_logic;
		avalon_ic_write         : in std_logic;
		avalon_ic_writedata     : in std_logic_vector(31 downto 0);
		avalon_ic_waitrequest   : out std_logic;
		interrupts              : in std_logic_vector(7 downto 0)
	);
end entity ServAvalon;



architecture rtl of ServAvalon is

	-- SERV Wishbone Bus
	signal ibus_adr : std_logic_vector(31 downto 0) := x"00000000";
	signal ibus_cyc : std_logic := '0';
	signal ibus_rdt : std_logic_vector(31 downto 0) := x"00000000";
	signal ibus_ack : std_logic := '0';
	signal dbus_adr : std_logic_vector(31 downto 0) := x"00000000";
	signal dbus_dat : std_logic_vector(31 downto 0) := x"00000000";
	signal dbus_sel : std_logic_vector(3 downto 0) := "0000";
	signal dbus_we  : std_logic := '0';
	signal dbus_cyc : std_logic := '0';
	signal dbus_rdt : std_logic_vector(31 downto 0) := x"00000000";
	signal dbus_ack : std_logic := '0';

	signal interrupt : std_logic := '0';

	component serv_rf_top is
		generic (
			RESET_PC : std_logic_vector(31 downto 0) := x"00000000";
			MDU : natural := 0;
			PRE_REGISTER : natural := 1
		);
		port (
			clk : in  std_logic;
			i_rst : in  std_logic;
			i_timer_irq : in  std_logic;

			o_ibus_adr : out std_logic_vector(31 downto 0);
			o_ibus_cyc : out std_logic;
			i_ibus_rdt : in  std_logic_vector(31 downto 0) := x"00000000";
			i_ibus_ack : in  std_logic := '0';
			o_dbus_adr : out std_logic_vector(31 downto 0);
			o_dbus_dat : out std_logic_vector(31 downto 0);
			o_dbus_sel : out std_logic_vector(3 downto 0);
			o_dbus_we  : out std_logic;
			o_dbus_cyc : out std_logic;
			i_dbus_rdt : in  std_logic_vector(31 downto 0) := x"00000000";
			i_dbus_ack : in  std_logic := '0'
		);
	end component serv_rf_top;

	component ServInterruptController is
		generic (
			C_INTERRUPTS : natural range 1 to 32;
			C_TIMER_HIGH_WIDTH : natural range 1 to 32
		);
		port (
			clk       : in  std_logic;
			resetn     : in  std_logic;
			out_interrupt : out std_logic;
			-- Avalon Slave - Interrupt Controller
			avalon_address       : in std_logic_vector(3 downto 0);
			avalon_readdata      : out std_logic_vector(31 downto 0);
			avalon_readdatavalid : out std_logic;
			avalon_read          : in std_logic;
			avalon_write         : in std_logic;
			avalon_writedata     : in std_logic_vector(31 downto 0);
			avalon_waitrequest   : out std_logic;
			in_interrupts        : in std_logic_vector(7 downto 0)
		);
	end component ServInterruptController;

begin

	serv : component serv_rf_top
		generic map (
			RESET_PC => C_RESET_VECTOR
		)
		port map (
			clk        => clk,
			i_rst      => not resetn,
			i_timer_irq  => interrupt,
			o_ibus_adr => ibus_adr,
			o_ibus_cyc => ibus_cyc,
			i_ibus_rdt => ibus_rdt,
			i_ibus_ack => ibus_ack,
			o_dbus_adr => dbus_adr,
			o_dbus_dat => dbus_dat,
			o_dbus_sel => dbus_sel,
			o_dbus_we  => dbus_we,
			o_dbus_cyc => dbus_cyc,
			i_dbus_rdt => dbus_rdt,
			i_dbus_ack => dbus_ack
		);

	serv_ic : component ServInterruptController
		generic map (
			C_INTERRUPTS => C_INTERRUPTS,
			C_TIMER_HIGH_WIDTH => C_TIMER_WIDTH - 32
		)
		port map (
			clk => clk,
			resetn => resetn,
			out_interrupt => interrupt,
			avalon_address => avalon_ic_address,
			avalon_readdata => avalon_ic_readdata,
			avalon_readdatavalid => avalon_ic_readdatavalid,
			avalon_read => avalon_ic_read,
			avalon_write => avalon_ic_write,
			avalon_writedata => avalon_ic_writedata,
			avalon_waitrequest => avalon_ic_waitrequest,
			in_interrupts => interrupts
		);

	

	-- ibus
	avalon_ibus_address <= ibus_adr;
	avalon_ibus_read <= ibus_cyc;
	ibus_rdt <= avalon_ibus_readdata;
	ibus_ack <= avalon_ibus_readdatavalid and not avalon_ibus_waitrequest and ibus_cyc;
	-- dbus
	avalon_dbus_address <= dbus_adr;
	avalon_dbus_byteenable <= dbus_sel;
	avalon_dbus_read <= dbus_cyc when dbus_we = '0' else '0';
	dbus_rdt <= avalon_dbus_readdata;
	avalon_dbus_write <= dbus_cyc when dbus_we = '1' else '0';
	avalon_dbus_writedata <= dbus_dat;
	dbus_ack <=
			avalon_dbus_readdatavalid when dbus_we = '0' and dbus_cyc = '1' else
			'1' when dbus_we = '1' and avalon_dbus_waitrequest = '0' and dbus_cyc = '1' else
			'0';

end architecture rtl;
