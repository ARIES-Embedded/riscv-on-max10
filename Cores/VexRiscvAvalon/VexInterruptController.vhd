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

-- Simple Interrupt Controller to be used with VexRiscv
-- Implements mtime/mtimecmp, 32 external interrupts
-- Connects to VexRiscv via 3 interrupt signals and avalon bus

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VexInterruptController is
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
end entity VexInterruptController;

-- addressing is by word (each 4 byte):
-- 0 => interrupt pending (R)
-- 1 => interrupt enable (RW)
-- 2 => mtime register LOW (RW)
-- 3 => mtime register HIGH (RW)
-- 4 => mtime register HIGH latch (R)
-- 5 => mtimecmp register LOW (RW)
-- 6 => mtimecmp register HIGH (RW)
-- 7 => mtimecmp register LOW latched (W)
-- 8 => mtimecmp register HIGH latched (RW)
-- 9 => software interrupt (RW)

-- reading mtime_low (2) will automatically copy the value of mtime_high(3) to mtime_latch (4)
-- mtime_latch (4) can then be read without any danger of rollover

-- mtimecmp_high_latch (8) can be written and read without any immediate effect
-- once mtimecmp_low_latch (7) is written, both values are copied to the mtimecmp register (5 6)
-- mtimecmp_low_latch (7) itself cannot be read as the write is directed to mtimecmp_low (5)

architecture rtl of VexInterruptController is

	-- signals
	signal interrupt_pending : std_logic_vector(31 downto 0);
	-- registers
	signal interrupt_enable  : std_logic_vector(31 downto 0) := x"00000000";
	signal mtime             : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal mtime_latch       : std_logic_vector(31 downto 0) := x"00000000";
	signal mtimecmp          : std_logic_vector(63 downto 0) := x"0000000000000000";
	signal mtimecmp_latch    : std_logic_vector(31 downto 0) := x"00000000";
	signal interrupt_soft    : std_logic_vector(31 downto 0) := x"00000000";

begin

	process (clk, resetn) begin

		if (clk = '1' and clk'EVENT) then

			mtime <= std_logic_vector(unsigned(mtime) + 1);

			if (avalon_write = '1') then
				case avalon_address is
					when "0001" => interrupt_enable <= avalon_writedata;
					when "0010" => mtime(31 downto 0) <= avalon_writedata;
					when "0011" => mtime(63 downto 32) <= avalon_writedata;
					when "0101" => mtimecmp(31 downto 0) <= avalon_writedata;
					when "0110" => mtimecmp(63 downto 32) <= avalon_writedata;
					when "0111" => mtimecmp <= mtimecmp_latch & avalon_writedata;
					when "1000" => mtimecmp_latch <= avalon_writedata;
					when "1001" => interrupt_soft <= avalon_writedata;
					when others => null;
				end case;
			end if;
			if (avalon_read = '1') then
				case avalon_address is
					when "0000" => avalon_readdata <= interrupt_pending;
					when "0001" => avalon_readdata <= interrupt_enable;
					when "0010" =>
						avalon_readdata <= mtime(31 downto 0);
						mtime_latch <= mtime(63 downto 32);
					when "0011" => avalon_readdata <= mtime(63 downto 32);
					when "0100" => avalon_readdata <= mtime_latch;
					when "0101" => avalon_readdata <= mtimecmp(31 downto 0);
					when "0110" => avalon_readdata <= mtimecmp(63 downto 32);
					when "1000" => avalon_readdata <= mtimecmp_latch;
					when "1001" => avalon_readdata <= interrupt_soft;
					when others => avalon_readdata <= x"00000000";
				end case;
				avalon_readdatavalid <= '1';
			else
				avalon_readdatavalid <= '0';
			end if;

		end if;

		if (resetn = '0') then
			interrupt_enable <= x"00000000";
			mtime            <= x"0000000000000000";
			mtime_latch      <= x"00000000";
			mtimecmp         <= x"0000000000000000";
			mtimecmp_latch   <= x"00000000";
			interrupt_soft   <= x"00000000";
		end if;

	end process;
	
	avalon_waitrequest <= '0';
	interrupt_pending <= irq_source;
	ext_irq <= '0' when (interrupt_pending and interrupt_enable) = x"00000000" else '1';
	tmr_irq <= '0' when (unsigned(mtime) < unsigned(mtimecmp)) else '1';
	sft_irq <= '0' when interrupt_soft = x"00000000" else '1';


end architecture rtl;
