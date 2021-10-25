library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity MX10 is
	port (
		clk25	: in  std_logic;
		resetn  : in  std_logic;
		button	: in  std_logic_vector(1 downto 0);
		led_base	    : out std_logic_vector(1 downto 0);
		led_MX10    : out std_logic_vector(1 downto 0);
		uart_tx : out std_logic;
		uart_rx : in  std_logic;
		pmod_j2 : inout std_logic_vector(7 downto 0);
		pmod_j3 : inout std_logic_vector(7 downto 0);
		pmod_j4 : inout std_logic_vector(7 downto 0);
		pmod_j5 : inout std_logic_vector(7 downto 0)
	);
end entity MX10;



architecture rtl of MX10 is

	signal counter : integer range 1 to 12500000 := 1;
	signal led_mod : std_logic := '0';

	signal gpio : std_logic_vector(31 downto 0);
	signal i_uart_tx : std_logic;
	signal i_uart_rx : std_logic;

	signal sysclk : std_logic;
	signal pllclk : std_logic;

	signal jtag_tck : std_logic;
	signal jtag_tms : std_logic;
	signal jtag_tdo : std_logic;
	signal jtag_tdi : std_logic;

	component qsys0 is
		port (
			clk_clk       : in    std_logic                     := 'X';             -- clk
			reset_reset_n : in    std_logic                     := 'X';             -- reset_n
			jtag_tms      : in    std_logic                     := 'X';             -- tms
			jtag_tdi      : in    std_logic                     := 'X';             -- tdi
			jtag_tdo      : out   std_logic;                                        -- tdo
			jtag_tck      : in    std_logic                     := 'X';             -- tck
			gpio_export   : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
			uart_rxd      : in    std_logic                     := 'X';             -- rxd
			uart_txd      : out   std_logic                                         -- txd
		);
	end component qsys0;

begin

	u0 : component qsys0
		port map (
			clk_clk       => sysclk,       --   clk.clk
			reset_reset_n => resetn, -- reset.reset_n
			jtag_tms      => jtag_tms,      --  jtag.tms
			jtag_tdi      => jtag_tdi,      --      .tdi
			jtag_tdo      => jtag_tdo,      --      .tdo
			jtag_tck      => jtag_tck,      --      .tck
			gpio_export   => gpio,   --  gpio.export
			uart_rxd      => i_uart_rx,      --  uart.rxd
			uart_txd      => i_uart_tx
		);

	process (sysclk) begin
		if (sysclk = '1' and sysclk'EVENT) then
			if (counter < 12500000) then
				counter <= counter + 1;
			else
				led_mod <= not led_mod;
				counter <= 1;
			end if;
		end if;
	end process;

	led_MX10(1) <= led_mod;
	pmod_j2(7 downto 0) <= gpio(7 downto 0);
	uart_tx <= i_uart_tx;
	i_uart_rx <= uart_rx;
	
	sysclk <= clk25;

end architecture rtl;
