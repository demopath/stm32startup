ENTRY(Reset_Handler)
_estack = ORIGIN(RAM) + LENGTH(RAM);
_Min_Heap_Size = 0x200 ;
_Min_Stack_Size = 0x400 ;
MEMORY
{
RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 2496K
SRAM4 (xrw) : ORIGIN = 0x28000000, LENGTH = 16K
}
SECTIONS
{
.isr_vector :
{
KEEP(*(.isr_vector))
} >RAM
.text :
{
*(.text)
*(.text*)
*(.glue_7)
*(.glue_7t)
*(.eh_frame)
*(.RamFunc)
*(.RamFunc*)
KEEP (*(.init))
KEEP (*(.fini))
_etext = .;
} >RAM
.rodata :
{
*(.rodata)
*(.rodata*)
} >RAM
.ARM.extab (READONLY) :
{
*(.ARM.extab* .gnu.linkonce.armextab.*)
} >RAM
.ARM (READONLY) :
{
__exidx_start = .;
*(.ARM.exidx*)
__exidx_end = .;
} >RAM
.preinit_array (READONLY) :
{
PROVIDE_HIDDEN (__preinit_array_start = .);
KEEP (*(.preinit_array*))
PROVIDE_HIDDEN (__preinit_array_end = .);
} >RAM
.init_array (READONLY) :
{
PROVIDE_HIDDEN (__init_array_start = .);
KEEP (*(SORT(.init_array.*)))
KEEP (*(.init_array*))
PROVIDE_HIDDEN (__init_array_end = .);
} >RAM
.fini_array (READONLY) :
{
PROVIDE_HIDDEN (__fini_array_start = .);
KEEP (*(SORT(.fini_array.*)))
KEEP (*(.fini_array*))
PROVIDE_HIDDEN (__fini_array_end = .);
} >RAM
_sidata = LOADADDR(.data);
.data :
{
_sdata = .;
*(.data)
*(.data*)
_edata = .;
} >RAM
.bss :
{
_sbss = .;
__bss_start__ = _sbss;
*(.bss)
*(.bss*)
*(COMMON)
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