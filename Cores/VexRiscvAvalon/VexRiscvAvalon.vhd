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

-- VHDL Wrapper for VexRiscv
-- Different configurations can be selected via Qsys parameter
-- Includes utime counter

-- (0) RV32I
-- (1) RV32IM
-- (2) RV32IM, Caches
-- (3) RV32IMC, Caches
-- (4) RV32IMAFC, Caches

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VexRiscvAvalon is
	generic (
		C_RESET_VECTOR : std_logic_vector(31 downto 0);
		C_EXCEPTION_VECTOR : std_logic_vector(31 downto 0);
		C_IO_BEGIN : std_logic_vector(31 downto 0);
		C_IO_END : std_logic_vector(31 downto 0);
		CORE_CONFIG : natural
	);
	port (
		-- common
		clk   : in std_logic;
		reset : in std_logic; -- active high

		-- debug
		jtag_tck       : in  std_logic;
		jtag_tms       : in  std_logic;
		jtag_tdi       : in  std_logic;
		jtag_tdo       : out std_logic;

		-- avalon
		iBusAvalon_read          : out std_logic;
		iBusAvalon_waitRequestn  : in  std_logic;
		iBusAvalon_address       : out std_logic_vector(31 downto 0);
		iBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
		iBusAvalon_response      : in  std_logic;
		iBusAvalon_readDataValid : in  std_logic;
		iBusAvalon_readData      : in  std_logic_vector(31 downto 0);
		dBusAvalon_read          : out std_logic;
		dBusAvalon_write         : out std_logic;
		dBusAvalon_waitRequestn  : in  std_logic;
		dBusAvalon_address       : out std_logic_vector(31 downto 0);
		dBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
		dBusAvalon_byteEnable    : out std_logic_vector( 3 downto 0);
		dBusAvalon_writeData     : out std_logic_vector(31 downto 0);
		dBusAvalon_response      : in  std_logic;
		dBusAvalon_readDataValid : in  std_logic;
		dBusAvalon_readData      : in  std_logic_vector(31 downto 0);

		-- avalon interrupt controller
		ic_avalon_address : in std_logic_vector(3 downto 0);
		ic_avalon_write : in std_logic;
		ic_avalon_writedata : in std_logic_vector(31 downto 0);
		ic_avalon_read : in std_logic;
		ic_avalon_readdata : out std_logic_vector(31 downto 0);
		ic_avalon_readdatavalid : out std_logic;
		ic_avalon_waitrequest : out std_logic;
		irq_source : in std_logic_vector (31 downto 0)

	);
end entity VexRiscvAvalon;

