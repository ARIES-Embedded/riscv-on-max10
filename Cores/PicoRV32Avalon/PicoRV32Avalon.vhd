library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PicoRV32Avalon is
	generic (
			ENABLE_COUNTERS : natural;
			ENABLE_COUNTERS64 : natural;
			ENABLE_REGS_16_31 : natural;
			ENABLE_REGS_DUALPORT : natural;
			-- LATCHED_MEM_RDATA : natural;
			TWO_STAGE_SHIFT : natural;
			BARREL_SHIFTER : natural;
			TWO_CYCLE_COMPARE : natural;
			TWO_CYCLE_ALU : natural;
			COMPRESSED_ISA : natural;
			CATCH_MISALIGN : natural;
			CATCH_ILLINSN : natural;
			-- ENABLE_PCPI : natural;
			ENABLE_MUL : natural;
			ENABLE_FAST_MUL : natural;
			ENABLE_DIV : natural;
			ENABLE_IRQ : natural;
			-- ENABLE_IRQ_QREGS : natural;
			-- ENABLE_IRQ_TIMER : natural;
			-- ENABLE_TRACE : natural;
			-- REGS_INIT_ZERO : natural;
			MASKED_IRQ : std_logic_vector;
			LATCHED_IRQ : std_logic_vector;
			RESET_VECTOR : std_logic_vector;
			INTERRUPT_VECTOR : std_logic_vector
			-- STACKADDR : std_logic_vector
		);
	port (
		clk   : in std_logic;
		resetn : in std_logic;
		trap : out std_logic;
		--Avalon data master
		avm_address       : out std_logic_vector(31 downto 0);
		avm_byteenable    : out std_logic_vector(3 downto 0);
		avm_read          : out std_logic;
		avm_readdata      : in  std_logic_vector(31 downto 0) := (others => '0');
		avm_write         : out std_logic;
		avm_writedata     : out std_logic_vector(31 downto 0);
		avm_waitrequest   : in  std_logic                                  := '0';
		avm_readdatavalid : in  std_logic                                  := '0';
		pico_interrupt : in std_logic_vector(31 downto 0) := (others => '0')
	);
end entity PicoRV32Avalon;

architecture rtl of PicoRV32Avalon is

	signal mem_prv_active : std_logic;
	signal mem_ava_read : std_logic;
	signal mem_ava_write : std_logic;
	signal mem_pico_done : std_logic;
	signal mem_gen_bten : std_logic_vector(3 downto 0);

	-- component linked to verilog module in picorv32.v
	component picorv32 is
		generic (
			ENABLE_COUNTERS : natural;
			ENABLE_COUNTERS64 : natural;
			ENABLE_REGS_16_31 : natural;
			ENABLE_REGS_DUALPORT : natural;
			LATCHED_MEM_RDATA : natural;
			TWO_STAGE_SHIFT : natural;
			BARREL_SHIFTER : natural;
			TWO_CYCLE_COMPARE : natural;
			TWO_CYCLE_ALU : natural;
			COMPRESSED_ISA : natural;
			CATCH_MISALIGN : natural;
			CATCH_ILLINSN : natural;
			ENABLE_PCPI : natural;
			ENABLE_MUL : natural;
			ENABLE_FAST_MUL : natural;
			ENABLE_DIV : natural;
			ENABLE_IRQ : natural;
			ENABLE_IRQ_QREGS : natural;
			ENABLE_IRQ_TIMER : natural;
			ENABLE_TRACE : natural;
			REGS_INIT_ZERO : natural;
			MASKED_IRQ : std_logic_vector;
			LATCHED_IRQ : std_logic_vector;
			PROGADDR_RESET : std_logic_vector;
			PROGADDR_IRQ : std_logic_vector;
			STACKADDR : std_logic_vector
		);
		port (
			clk : in std_logic;
			resetn : in std_logic;
			trap : out std_logic;
			mem_valid : out std_logic;
			mem_instr : out std_logic;
			mem_ready : in std_logic;
			mem_addr : out std_logic_vector(31 downto 0);
			mem_wdata : out std_logic_vector(31 downto 0);
			mem_wstrb : out std_logic_vector(3 downto 0);
			mem_rdata : in std_logic_vector(31 downto 0);
			mem_la_read : out std_logic;
			mem_la_write : out std_logic;
			mem_la_addr : out std_logic_vector(31 downto 0);
			mem_la_wdata : out std_logic_vector(31 downto 0);
			mem_la_wstrb : out std_logic_vector(3 downto 0);
			pcpi_valid : out std_logic;
			pcpi_insn : out std_logic_vector(31 downto 0);
			pcpi_rs1 : out std_logic_vector(31 downto 0);
			pcpi_rs2 : out std_logic_vector(31 downto 0);
			pcpi_wr : in std_logic;
			pcpi_rd : in std_logic_vector(31 downto 0);
			pcpi_wait : in std_logic;
			pcpi_ready : in std_logic;
			irq : in std_logic_vector(31 downto 0);
			eoi : out std_logic_vector(31 downto 0);
			trace_valid : out std_logic;
			trace_data : out std_logic_vector(35 downto 0)
		);
	end component picorv32;

