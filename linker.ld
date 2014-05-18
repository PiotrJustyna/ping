SECTIONS 
{
	.init 0x8000 : { *(.init) }
	.text : { *(.text) }
	.data : { *(.data) }
}
