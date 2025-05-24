ENTRY(Reset_Handler)
_estack = ORIGIN(DTCM) + LENGTH(DTCM);
_Min_Heap_Size = 0x200;
_Min_Stack_Size = 0x400;
__FLASH_BEGIN = 0x90000000;
__FLASH_SIZE = 0x08000000;
__EXTRAM_BEGIN = 0x70000000;
__EXTRAM_SIZE = 0x02000000;
__RAM = 0x24000000;
__RAM_SIZE = 0x72000;
__RAM_NONCACHEABLEBUFFER_SIZE = 0x400;
MEMORY
{
RAM (xrw) : ORIGIN = __RAM, LENGTH = __RAM_SIZE -__RAM_NONCACHEABLEBUFFER_SIZE
RAM_NONCACHEABLEBUFFER (xrw) : ORIGIN = __RAM + __RAM_SIZE - __RAM_NONCACHEABLEBUFFER_SIZE, LENGTH = __RAM_NONCACHEABLEBUFFER_SIZE
ITCM (rw) : ORIGIN = 0x00000000, LENGTH = 0x00010000
DTCM (xrw) : ORIGIN = 0x20000000, LENGTH = 0x00010000
SRAMAHB (rw) : ORIGIN = 0x30000000, LENGTH = 0x00008000
BKPSRAM (rw) : ORIGIN = 0x38800000, LENGTH = 0x00001000
FLASH (xrw) : ORIGIN = __FLASH_BEGIN, LENGTH = __FLASH_SIZE
EXTRAM (rw) : ORIGIN = __EXTRAM_BEGIN,LENGTH = __EXTRAM_SIZE
}
SECTIONS
{
.isr_vector :
{
. = ALIGN(4);
KEEP(*(.isr_vector))
. = ALIGN(4);
} >FLASH
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
} >FLASH
.rodata :
{
. = ALIGN(4);
*(.rodata)
*(.rodata*)
. = ALIGN(4);
} >FLASH
.ARM.extab (READONLY) :
{
. = ALIGN(4);
*(.ARM.extab* .gnu.linkonce.armextab.*)
. = ALIGN(4);
} >FLASH
.ARM (READONLY) :
{
. = ALIGN(4);
__exidx_start = .;
*(.ARM.exidx*)
__exidx_end = .;
. = ALIGN(4);
} >FLASH
.preinit_array (READONLY) :
{
. = ALIGN(4);
PROVIDE_HIDDEN (__preinit_array_start = .);
KEEP (*(.preinit_array*))
PROVIDE_HIDDEN (__preinit_array_end = .);
. = ALIGN(4);
} >FLASH
.init_array (READONLY) :
{
. = ALIGN(4);
PROVIDE_HIDDEN (__init_array_start = .);
KEEP (*(SORT(.init_array.*)))
KEEP (*(.init_array*))
PROVIDE_HIDDEN (__init_array_end = .);
. = ALIGN(4);
} >FLASH
.fini_array (READONLY) :
{
. = ALIGN(4);
PROVIDE_HIDDEN (__fini_array_start = .);
KEEP (*(SORT(.fini_array.*)))
KEEP (*(.fini_array*))
PROVIDE_HIDDEN (__fini_array_end = .);
. = ALIGN(4);
} >FLASH
_sidata = LOADADDR(.data);
.data :
{
. = ALIGN(4);
_sdata = .;
*(.data)
*(.data*)
*(.RamFunc)
*(.RamFunc*)
. = ALIGN(4);
_edata = .;
} >RAM AT> FLASH
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
RW_NONCACHEABLE :
{
__NONCACHEABLEBUFFER_BEGIN = .;
KEEP(*(noncacheable_buffer))
__NONCACHEABLEBUFFER_END = .;
} > RAM_NONCACHEABLEBUFFER
._user_heap_stack :
{
. = ALIGN(8);
PROVIDE ( end = . );
PROVIDE ( _end = . );
. = . + _Min_Heap_Size;
. = . + _Min_Stack_Size;
. = ALIGN(8);
} >DTCM
/DISCARD/ :
{
libc.a ( * )
libm.a ( * )
libgcc.a ( * )
}
.ARM.attributes 0 : { *(.ARM.attributes) }
}