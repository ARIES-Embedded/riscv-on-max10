library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity MX10 is
	port (
		clk25    : in  std_logic;
		resetn   : in  std_logic;
		button   : in  std_logic_vector(1 downto 0);
		led_base : out std_logic_vector(1 downto 0);
		led_mx10 : out std_logic_vector(1 downto 0);
		uart_tx  : out std_logic;
		uart_rx  : in  std_logic;
		pmod_j2  : inout std_logic_vector(7 downto 0);
		pmod_j3  : inout std_logic_vector(7 downto 0);
		pmod_j4  : inout std_logic_vector(7 downto 0);
		pmod_j5  : inout std_logic_vector(7 downto 0);

		ddr3_a       : out   std_logic_vector(15 downto 0);
		ddr3_ba      : out   std_logic_vector(2 downto 0);
		ddr3_ck      : inout std_logic_vector(0 downto 0) := (others => 'X');
		ddr3_ck_n    : inout std_logic_vector(0 downto 0) := (others => 'X');
		ddr3_cke     : out   std_logic_vector(0 downto 0);
		ddr3_cs_n    : out   std_logic_vector(0 downto 0);
		ddr3_dm      : out   std_logic_vector(0 downto 0);
		ddr3_ras_n   : out   std_logic_vector(0 downto 0);
		ddr3_cas_n   : out   std_logic_vector(0 downto 0);
		ddr3_we_n    : out   std_logic_vector(0 downto 0);
		ddr3_reset_n : out   std_logic;
		ddr3_dq      : inout std_logic_vector(7 downto 0) := (others => 'X');
		ddr3_dqs     : inout std_logic_vector(0 downto 0) := (others => 'X');
		ddr3_dqs_n   : inout std_logic_vector(0 downto 0) := (others => 'X');
		ddr3_odt     : out   std_logic_vector(0 downto 0)

	);
end entity MX10;



architecture rtl of MX10 is

	signal counter : integer range 1 to 12500000 := 1;
	signal led : std_logic := '0';

	signal gpio : std_logic_vector(31 downto 0);

	signal sysclk : std_logic;
	signal reset_n : std_logic := '0';
	signal reset_counter : integer range 0 to 25000000 := 25000000;

	signal jtag_tck : std_logic;
	signal jtag_tms : std_logic;
	signal jtag_tdo : std_logic;
	signal jtag_tdi : std_logic;

	component qsys0 is
		port (
			clk_clk            : in    std_logic                     := 'X';             -- clk
			gpio_export        : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
			jtag_tms           : in    std_logic                     := 'X';             -- tms
			jtag_tdi           : in    std_logic                     := 'X';             -- tdi
			jtag_tdo           : out   std_logic;                                        -- tdo
			jtag_tck           : in    std_logic                     := 'X';             -- tck
			reset_reset_n      : in    std_logic                     := 'X';             -- reset_n
			uart_rxd           : in    std_logic                     := 'X';             -- rxd
			uart_txd           : out   std_logic;                                        -- txd
			memory_mem_a       : out   std_logic_vector(15 downto 0);                    -- mem_a
			memory_mem_ba      : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck      : inout std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_ck
			memory_mem_ck_n    : inout std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_ck_n
			memory_mem_cke     : out   std_logic_vector(0 downto 0);                     -- mem_cke
			memory_mem_cs_n    : out   std_logic_vector(0 downto 0);                     -- mem_cs_n
			memory_mem_dm      : out   std_logic_vector(0 downto 0);                     -- mem_dm
			memory_mem_ras_n   : out   std_logic_vector(0 downto 0);                     -- mem_ras_n
			memory_mem_cas_n   : out   std_logic_vector(0 downto 0);                     -- mem_cas_n
			memory_mem_we_n    : out   std_logic_vector(0 downto 0);                     -- mem_we_n
			memory_mem_reset_n : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq      : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs     : inout std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n   : inout std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt     : out   std_logic_vector(0 downto 0)                     -- mem_odt
		);
	end component qsys0;

begin

	u0 : component qsys0
		port map (
			clk_clk       => sysclk,       --   clk.clk
			reset_reset_n => reset_n, -- reset.reset_n
			jtag_tms      => jtag_tms,      --  jtag.tms
			jtag_tdi      => jtag_tdi,      --      .tdi
			jtag_tdo      => jtag_tdo,      --      .tdo
			jtag_tck      => jtag_tck,      --      .tck
			gpio_export   => gpio,   --  gpio.export
			uart_rxd      => uart_rx,      --  uart.rxd
			uart_txd      => uart_tx,

			memory_mem_a       => ddr3_a(15 downto 0),
			memory_mem_ba      => ddr3_ba,
			memory_mem_ck      => ddr3_ck,
			memory_mem_ck_n    => ddr3_ck_n,
			memory_mem_cke     => ddr3_cke,
			memory_mem_cs_n    => ddr3_cs_n,
			memory_mem_dm      => ddr3_dm,
			memory_mem_ras_n   => ddr3_ras_n,
			memory_mem_cas_n   => ddr3_cas_n,
			memory_mem_we_n    => ddr3_we_n,
			memory_mem_reset_n => ddr3_reset_n,
			memory_mem_dq      => ddr3_dq,
			memory_mem_dqs     => ddr3_dqs,
			memory_mem_dqs_n   => ddr3_dqs_n,
			memory_mem_odt     => ddr3_odt
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

	process (clk25) begin
		-- after user-reset or bootup hold system in reset for 1 second
		if (rising_edge(clk25)) then
			if (reset_counter > 0) then
				reset_counter <= reset_counter - 1;
			else
				reset_n <= '1';
			end if;
			if (resetn = '0') then
				reset_n <= '0';
				reset_counter <= 25000000;
			end if;
		end if;
	end process;

	led_mx10(1) <= led;
	pmod_j2(7 downto 0) <= gpio(7 downto 0);
	
	sysclk <= clk25;

end architecture rtl;
