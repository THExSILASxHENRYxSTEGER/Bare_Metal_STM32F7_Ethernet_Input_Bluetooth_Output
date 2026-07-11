/* program entry point */
ENTRY(Reset_Handler)

/* memory regions */
MEMORY
{
    FLASH(rx):ORIGIN =0x08000000, LENGTH =1024K
    RAM(rwx):ORIGIN =0x20010000, LENGTH =256K
}

/* define the end of the stack memory used in startup.cpp */
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{

/* set vector table in flash memory*/
.isr_vector :
{
    KEEP(*(.isr_vector))
} > FLASH


/* program code */
.text :
{
    *(.text*)
    *(.rodata*)
    *(.glue_7*)
    *(.glue_7t*)

    KEEP(*(.init))
    KEEP(*(.fini))

    /* define the end of the text memory section  */
    _etext = .;

} > FLASH


/* constructors */
.preinit_array :
{
    __preinit_array_start = .;
    KEEP(*(.preinit_array*))
    __preinit_array_end = .;
} > FLASH


.init_array :
{
    __init_array_start = .;
    KEEP(*(.init_array*))
    __init_array_end = .;
} > FLASH


.fini_array :
{
    __fini_array_start = .;
    KEEP(*(.fini_array*))
    __fini_array_end = .;
} > FLASH


/* ARM unwind tables */
.ARM.exidx :
{
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
} > FLASH


/* initialized data */
_sidata = LOADADDR(.data);

.data :
{
    _sdata = .;
    *(.data*)
    _edata = .;
} > RAM AT > FLASH


/* zero initialized */
.bss :
{
    _sbss = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
} > RAM


/* heap */
.heap :
{
    __heap_start = .;
    . = . + 0x1000;
    __heap_end = .;
} > RAM


/* stack */
.stack :
{
    __stack_start = .;
    . = . + 0x1000;
    __stack_end = .;
} > RAM

}