_MEMORY_RAM_BEGIN_ = 0x20000000;
_MEMORY_RAM_SIZE_ = 0x8000;
_MEMORY_RAM_END_ = 0x20007FFF;
_MEMORY_FLASH_BEGIN_ = 0x10040000;
_MEMORY_FLASH_SIZE_ = 0x20000;
_MEMORY_FLASH_END_ = 0x1005FFFF;
_MEMORY_ROM_BEGIN_ = 0x10000000;
_MEMORY_ROM_SIZE_ = 0x01800;
_MEMORY_ROM_END_ = 0x100017FF;
MEMORY_FLASH_APP_OFFSET = DEFINED(MEMORY_FLASH_APP_OFFSET) ? (MEMORY_FLASH_APP_OFFSET) : (0) ;
MEMORY_FLASH_APP_SIZE = DEFINED(MEMORY_FLASH_APP_SIZE) ? (MEMORY_FLASH_APP_SIZE) : (_MEMORY_FLASH_SIZE_ - MEMORY_FLASH_APP_OFFSET);
RESET_MANAGER_SIZE = DEFINED(RESET_MANAGER_SIZE) ? (RESET_MANAGER_SIZE) : (0x800) ;
ENTRY(Reset_Handler)
_Min_Heap_Size = 0x000;
_Min_Stack_Size = 0xC00;
MEMORY
{
REGION_RAM (xrw) : ORIGIN = _MEMORY_RAM_BEGIN_, LENGTH = _MEMORY_RAM_SIZE_
REGION_FLASH_BOOTLOADER (rx) : ORIGIN = _MEMORY_FLASH_BEGIN_, LENGTH = MEMORY_FLASH_APP_OFFSET
REGION_FLASH (rx) : ORIGIN = _MEMORY_FLASH_BEGIN_ + MEMORY_FLASH_APP_OFFSET, LENGTH = MEMORY_FLASH_APP_SIZE
REGION_ROM (rx) : ORIGIN = _MEMORY_ROM_BEGIN_, LENGTH = _MEMORY_ROM_SIZE_
}
SECTIONS
{
.intvec (ORIGIN(REGION_FLASH)) :
{
. = ALIGN(4);
KEEP(*(.intvec))
. = ALIGN(4);
} >REGION_FLASH
.text :
{
. = ALIGN(4);
KEEP(*(.cmd_call_table))
*(.text)
*(.text*)
*(i.*)
*(.rodata)
*(.rodata*)
*(.constdata)
*(.glue_7)
*(.glue_7t)
. = ALIGN(4);
_etext = .;
} >REGION_FLASH
_sidata = LOADADDR(.data);
.ram_preamble 0x20000004 (NOLOAD) :
{
KEEP(*(.ram_vr))
} >REGION_RAM AT> REGION_FLASH
.ram_preamble_2 0x20000034 (NOLOAD) :
{
KEEP(*(.crash_info_ram_vr))
} >REGION_RAM
.bss DEFINED(MEMORY_RAM_APP_OFFSET) ? (ORIGIN(REGION_RAM) + MEMORY_RAM_APP_OFFSET) : . :
{
. = ALIGN(4);
_sbss = .;
*(.bss)
*(.bss*)
*(COMMON)
. = ALIGN(4);
_ebss = .;
} >REGION_RAM
.data :
{
. = ALIGN(4);
_sdata = .;
*(.data)
*(.data*)
. = ALIGN(4);
_edata = .;
} >REGION_RAM AT> REGION_FLASH
.noinit (NOLOAD):
{
. = ALIGN(4);
*(.noinit)
. = ALIGN(4);
} >REGION_RAM
.heap (NOLOAD):
{
. = ALIGN(4);
_sheap = .;
PROVIDE ( end = . );
PROVIDE ( _end = . );
. = . + _Min_Heap_Size;
. = ALIGN(4);
_eheap = .;
} >REGION_RAM
CSTACK (ORIGIN(REGION_RAM) + LENGTH(REGION_RAM) - _Min_Stack_Size) (NOLOAD) :
{
. = ALIGN(4);
. = . + _Min_Stack_Size;
. = ALIGN(4);
_estack = .;
. = ALIGN(4);
} > REGION_RAM
.rom_info (NOLOAD) :
{
. = ALIGN(4);
KEEP(*(.rom_info))
. = ALIGN(4);
} >REGION_ROM
/DISCARD/ :
{
libc.a ( * )
libm.a ( * )
libgcc.a ( * )
}
.ARM.attributes 0 : { *(.ARM.attributes) }
}