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

                currentTimestamp .req r6
                LDR currentTimestamp, [timerAddress]

                lastEndTimestampBeforeRegisterOverflow .req r7
                MOV lastEndTimestampBeforeRegisterOverflow, #0
                SUB lastEndTimestampBeforeRegisterOverflow, #1

                endTimestamp .req r5
                MOV endTimestamp, currentTimestamp
                ADD endTimestamp, frameTime

                xSafeCopy .req r8
                previousEndTimestamp .req r9

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
                        CMP endTimestamp, currentTimestamp
                        BHI waitForNextFrame                    // no yet time for next frame
                        BEQ checkLastTickBeforeOverflow         // it's time for next frame, but check if the endTimestamp should be reset to frameTime
                        B addFrameTime                          // otherwise, it's time for next frame

                        checkLastTickBeforeOverflow:

                            CMP endTimestamp, lastEndTimestampBeforeRegisterOverflow
                            MOVEQ endTimestamp, frameTime

                        addFrameTime:

                            MOV previousEndTimestamp, endTimestamp
                            ADD endTimestamp, frameTime
                            CMP previousEndTimestamp, endTimestamp                                  // overflow?
                                BLS whileTrue                                                       // no - continue
                                CMP currentTimestamp, endTimestamp                                  // yes - if endTimestamp is overflown, assign last available 32-bit value instead (all ones)
                                MOVHI endTimestamp, lastEndTimestampBeforeRegisterOverflow

                B whileTrue

                .unreq x
                .unreq y
                .unreq timespan
                .unreq frameTime
                .unreq timerAddress
                .unreq endTimestamp
                .unreq currentTimestamp
                .unreq xSafeCopy
                .unreq previousEndTimestamp
                .unreq lastEndTimestampBeforeRegisterOverflow
            // <- Drawing

            errorLoop:
            B errorLoop
