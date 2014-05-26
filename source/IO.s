.section .text

    .globl SetGPIO
    SetGPIO:    PUSH { r0, r1, lr }

                gpioAddress .req r0
                actLed .req r1

                LDR gpioAddress, =0x20200000

                MOV actLed, #0 << 21            // PIN 7 is set to INPUT
                STR actLed, [gpioAddress]

                MOV actLed, #0 << 24            // PIN 8 is set to INPUT
                STR actLed, [gpioAddress]

                POP { r0, r1, pc }
