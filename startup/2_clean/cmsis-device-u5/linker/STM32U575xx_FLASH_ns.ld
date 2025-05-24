ENTRY(Reset_Handler)
_estack = ORIGIN(RAM) + LENGTH(RAM);
_Min_Heap_Size = 0x200;
_Min_Stack_Size = 0x400;
MEMORY
{
RAM (xrw) : ORIGIN = 0x20040000, LENGTH = 512K
ROM (rx) : ORIGIN = 0x08100000, LENGTH = 1024K
SRAM4 (xrw) : ORIGIN = 0x28000000, LENGTH = 16K
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
.ARM.extab (READONLY) :
{
. = ALIGN(8);
*(.ARM.extab* .gnu.linkonce.armextab.*)
. = ALIGN(8);
} >ROM
.ARM (READONLY) :
{
. = ALIGN(8);
__exidx_start = .;
*(.ARM.exidx*)
__exidx_end = .;
. = ALIGN(8);
} >ROM
.preinit_array (READONLY) :
{
. = ALIGN(8);
PROVIDE_HIDDEN (__preinit_array_start = .);
KEEP (*(.preinit_array*))
PROVIDE_HIDDEN (__preinit_array_end = .);
. = ALIGN(8);
} >ROM
.init_array (READONLY) :
{
. = ALIGN(8);
PROVIDE_HIDDEN (__init_array_start = .);
KEEP (*(SORT(.init_array.*)))
KEEP (*(.init_array*))
PROVIDE_HIDDEN (__init_array_end = .);
. = ALIGN(8);
} >ROM
.fini_array (READONLY) :
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
} >RAM AT> ROM
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
} >RAM
._user_heap_stack :
{
. = ALIGN(8);
PROVIDE ( end = . );
PROVIDE ( _end = . );
. = . + _Min_Heap_Size;
. = . + _Min_Stack_Size;
. = ALIGN(8);
} >RAM
/DISCARD/ :
{
libc.a ( * )
libm.a ( * )
libgcc.a ( * )
}
.ARM.attributes 0 : { *(.ARM.attributes) }
}