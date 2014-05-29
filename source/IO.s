.section .text

    .globl SetGPIO
    SetGPIO:    PUSH { r0, r1, lr }

                gpioAddress .req r0
                pinToSet .req r1

                LDR gpioAddress, =0x20200000

                MOV pinToSet, #0 << 21            // PIN 7 is set to INPUT
                STR pinToSet, [gpioAddress]

                MOV pinToSet, #0 << 24            // PIN 8 is set to INPUT
                STR pinToSet, [gpioAddress]

                POP { r0, r1, pc }
