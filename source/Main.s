/*****************************************************/
/* This file is the application's entry point.       */
/*                                                   */
/* Author: Piotr Justyna                             */
/*****************************************************/

.section .init

    .globl _start
    _start: MOV sp, #0x8000
            B Main

.section .text

    Main:   BL InitialiseFrameBuffer
            frameBufferInfo .req r0
            TEQ frameBufferInfo, #0                                 // If the framebuffer info address is 0 (TEQ not to affect V and C flags), there's an error.
            BEQ errorLoop
            framebufferInfoAddress .req r1
            LDR framebufferInfoAddress, =FramebufferInfoAddress
            STR frameBufferInfo, [framebufferInfoAddress]           // Preserve the framebuffer info address so it doesn't have to be stored in registers.
            .unreq frameBufferInfo
            .unreq framebufferInfoAddress

            // Setting foreground colour
                foregroundColourValue .req r0
                LDR foregroundColourValue, =GreenColour
                LDR foregroundColourValue, [foregroundColourValue]

                foregroundColourAddress .req r1
                LDR foregroundColourAddress, =ForegoundColour
                STR foregroundColourValue, [foregroundColourAddress]

                .unreq foregroundColourValue
                .unreq foregroundColourAddress
            // <- Setting foreground colour

            // Setting background colour
                backgroundColourValue .req r0
                LDR backgroundColourValue, =BlackColour
                LDR backgroundColourValue, [backgroundColourValue]

                backgroundColourAddress .req r1
                LDR backgroundColourAddress, =BackgroundColour
                STR backgroundColourValue, [backgroundColourAddress]

                .unreq backgroundColourValue
                .unreq backgroundColourAddress
            // <- Setting background colour

            // Drawing
                x .req r0
                MOV x, #2

                y .req r1
                MOV y, #7

                timespan .req r2

                frameTime .req r3
                LDR frameTime, =1000

                timerAddress .req r4
                LDR timerAddress, =TimerAddress
                LDR timerAddress, [timerAddress]

                endTimestamp .req r5
                LDR endTimestamp, [timerAddress]
                ADD endTimestamp, frameTime

                currentTimestamp .req r6
                xSafeCopy .req r7

                BL SetGPIO
                BL DrawTopPaddle
                BL DrawBottomPaddle
                BL DrawFrame

                whileTrue:

                    BL CaptureStartTimestamp

                    //BL WipeBall   // TODO: For now
                    BL DrawNet
                    BL MoveTopPaddle
                    BL MoveBottomPaddle
                    BL DrawBall
                    BL DetectCollisions

                    BL CaptureEndTimestamp

                    MOV xSafeCopy, x

                    BL MeasureTimespan
                    MOV timespan, r0
                    MOV x, xSafeCopy
                    BL DrawWord

                    waitForNextFrame:

                        LDR currentTimestamp, [timerAddress]
                        CMP currentTimestamp, endTimestamp
                        ADDGE endTimestamp, frameTime

                    BLT waitForNextFrame

                B whileTrue

                .unreq x
                .unreq y
                .unreq timespan
                .unreq frameTime
                .unreq timerAddress
                .unreq endTimestamp
                .unreq currentTimestamp
                .unreq xSafeCopy
            // <- Drawing

            errorLoop:
            B errorLoop
