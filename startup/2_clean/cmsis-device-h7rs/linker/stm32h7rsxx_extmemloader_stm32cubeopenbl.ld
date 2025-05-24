ENTRY(Reset_Handler)
PHDRS {Loader PT_LOAD FLAGS(5); SgInfo PT_LOAD ; }
_estack = ORIGIN(RAM_D1) + LENGTH(RAM_D1);
_Min_Heap_Size = 0x8;
_Min_Stack_Size = 0x400;
MEMORY
{
RAM_D1 (xrw) : ORIGIN = 0x24007044, LENGTH = 35K
RAM_D2 (xrw) : ORIGIN = 0x24020000, LENGTH = 128K
}
SECTIONS
{
.isr_vector :
{
. = . + 0x1FC;
. = ALIGN(4);
KEEP(*(.isr_vector))
. = ALIGN(4);
} >RAM_D1 :Loader
.ARM.extab (READONLY) :
{
*(.ARM.extab* .gnu.linkonce.armextab.*)
} >RAM_D1
.ARM (READONLY) :
{
__exidx_start = .;
*(.ARM.exidx*)
__exidx_end = .;
} >RAM_D1 :Loader
.preinit_array (READONLY) :
{
PROVIDE_HIDDEN (__preinit_array_start = .);
KEEP (*(.preinit_array*))
PROVIDE_HIDDEN (__preinit_array_end = .);
} >RAM_D1 :Loader
.init_array (READONLY) :
{
PROVIDE_HIDDEN (__init_array_start = .);
KEEP (*(SORT(.init_array.*)))
KEEP (*(.init_array*))
PROVIDE_HIDDEN (__init_array_end = .);
} >RAM_D1 :Loader
.fini_array (READONLY) :
{
PROVIDE_HIDDEN (__fini_array_start = .);
KEEP (*(SORT(.fini_array.*)))
KEEP (*(.fini_array*))
PROVIDE_HIDDEN (__fini_array_end = .);
} >RAM_D1 :Loader
_sidata = LOADADDR(.data);
.data :
{
. = ALIGN(4);
_sdata = .;
*(.data)
*(.data*)
. = ALIGN(4);
_edata = .;
} >RAM_D1 :Loader
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
} >RAM_D2 :Loader
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
} >RAM_D1 :Loader
.stm32_device_info :
{
KEEP(*stm32_device_info.* ( .rodata* ))
} :SgInfo
.rodata :
{
. = ALIGN(4);
*(.rodata)
*(.rodata*)
. = ALIGN(4);
} >RAM_D1 :Loader
._user_heap_stack :
{
. = ALIGN(8);
PROVIDE ( end = . );
PROVIDE ( _end = . );
. = . + _Min_Heap_Size;
. = . + _Min_Stack_Size;
. = ALIGN(8);
} >RAM_D1 :Loader
.ARM.attributes 0 : { *(.ARM.attributes) }
}