architecture rtl of VexRiscvAvalon is

	signal utime : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal irq_soft : std_logic := '0';
	signal irq_timer : std_logic := '0';
	signal irq_external : std_logic := '0';
	signal reset_debug : std_logic := '0';

	component VexInterruptController is
		port (
			clk     : in  std_logic;
			resetn  : in  std_logic;
	
			irq_source : in std_logic_vector(31 downto 0);
			ext_irq : out std_logic;
			tmr_irq : out std_logic;
			sft_irq : out std_logic;
	
			avalon_address : in std_logic_vector(3 downto 0);
			avalon_write : in std_logic;
			avalon_writedata : in std_logic_vector(31 downto 0);
			avalon_read : in std_logic;
			avalon_readdata : out std_logic_vector(31 downto 0);
			avalon_readdatavalid : out std_logic;
			avalon_waitrequest : out std_logic
		);
	end component VexInterruptController;

	component VexRiscvAvalon_0 is
		generic (
			C_RESET_VECTOR : std_logic_vector(31 downto 0);
			C_EXCEPTION_VECTOR : std_logic_vector(31 downto 0);
			C_IO_BEGIN : std_logic_vector(31 downto 0);
			C_IO_END : std_logic_vector(31 downto 0)
		);
		port (
			-- common
			clk   : in std_logic;
			reset : in std_logic;

			-- debug
			debugReset     : in  std_logic;
			jtag_tck       : in  std_logic;
			jtag_tms       : in  std_logic;
			jtag_tdi       : in  std_logic;
			jtag_tdo       : out std_logic;
			debug_resetOut : out std_logic;

			-- riscv
			timerInterrupt    : in std_logic;
			softwareInterrupt : in std_logic;
			externalInterrupt : in std_logic;
			utime             : in std_logic_vector(63 downto 0);

			-- avalon
			iBusAvalon_read          : out std_logic;
			iBusAvalon_waitRequestn  : in  std_logic;
			iBusAvalon_address       : out std_logic_vector(31 downto 0);
			iBusAvalon_response      : in  std_logic;
			iBusAvalon_readDataValid : in  std_logic;
			iBusAvalon_readData      : in  std_logic_vector(31 downto 0);
			dBusAvalon_read          : out std_logic;
			dBusAvalon_write         : out std_logic;
			dBusAvalon_waitRequestn  : in  std_logic;
			dBusAvalon_address       : out std_logic_vector(31 downto 0);
			dBusAvalon_byteEnable    : out std_logic_vector( 3 downto 0);
			dBusAvalon_writeData     : out std_logic_vector(31 downto 0);
			dBusAvalon_response      : in  std_logic;
			dBusAvalon_readDataValid : in  std_logic;
			dBusAvalon_readData      : in  std_logic_vector(31 downto 0)
		);
	end component VexRiscvAvalon_0;

	component VexRiscvAvalon_1 is
		generic (
			C_RESET_VECTOR : std_logic_vector(31 downto 0);
			C_EXCEPTION_VECTOR : std_logic_vector(31 downto 0);
			C_IO_BEGIN : std_logic_vector(31 downto 0);
			C_IO_END : std_logic_vector(31 downto 0)
		);
		port (
			-- common
			clk   : in std_logic;
			reset : in std_logic;

			-- debug
			debugReset     : in  std_logic;
			jtag_tck       : in  std_logic;
			jtag_tms       : in  std_logic;
			jtag_tdi       : in  std_logic;
			jtag_tdo       : out std_logic;
			debug_resetOut : out std_logic;

			-- riscv
			timerInterrupt    : in std_logic;
			softwareInterrupt : in std_logic;
			externalInterrupt : in std_logic;
			utime             : in std_logic_vector(63 downto 0);

			-- avalon
			iBusAvalon_read          : out std_logic;
			iBusAvalon_waitRequestn  : in  std_logic;
			iBusAvalon_address       : out std_logic_vector(31 downto 0);
			iBusAvalon_response      : in  std_logic;
			iBusAvalon_readDataValid : in  std_logic;
			iBusAvalon_readData      : in  std_logic_vector(31 downto 0);
			dBusAvalon_read          : out std_logic;
			dBusAvalon_write         : out std_logic;
			dBusAvalon_waitRequestn  : in  std_logic;
			dBusAvalon_address       : out std_logic_vector(31 downto 0);
			dBusAvalon_byteEnable    : out std_logic_vector( 3 downto 0);
			dBusAvalon_writeData     : out std_logic_vector(31 downto 0);
			dBusAvalon_response      : in  std_logic;
			dBusAvalon_readDataValid : in  std_logic;
			dBusAvalon_readData      : in  std_logic_vector(31 downto 0)
		);
	end component VexRiscvAvalon_1;

	component VexRiscvAvalon_2 is
		generic (
			C_RESET_VECTOR : std_logic_vector(31 downto 0);
			C_EXCEPTION_VECTOR : std_logic_vector(31 downto 0);
			C_IO_BEGIN : std_logic_vector(31 downto 0);
			C_IO_END : std_logic_vector(31 downto 0)
		);
		port (
			-- common
			clk   : in std_logic;
			reset : in std_logic;

			-- debug
			debugReset     : in  std_logic;
			jtag_tck       : in  std_logic;
			jtag_tms       : in  std_logic;
			jtag_tdi       : in  std_logic;
			jtag_tdo       : out std_logic;
			debug_resetOut : out std_logic;

			-- riscv
			timerInterrupt    : in std_logic;
			softwareInterrupt : in std_logic;
			externalInterrupt : in std_logic;
			utime             : in std_logic_vector(63 downto 0);

			-- avalon
			iBusAvalon_read          : out std_logic;
			iBusAvalon_waitRequestn  : in  std_logic;
			iBusAvalon_address       : out std_logic_vector(31 downto 0);
			iBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
			iBusAvalon_response      : in  std_logic;
			iBusAvalon_readDataValid : in  std_logic;
			iBusAvalon_readData      : in  std_logic_vector(31 downto 0);
			dBusAvalon_read          : out std_logic;
			dBusAvalon_write         : out std_logic;
			dBusAvalon_waitRequestn  : in  std_logic;
			dBusAvalon_address       : out std_logic_vector(31 downto 0);
			dBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
			dBusAvalon_byteEnable    : out std_logic_vector( 3 downto 0);
			dBusAvalon_writeData     : out std_logic_vector(31 downto 0);
			dBusAvalon_response      : in  std_logic;
			dBusAvalon_readDataValid : in  std_logic;
			dBusAvalon_readData      : in  std_logic_vector(31 downto 0)
		);
	end component VexRiscvAvalon_2;

	component VexRiscvAvalon_3 is
		generic (
			C_RESET_VECTOR : std_logic_vector(31 downto 0);
			C_EXCEPTION_VECTOR : std_logic_vector(31 downto 0);
			C_IO_BEGIN : std_logic_vector(31 downto 0);
			C_IO_END : std_logic_vector(31 downto 0)
		);
		port (
			-- common
			clk   : in std_logic;
			reset : in std_logic;

			-- debug
			debugReset     : in  std_logic;
			jtag_tck       : in  std_logic;
			jtag_tms       : in  std_logic;
			jtag_tdi       : in  std_logic;
			jtag_tdo       : out std_logic;
			debug_resetOut : out std_logic;

			-- riscv
			timerInterrupt    : in std_logic;
			softwareInterrupt : in std_logic;
			externalInterrupt : in std_logic;
			utime             : in std_logic_vector(63 downto 0);

			-- avalon
			iBusAvalon_read          : out std_logic;
			iBusAvalon_waitRequestn  : in  std_logic;
			iBusAvalon_address       : out std_logic_vector(31 downto 0);
			iBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
			iBusAvalon_response      : in  std_logic;
			iBusAvalon_readDataValid : in  std_logic;
			iBusAvalon_readData      : in  std_logic_vector(31 downto 0);
			dBusAvalon_read          : out std_logic;
			dBusAvalon_write         : out std_logic;
			dBusAvalon_waitRequestn  : in  std_logic;
			dBusAvalon_address       : out std_logic_vector(31 downto 0);
			dBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
			dBusAvalon_byteEnable    : out std_logic_vector( 3 downto 0);
			dBusAvalon_writeData     : out std_logic_vector(31 downto 0);
			dBusAvalon_response      : in  std_logic;
			dBusAvalon_readDataValid : in  std_logic;
			dBusAvalon_readData      : in  std_logic_vector(31 downto 0)
		);
	end component VexRiscvAvalon_3;

	component VexRiscvAvalon_4 is
		generic (
			C_RESET_VECTOR : std_logic_vector(31 downto 0);
			C_EXCEPTION_VECTOR : std_logic_vector(31 downto 0);
			C_IO_BEGIN : std_logic_vector(31 downto 0);
			C_IO_END : std_logic_vector(31 downto 0)
		);
		port (
			-- common
			clk   : in std_logic;
			reset : in std_logic;

			-- debug
			debugReset     : in  std_logic;
			jtag_tck       : in  std_logic;
			jtag_tms       : in  std_logic;
			jtag_tdi       : in  std_logic;
			jtag_tdo       : out std_logic;
			debug_resetOut : out std_logic;

			-- riscv
			timerInterrupt    : in std_logic;
			softwareInterrupt : in std_logic;
			externalInterrupt : in std_logic;
			utime             : in std_logic_vector(63 downto 0);

			-- avalon
			iBusAvalon_read          : out std_logic;
			iBusAvalon_waitRequestn  : in  std_logic;
			iBusAvalon_address       : out std_logic_vector(31 downto 0);
			iBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
			iBusAvalon_response      : in  std_logic;
			iBusAvalon_readDataValid : in  std_logic;
			iBusAvalon_readData      : in  std_logic_vector(31 downto 0);
			dBusAvalon_read          : out std_logic;
			dBusAvalon_write         : out std_logic;
			dBusAvalon_waitRequestn  : in  std_logic;
			dBusAvalon_address       : out std_logic_vector(31 downto 0);
			dBusAvalon_burstCount    : out std_logic_vector( 3 downto 0);
			dBusAvalon_byteEnable    : out std_logic_vector( 3 downto 0);
			dBusAvalon_writeData     : out std_logic_vector(31 downto 0);
			dBusAvalon_response      : in  std_logic;
			dBusAvalon_readDataValid : in  std_logic;
			dBusAvalon_readData      : in  std_logic_vector(31 downto 0)
		);
	end component VexRiscvAvalon_4;

