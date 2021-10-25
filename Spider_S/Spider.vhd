library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity Spider is
	port (
		clk25	: in  std_logic;
		resetn  : in  std_logic;
		button	: in  std_logic_vector(1 downto 0);
		led_base	    : out std_logic_vector(1 downto 0);
		led_module    : out std_logic_vector(1 downto 0);
		uart_tx : out std_logic;
		uart_rx : in  std_logic;
		pmod_j2 : inout std_logic_vector(7 downto 0);
		pmod_j3 : inout std_logic_vector(7 downto 0);
		pmod_j4 : inout std_logic_vector(7 downto 0);
		pmod_j5 : inout std_logic_vector(7 downto 0)
	);
end entity Spider;



architecture rtl of Spider is

	signal counter : integer range 1 to 12500000 := 1;
	signal led : std_logic := '0';
	signal sysclk : std_logic := '0';
	signal gpio : std_logic_vector(31 downto 0) := x"00000000";

	component qsys0 is
		port (
			clk_clk       : in    std_logic                     := 'X';             -- clk
			reset_reset_n : in    std_logic                     := 'X';             -- reset_n
			gpio_export   : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
			uart_rxd      : in    std_logic                     := 'X';             -- rxd
			uart_txd      : out   std_logic                                         -- txd
		);
	end component qsys0;

begin

	u0 : component qsys0
		port map (
			clk_clk       => clk25,       --   clk.clk
			reset_reset_n => resetn, -- reset.reset_n
			gpio_export   => gpio,   --  gpio.export
			uart_rxd      => uart_rx,      --  uart.rxd
			uart_txd      => uart_tx
		);

	process (sysclk) begin
		if (sysclk = '1' and sysclk'EVENT) then
			if (counter < 12500000) then
				counter <= counter + 1;
			else
				led <= not led;
				counter <= 1;
			end if;
		end if;
	end process;

	sysclk <= clk25;
	led_module(1) <= led;
	pmod_j2 <= gpio(7 downto 0);

end architecture rtl;