begin

	picorv : component picorv32
	generic map (
		ENABLE_COUNTERS      => ENABLE_COUNTERS,
		ENABLE_COUNTERS64    => ENABLE_COUNTERS64,
		ENABLE_REGS_16_31    => ENABLE_REGS_16_31,
		ENABLE_REGS_DUALPORT => ENABLE_REGS_DUALPORT,
		LATCHED_MEM_RDATA    => 0,
		TWO_STAGE_SHIFT      => TWO_STAGE_SHIFT,
		BARREL_SHIFTER       => BARREL_SHIFTER,
		TWO_CYCLE_COMPARE    => TWO_CYCLE_COMPARE,
		TWO_CYCLE_ALU        => TWO_CYCLE_ALU,
		COMPRESSED_ISA       => COMPRESSED_ISA,
		CATCH_MISALIGN       => CATCH_MISALIGN,
		CATCH_ILLINSN        => CATCH_ILLINSN,
		ENABLE_PCPI          => 0,
		ENABLE_MUL           => ENABLE_MUL,
		ENABLE_FAST_MUL      => ENABLE_FAST_MUL,
		ENABLE_DIV           => ENABLE_DIV,
		ENABLE_IRQ           => ENABLE_IRQ,
		ENABLE_IRQ_QREGS     => 1,
		ENABLE_IRQ_TIMER     => 1,
		ENABLE_TRACE         => 0,
		REGS_INIT_ZERO       => 0,
		MASKED_IRQ           => MASKED_IRQ,
		LATCHED_IRQ          => LATCHED_IRQ,
		PROGADDR_RESET       => RESET_VECTOR,
		PROGADDR_IRQ         => INTERRUPT_VECTOR,
		STACKADDR            => "11111111111111111111111111111111"
	)
	port map (

		clk => clk,
		resetn => resetn,
		trap => trap,

		mem_valid => mem_prv_active,
		mem_instr => open,
		mem_ready => mem_pico_done,
		mem_addr => avm_address,
		mem_wdata => avm_writedata,
		mem_rdata => avm_readdata,
		mem_wstrb => mem_gen_bten,

		mem_la_read => open,
		mem_la_write => open,
		mem_la_addr => open,
		mem_la_wdata => open,
		mem_la_wstrb => open,

		pcpi_valid => open,
		pcpi_insn => open,
		pcpi_rs1 => open,
		pcpi_rs2 => open,
		pcpi_wr => '0',
		pcpi_rd => "00000000000000000000000000000000",
		pcpi_wait => '0',
		pcpi_ready => '0',

		irq => pico_interrupt,
		eoi => open,

		trace_valid => open,
		trace_data => open

	);

	avm_read <= '1' when mem_gen_bten = "0000" and mem_prv_active = '1' else '0';
	avm_write <= '1' when mem_gen_bten /= "0000" and mem_prv_active = '1' else '0';
	avm_byteenable <= "1111" when mem_gen_bten = "0000" and mem_prv_active = '1' else mem_gen_bten;
	mem_pico_done <= avm_readdatavalid when mem_gen_bten = "0000" and mem_prv_active = '1' else not avm_waitrequest;

end architecture rtl;
