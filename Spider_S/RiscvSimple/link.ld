OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
OUTPUT_ARCH( "riscv" )

MEMORY
{
 OCRAM (rwx) : ORIGIN = 0x00000000, LENGTH = 32K
}

ENTRY(__reset_vector__)

_end_of_memory = ORIGIN(OCRAM) + LENGTH(OCRAM) - 1;
_sp = ALIGN(_end_of_memory - 0x10, 4);


SECTIONS
{
	.init :
	{
		. = 0x10;
		KEEP(*(.init))
		*(.init)

		. = 0x20;
		KEEP(*(.exception))
		*(.exception)

	} > OCRAM


	.text :	{
		*.text
	} > OCRAM

	.data : { *(.data) } > OCRAM
	.rodata : { *(.rodata) } > OCRAM

	.sdata : {
		_gp = . + 0x800;
		*(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata*)
		*(.sdata .sdata.* .gnu.linkonce.s.*)
	} > OCRAM

	.tdata :
	{
		_tls_data = .;
		*(.tdata)
	} > OCRAM

	. = ALIGN(4);

	__bss_start__ = .;

	.sbss : {
		*(.sbss .sbss.* .gnu.linkonce.sb.*)
		*(.scommon)
	} > OCRAM

	.bss : { *(.bss) } > OCRAM

	.tbss :
	{
		*(.tbss)
	} > OCRAM

	. = ALIGN(4);

	__bss_end__ = .;

	_end = .;
}