begin

	ic0 : component VexInterruptController
		port map (
			clk => clk,
			resetn => not reset,
			irq_source => irq_source,
			ext_irq => irq_external,
			tmr_irq => irq_timer,
			sft_irq => irq_soft,
			avalon_address => ic_avalon_address,
			avalon_write => ic_avalon_write,
			avalon_writedata => ic_avalon_writedata,
			avalon_read => ic_avalon_read,
			avalon_readdata => ic_avalon_readdata,
			avalon_readdatavalid => ic_avalon_readdatavalid,
			avalon_waitrequest => ic_avalon_waitrequest
		);

	r0 : if CORE_CONFIG = 0 generate
		vex0 : component VexRiscvAvalon_0
			generic map (
				C_RESET_VECTOR => C_RESET_VECTOR,
				C_EXCEPTION_VECTOR => C_EXCEPTION_VECTOR,
				C_IO_BEGIN => C_IO_BEGIN,
				C_IO_END => C_IO_END
			)
			port map (
				clk => clk,
				reset => reset or reset_debug,
				debugReset => reset,
				jtag_tck => jtag_tck,
				jtag_tms => jtag_tms,
				jtag_tdi => jtag_tdi,
				jtag_tdo => jtag_tdo,
				debug_resetOut => reset_debug,
				timerInterrupt => irq_timer,
				softwareInterrupt => irq_soft,
				externalInterrupt => irq_external,
				utime => utime,
				iBusAvalon_read => iBusAvalon_read,
				iBusAvalon_waitRequestn => iBusAvalon_waitRequestn,
				iBusAvalon_address => iBusAvalon_address,
				iBusAvalon_response => iBusAvalon_response,
				iBusAvalon_readDataValid => iBusAvalon_readDataValid,
				iBusAvalon_readData => iBusAvalon_readData,
				dBusAvalon_read => dBusAvalon_read,
				dBusAvalon_write => dBusAvalon_write,
				dBusAvalon_waitRequestn => dBusAvalon_waitRequestn,
				dBusAvalon_address => dBusAvalon_address,
				dBusAvalon_byteEnable => dBusAvalon_byteEnable,
				dBusAvalon_writeData => dBusAvalon_writeData,
				dBusAvalon_response => dBusAvalon_response,
				dBusAvalon_readDataValid => dBusAvalon_readDataValid,
				dBusAvalon_readData => dBusAvalon_readData
			);
	end generate r0;

	r1 : if CORE_CONFIG = 1 generate
		vex0 : component VexRiscvAvalon_1
			generic map (
				C_RESET_VECTOR => C_RESET_VECTOR,
				C_EXCEPTION_VECTOR => C_EXCEPTION_VECTOR,
				C_IO_BEGIN => C_IO_BEGIN,
				C_IO_END => C_IO_END
			)
			port map(
				clk => clk,
				reset => reset or reset_debug,
				debugReset => reset,
				jtag_tck => jtag_tck,
				jtag_tms => jtag_tms,
				jtag_tdi => jtag_tdi,
				jtag_tdo => jtag_tdo,
				debug_resetOut => reset_debug,
				timerInterrupt => irq_timer,
				softwareInterrupt => irq_soft,
				externalInterrupt => irq_external,
				utime => utime,
				iBusAvalon_read => iBusAvalon_read,
				iBusAvalon_waitRequestn => iBusAvalon_waitRequestn,
				iBusAvalon_address => iBusAvalon_address,
				iBusAvalon_response => iBusAvalon_response,
				iBusAvalon_readDataValid => iBusAvalon_readDataValid,
				iBusAvalon_readData => iBusAvalon_readData,
				dBusAvalon_read => dBusAvalon_read,
				dBusAvalon_write => dBusAvalon_write,
				dBusAvalon_waitRequestn => dBusAvalon_waitRequestn,
				dBusAvalon_address => dBusAvalon_address,
				dBusAvalon_byteEnable => dBusAvalon_byteEnable,
				dBusAvalon_writeData => dBusAvalon_writeData,
				dBusAvalon_response => dBusAvalon_response,
				dBusAvalon_readDataValid => dBusAvalon_readDataValid,
				dBusAvalon_readData => dBusAvalon_readData
			);
	end generate r1;

	r2 : if CORE_CONFIG = 2 generate
		vex0 : component VexRiscvAvalon_2
			generic map (
				C_RESET_VECTOR => C_RESET_VECTOR,
				C_EXCEPTION_VECTOR => C_EXCEPTION_VECTOR,
				C_IO_BEGIN => C_IO_BEGIN,
				C_IO_END => C_IO_END
			)
			port map(
				clk => clk,
				reset => reset or reset_debug,
				debugReset => reset,
				jtag_tck => jtag_tck,
				jtag_tms => jtag_tms,
				jtag_tdi => jtag_tdi,
				jtag_tdo => jtag_tdo,
				debug_resetOut => reset_debug,
				timerInterrupt => irq_timer,
				softwareInterrupt => irq_soft,
				externalInterrupt => irq_external,
				utime => utime,
				iBusAvalon_read => iBusAvalon_read,
				iBusAvalon_waitRequestn => iBusAvalon_waitRequestn,
				iBusAvalon_address => iBusAvalon_address,
				iBusAvalon_burstCount => iBusAvalon_burstCount,
				iBusAvalon_response => iBusAvalon_response,
				iBusAvalon_readDataValid => iBusAvalon_readDataValid,
				iBusAvalon_readData => iBusAvalon_readData,
				dBusAvalon_read => dBusAvalon_read,
				dBusAvalon_write => dBusAvalon_write,
				dBusAvalon_waitRequestn => dBusAvalon_waitRequestn,
				dBusAvalon_address => dBusAvalon_address,
				dBusAvalon_response => dBusAvalon_response,
				dBusAvalon_byteEnable => dBusAvalon_byteEnable,
				dBusAvalon_writeData => dBusAvalon_writeData,
				dBusAvalon_burstCount => dBusAvalon_burstCount,
				dBusAvalon_readDataValid => dBusAvalon_readDataValid,
				dBusAvalon_readData => dBusAvalon_readData
			);
	end generate r2;

	r3 : if CORE_CONFIG = 3 generate
		vex0 : component VexRiscvAvalon_3
			generic map (
				C_RESET_VECTOR => C_RESET_VECTOR,
				C_EXCEPTION_VECTOR => C_EXCEPTION_VECTOR,
				C_IO_BEGIN => C_IO_BEGIN,
				C_IO_END => C_IO_END
			)
			port map(
				clk => clk,
				reset => reset or reset_debug,
				debugReset => reset,
				jtag_tck => jtag_tck,
				jtag_tms => jtag_tms,
				jtag_tdi => jtag_tdi,
				jtag_tdo => jtag_tdo,
				debug_resetOut => reset_debug,
				timerInterrupt => irq_timer,
				softwareInterrupt => irq_soft,
				externalInterrupt => irq_external,
				utime => utime,
				iBusAvalon_read => iBusAvalon_read,
				iBusAvalon_waitRequestn => iBusAvalon_waitRequestn,
				iBusAvalon_address => iBusAvalon_address,
				iBusAvalon_burstCount => iBusAvalon_burstCount,
				iBusAvalon_response => iBusAvalon_response,
				iBusAvalon_readDataValid => iBusAvalon_readDataValid,
				iBusAvalon_readData => iBusAvalon_readData,
				dBusAvalon_read => dBusAvalon_read,
				dBusAvalon_write => dBusAvalon_write,
				dBusAvalon_waitRequestn => dBusAvalon_waitRequestn,
				dBusAvalon_address => dBusAvalon_address,
				dBusAvalon_burstCount => dBusAvalon_burstCount,
				dBusAvalon_byteEnable => dBusAvalon_byteEnable,
				dBusAvalon_writeData => dBusAvalon_writeData,
				dBusAvalon_response => dBusAvalon_response,
				dBusAvalon_readDataValid => dBusAvalon_readDataValid,
				dBusAvalon_readData => dBusAvalon_readData
			);
	end generate r3;

	r4 : if CORE_CONFIG = 4 generate
		vex0 : component VexRiscvAvalon_4
			generic map (
				C_RESET_VECTOR => C_RESET_VECTOR,
				C_EXCEPTION_VECTOR => C_EXCEPTION_VECTOR,
				C_IO_BEGIN => C_IO_BEGIN,
				C_IO_END => C_IO_END
			)
			port map(
				clk => clk,
				reset => reset or reset_debug,
				debugReset => reset,
				jtag_tck => jtag_tck,
				jtag_tms => jtag_tms,
				jtag_tdi => jtag_tdi,
				jtag_tdo => jtag_tdo,
				debug_resetOut => reset_debug,
				timerInterrupt => irq_timer,
				softwareInterrupt => irq_soft,
				externalInterrupt => irq_external,
				utime => utime,
				iBusAvalon_read => iBusAvalon_read,
				iBusAvalon_waitRequestn => iBusAvalon_waitRequestn,
				iBusAvalon_address => iBusAvalon_address,
				iBusAvalon_burstCount => iBusAvalon_burstCount,
				iBusAvalon_response => iBusAvalon_response,
				iBusAvalon_readDataValid => iBusAvalon_readDataValid,
				iBusAvalon_readData => iBusAvalon_readData,
				dBusAvalon_read => dBusAvalon_read,
				dBusAvalon_write => dBusAvalon_write,
				dBusAvalon_waitRequestn => dBusAvalon_waitRequestn,
				dBusAvalon_address => dBusAvalon_address,
				dBusAvalon_burstCount => dBusAvalon_burstCount,
				dBusAvalon_byteEnable => dBusAvalon_byteEnable,
				dBusAvalon_writeData => dBusAvalon_writeData,
				dBusAvalon_response => dBusAvalon_response,
				dBusAvalon_readDataValid => dBusAvalon_readDataValid,
				dBusAvalon_readData => dBusAvalon_readData
			);
	end generate r4;

	process (clk) begin
		if (clk = '1' and clk'EVENT) then
			utime <= std_logic_vector(unsigned(utime) + 1);
		end if;
	end process;

end architecture rtl;
