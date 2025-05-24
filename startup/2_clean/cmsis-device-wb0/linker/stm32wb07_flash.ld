_MEMORY_RAM_BEGIN_ = 0x20000000;
_MEMORY_RAM_SIZE_ = 0x10000;
_MEMORY_RAM_END_ = 0x2000FFFF;
_MEMORY_FLASH_BEGIN_ = 0x10040000;
_MEMORY_FLASH_SIZE_ = 0x40000;
_MEMORY_FLASH_END_ = 0x1007FFFF;
_MEMORY_ROM_BEGIN_ = 0x10000000;
_MEMORY_ROM_SIZE_ = 0x01800;
_MEMORY_ROM_END_ = 0x100017FF;
FLASH_NVM_DATASIZE = (4*1024);
MEMORY_FLASH_APP_OFFSET = DEFINED(MEMORY_FLASH_APP_OFFSET) ? (MEMORY_FLASH_APP_OFFSET) : (0) ;
MEMORY_FLASH_APP_SIZE = DEFINED(MEMORY_FLASH_APP_SIZE) ? (MEMORY_FLASH_APP_SIZE) : (_MEMORY_FLASH_SIZE_ - FLASH_NVM_DATASIZE - MEMORY_FLASH_APP_OFFSET);
ENTRY(Reset_Handler)
_Min_Heap_Size = 0x0;
_Min_Stack_Size = 0xC00;
MEMORY
{
RAM (xrw) : ORIGIN = _MEMORY_RAM_BEGIN_, LENGTH = _MEMORY_RAM_SIZE_
FLASH (rx) : ORIGIN = _MEMORY_FLASH_BEGIN_ + MEMORY_FLASH_APP_OFFSET, LENGTH = MEMORY_FLASH_APP_SIZE
REGION_NVM (rx) : ORIGIN = _MEMORY_FLASH_END_ + 1 - FLASH_NVM_DATASIZE, LENGTH = FLASH_NVM_DATASIZE
REGION_ROM (rx) : ORIGIN = _MEMORY_ROM_BEGIN_, LENGTH = _MEMORY_ROM_SIZE_
}
SECTIONS
{
.intvec (ORIGIN(FLASH)) :
{
. = ALIGN(4);
KEEP(*(.intvec))
. = ALIGN(4);
} >FLASH
.text :
{
. = ALIGN(4);
KEEP(*(TAG_OTA_START))
KEEP(*(.cmd_call_table))
*(.text)
*(.text*)
*(i.*)
*(.constdata)
*(.glue_7)
*(.glue_7t)
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
*(.ARM.extab*)
} >FLASH
.ARM (READONLY) :
{
__exidx_start = .;
*(.ARM.exidx*)
__exidx_end = .;
} >FLASH
_sidata = LOADADDR(.data);
.ram_preamble 0x20000004 (NOLOAD) :
{
KEEP(*(.ram_vr))
} >RAM
.ram_preamble_2 0x20000034 (NOLOAD) :
{
KEEP(*(.crash_info_ram_vr))
} >RAM
.bss.blueRAM 0x200000C0 :
{
. = ALIGN(4);
_sbssblue = .;
KEEP(*(.bss.__blue_RAM))
. = ALIGN(4);
_ebssblue = .;
} >RAM
.bss DEFINED(MEMORY_RAM_APP_OFFSET) ? (ORIGIN(RAM) + MEMORY_RAM_APP_OFFSET) : . :
{
. = ALIGN(4);
_sbss = .;
*(.bss)
*(.bss*)
*(COMMON)
. = ALIGN(4);
_ebss = .;
} >RAM
.data :
{
. = ALIGN(4);
_sdata = .;
*(.data)
*(.data*)
. = ALIGN(4);
_edata = .;
} >RAM AT> FLASH
.noinit (NOLOAD):
{
. = ALIGN(4);
*(.noinit)
. = ALIGN(4);
} >RAM
.ota_region_end :
{
. = ALIGN(4);
KEEP(*(TAG_OTA_END))
. = ALIGN(4);
} >FLASH
.heap (NOLOAD):
{
. = ALIGN(4);
PROVIDE ( end = . );
PROVIDE ( _end = . );
. = . + _Min_Heap_Size;
. = ALIGN(4);
} >RAM
.stack (ORIGIN(RAM) + LENGTH(RAM) - _Min_Stack_Size) (NOLOAD) :
{
. = ALIGN(4);
. = . + _Min_Stack_Size;
. = ALIGN(4);
_estack = .;
. = ALIGN(4);
} > RAM
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