ENTRY(Reset_Handler)
_estack = 0x24080000;
_Min_Heap_Size = 0x200;
_Min_Stack_Size = 0x400;
MEMORY
{
RAM_EXEC (rx) : ORIGIN = 0x24000000, LENGTH = 256K
RAM (xrw) : ORIGIN = 0x24040000, LENGTH = 256K
}
SECTIONS
{
.isr_vector :
{
. = ALIGN(4);
KEEP(*(.isr_vector))
. = ALIGN(4);
} >RAM_EXEC
.text :
{
. = ALIGN(4);
*(.text)
*(.text*)
*(.glue_7)
*(.glue_7t)
*(.eh_frame)
KEEP (*(.init))
KEEP (*(.fini))
. = ALIGN(4);
_etext = .;
} >RAM_EXEC
.rodata :
{
. = ALIGN(4);
*(.rodata)
*(.rodata*)
. = ALIGN(4);
} >RAM_EXEC
.ARM.extab (READONLY) :
{
*(.ARM.extab* .gnu.linkonce.armextab.*)
} >RAM_EXEC
.ARM (READONLY) :
{
__exidx_start = .;
*(.ARM.exidx*)
__exidx_end = .;
} >RAM_EXEC
.preinit_array (READONLY) :
{
PROVIDE_HIDDEN (__preinit_array_start = .);
KEEP (*(.preinit_array*))
PROVIDE_HIDDEN (__preinit_array_end = .);
} >RAM_EXEC
.init_array (READONLY) :
{
PROVIDE_HIDDEN (__init_array_start = .);
KEEP (*(SORT(.init_array.*)))
KEEP (*(.init_array*))
PROVIDE_HIDDEN (__init_array_end = .);
} >RAM_EXEC
.fini_array (READONLY) :
{
PROVIDE_HIDDEN (__fini_array_start = .);
KEEP (*(SORT(.fini_array.*)))
KEEP (*(.fini_array*))
PROVIDE_HIDDEN (__fini_array_end = .);
} >RAM_EXEC
_sidata = LOADADDR(.data);
.data :
{
. = ALIGN(4);
_sdata = .;
*(.data)
*(.data*)
. = ALIGN(4);
_edata = .;
} >RAM AT> RAM_EXEC
. = ALIGN(4);
.bss :
{
_sbss = .;
__bss_start__ = _sbss;
*(.bss)
*(.bss*)
*(COMMON)
. = ALIGN(4);
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