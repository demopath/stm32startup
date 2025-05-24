ENTRY(Reset_Handler)
_estack = ORIGIN(RAM1) + LENGTH(RAM1);
_Min_Heap_Size = 0x200;
_Min_Stack_Size = 0x400;
MEMORY
{
ROM (rx) : ORIGIN = 0x08000000, LENGTH = 128K
RAM1 (xrw) : ORIGIN = 0x20000000, LENGTH = 16K
RAM2 (xrw) : ORIGIN = 0x20008000, LENGTH = 16K
}
SECTIONS
{
.isr_vector :
{
. = ALIGN(8);
KEEP(*(.isr_vector))
. = ALIGN(8);
} >ROM
.text :
{
. = ALIGN(8);
*(.text)
*(.text*)
*(.glue_7)
*(.glue_7t)
*(.eh_frame)
KEEP (*(.init))
KEEP (*(.fini))
. = ALIGN(8);
_etext = .;
} >ROM
.rodata :
{
. = ALIGN(8);
*(.rodata)
*(.rodata*)
. = ALIGN(8);
} >ROM
.ARM.extab : {
. = ALIGN(8);
*(.ARM.extab* .gnu.linkonce.armextab.*)
. = ALIGN(8);
} >ROM
.ARM : {
. = ALIGN(8);
__exidx_start = .;
*(.ARM.exidx*)
__exidx_end = .;
. = ALIGN(8);
} >ROM
.preinit_array :
{
. = ALIGN(8);
PROVIDE_HIDDEN (__preinit_array_start = .);
KEEP (*(.preinit_array*))
PROVIDE_HIDDEN (__preinit_array_end = .);
. = ALIGN(8);
} >ROM
.init_array :
{
. = ALIGN(8);
PROVIDE_HIDDEN (__init_array_start = .);
KEEP (*(SORT(.init_array.*)))
KEEP (*(.init_array*))
PROVIDE_HIDDEN (__init_array_end = .);
. = ALIGN(8);
} >ROM
.fini_array :
{
. = ALIGN(8);
PROVIDE_HIDDEN (__fini_array_start = .);
KEEP (*(SORT(.fini_array.*)))
KEEP (*(.fini_array*))
PROVIDE_HIDDEN (__fini_array_end = .);
. = ALIGN(8);
} >ROM
_sidata = LOADADDR(.data);
.data :
{
. = ALIGN(8);
_sdata = .;
*(.data)
*(.data*)
. = ALIGN(8);
_edata = .;
} >RAM1 AT> ROM
. = ALIGN(8);
.bss :
{
_sbss = .;
__bss_start__ = _sbss;
*(.bss)
*(.bss*)
*(COMMON)
. = ALIGN(8);
_ebss = .;
__bss_end__ = _ebss;
} >RAM1
. = ALIGN(8);
RAM1_region :
{
_sRAM1_region = .;
*(.RAM1_region)
. = ALIGN(8);
_eRAM1_region = .;
} >RAM1
. = ALIGN(8);
RAM2_region :
{
_sRAM2_region = .;
*(.RAM2_region)
. = ALIGN(8);
_eRAM2_region = .;
} >RAM2
._user_heap_stack :
{
. = ALIGN(8);
PROVIDE ( end = . );
PROVIDE ( _end = . );
. = . + _Min_Heap_Size;
. = . + _Min_Stack_Size;
. = ALIGN(8);
} >RAM1
/DISCARD/ :
{
libc.a ( * )
libm.a ( * )
libgcc.a ( * )
}
.ARM.attributes 0 : { *(.ARM.attributes) }
}