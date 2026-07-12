/* Program entry point */
ENTRY(Reset_Handler)

/* Memory regions */
MEMORY
{
    FLASH(rx):ORIGIN =0x08000000, LENGTH =1024K
    RAM(rwx):ORIGIN =0x20010000, LENGTH =256K
}

/* Define the end of the stack memory used in startup.cpp */
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{

/* Set vector table in flash memory */
.isr_vector :
{
    KEEP(*(.isr_vector))
} > FLASH


/* Save the program code on the flash memory */
.text :
{
    /* Save Program Text in flash memory */
    *(.text*)

    /* Save read only data (const vars) in flash memory */
    *(.rodata*)

    /* Enable interworking between ARM and Thumb instruction sets */
    *(.glue_7*)
    *(.glue_7t*)

    /* define the end of the text memory section  */
    _etext = .;

} > FLASH

/* .preinit_array contains functions that must run before .init_array */
.preinit_array :
{
    __preinit_array_start = .;
    KEEP(*(.preinit_array*))
    __preinit_array_end = .;
} > FLASH

/* Generate entries for the global/static ctors */
.init_array :
{
    __init_array_start = .;
    KEEP(*(.init_array*))
    __init_array_end = .;
} > FLASH

/* Generate entries for the global/static dtors */
.fini_array :
{
    __fini_array_start = .;
    KEEP(*(.fini_array*))
    __fini_array_end = .;
} > FLASH

/* Define memory regions for initialized dynamic variables */
_sidata = LOADADDR(.data);
.data :
{
    _sdata = .;
    *(.data*)
    _edata = .;
} > RAM AT > FLASH


/* Define memory regions for zero initialized dynamic variables */
.bss :
{
    _sbss = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
} > RAM


/* Define the heap */
.heap :
{
    __heap_start = .;
    . = . + 0x1000;
    __heap_end = .;
} > RAM


/* Define the stack */
.stack :
{
    __stack_start = .;
    . = . + 0x1000;
    __stack_end = .;
} > RAM

}