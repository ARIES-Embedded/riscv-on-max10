library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ServInterruptController is
	generic (
		C_INTERRUPTS : natural range 1 to 32 := 8;
		C_TIMER_HIGH_WIDTH : natural range 1 to 32 := 32
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
		in_interrupts        : in std_logic_vector(7 downto 0)
	);
end entity ServInterruptController;

-- register map:
-- 0000 RW interrupt enable set / interrupt enable
-- 0001 RW interrupt enable clear / interrupt pending
-- 0010 RW ext interrupt enable
-- 0011 R  ext interrupt pending
-- 0100 R  mtime-l
-- 0101 R  mtime-h-latched
-- 0110 RW mtimecmp-l
-- 0111 RW mtimecmp-h-latched
-- 1000 RW softirq

architecture rtl of ServInterruptController is

	signal interrupt : std_logic := '0';
	signal read_bounce : std_logic := '0';

	signal interrupt_enable : std_logic_vector(2 downto 0) := (others => '0');
	signal interrupt_pending : std_logic_vector(2 downto 0) := (others => '0');
	signal ext_interrupt_enable : std_logic_vector(C_INTERRUPTS-1 downto 0) := (others => '0');
	signal mtime : std_logic_vector(C_TIMER_HIGH_WIDTH+31 downto 0) := (others => '0');
	signal mtime_latch : std_logic_vector(C_TIMER_HIGH_WIDTH-1 downto 0) := (others => '0');
	signal mtimecmp : std_logic_vector(C_TIMER_HIGH_WIDTH+31 downto 0) := (others => '0');
	signal mtimecmp_latch : std_logic_vector(C_TIMER_HIGH_WIDTH-1 downto 0) := (others => '0');

begin

	process (clk, resetn) begin

		if (rising_edge(clk)) then

			mtime <= std_logic_vector(unsigned(mtime) + 1);

			if (avalon_write = '1') then

				case avalon_address is
					when "0000" => interrupt_enable <= (avalon_writedata(11) & avalon_writedata(7) & avalon_writedata(3)) or interrupt_enable;
					when "0001" => interrupt_enable <= (not (avalon_writedata(11) & avalon_writedata(7) & avalon_writedata(3))) and interrupt_enable;
					when "0010" => ext_interrupt_enable <= avalon_writedata(C_INTERRUPTS-1 downto 0);
					when "0110" => mtimecmp <= mtimecmp_latch & avalon_writedata;
					when "0111" => mtimecmp_latch <= avalon_writedata(C_TIMER_HIGH_WIDTH-1 downto 0);
					-- when "1000" => interrupt_pending(0) <= '0' when avalon_writedata = x"00000000" else '1';
					when others => null;
				end case;

				-- conditional assigment while inside case statement possible?
				if (avalon_address = "1000") then
					if (avalon_writedata = x"00000000") then
						interrupt_pending(0) <= '0';
					else 
						interrupt_pending(0) <= '1';
					end if;
				end if;

			end if;

			if (avalon_read = '1' and read_bounce = '0') then

				-- all non implemented bits during read are set to 0
				avalon_readdata <= x"00000000";

				case avalon_address is
					when "0000" => 
						avalon_readdata(11) <= interrupt_enable(2);
						avalon_readdata(7) <= interrupt_enable(1);
						avalon_readdata(3) <= interrupt_enable(0);
					when "0001" => 
						avalon_readdata(11) <= interrupt_pending(2);
						avalon_readdata(7) <= interrupt_pending(1);
						avalon_readdata(3) <= interrupt_pending(0);
					when "0010" => avalon_readdata(7 downto 0) <= ext_interrupt_enable;
					when "0011" => avalon_readdata(7 downto 0) <= in_interrupts;
					when "0100" => 
						avalon_readdata <= mtime(31 downto 0);
						mtime_latch <= mtime(C_TIMER_HIGH_WIDTH+31 downto 32);
					when "0101" => avalon_readdata(C_TIMER_HIGH_WIDTH-1 downto 0) <= mtime_latch;
					when "0110" => avalon_readdata <= mtimecmp(31 downto 0);
					when "0111" => avalon_readdata(C_TIMER_HIGH_WIDTH-1  downto 0) <= mtimecmp_latch;
					when "1000" => avalon_readdata(0) <= interrupt_pending(0);
					when others => avalon_readdata <= x"00000000";
				end case;
				read_bounce <= '1';
				avalon_readdatavalid <= '1';
			else
				read_bounce <= '0';
				avalon_readdatavalid <= '0';
			end if;

			if (resetn = '0') then
				interrupt            <= '0';
				interrupt_enable     <= (others => '0');
				ext_interrupt_enable <= (others => '0');
				mtime                <= (others => '0');
				mtime_latch          <= (others => '0');
				mtimecmp             <= (others => '0');
				mtimecmp_latch       <= (others => '0');
				interrupt_pending(0) <= '0';
			end if;

		end if;

	end process;

	interrupt_pending(1) <= '0' when (unsigned(mtime) < unsigned(mtimecmp)) else '1';
	interrupt_pending(2) <= '0' when (in_interrupts and ext_interrupt_enable) = "00000000" else '1';

	out_interrupt <= '0' when (interrupt_pending and interrupt_enable) = "000" else '1';

end architecture rtl;
