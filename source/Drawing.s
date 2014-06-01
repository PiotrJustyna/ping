/***************************************************/
/* This file contains various drawing subroutines. */
/*                                                 */
/* Author: Piotr Justyna                           */
/***************************************************/

.section .text

    .globl DrawPixel
    DrawPixel:  PUSH { r2, r3, r4, r5, r6, lr }

                x .req r0
                y .req r1

                frameBufferInfo .req r2
                LDR frameBufferInfo, =FramebufferInfoAddress
                LDR frameBufferInfo, [frameBufferInfo]

                framebufferAddress .req r3
                LDR framebufferAddress, [frameBufferInfo, #32]

                screenWidth .req r4
                LDR screenWidth, [frameBufferInfo, #0]

                colour .req r5
                LDR colour, =ForegoundColour
                LDR colour, [colour]

                pixelAddress .req r6
                MLA pixelAddress, screenWidth, y, x
                ADD pixelAddress, pixelAddress
                ADD pixelAddress, framebufferAddress

                STRH colour, [pixelAddress]

                .unreq x
                .unreq y
                .unreq frameBufferInfo
                .unreq framebufferAddress
                .unreq screenWidth
                .unreq colour
                .unreq pixelAddress

                POP { r2, r3, r4, r5, r6, pc }

    .globl DrawFrame
    DrawFrame:  PUSH { r0, r1, r2, r3, r4, r5, lr }

                x .req r0
                MOV x, #0

                y .req r1
                MOV y, #1

                screenWidth .req r2
                LDR screenWidth, =FrameBufferInfo
                LDR screenWidth, [screenWidth, #0]

                screenHeight .req r3
                LDR screenHeight, =FrameBufferInfo
                LDR screenHeight, [screenHeight, #4]

                rightBorder .req r4
                LDR rightBorder, =ScoreMargin               // &200
                LDR rightBorder, [rightBorder]              // 200
                SUB rightBorder, screenWidth, rightBorder   // screen width - 200

                bottomBorder .req r5
                SUB bottomBorder, screenHeight, #1

                topBorderLoop:

                    BL DrawPixel

                    ADD x, #1
                    CMP x, rightBorder

                BNE topBorderLoop

                rightBorderLoop:

                    BL DrawPixel

                    ADD y, #1
                    CMP y, bottomBorder

                BNE rightBorderLoop

                bottomBorderLoop:

                    BL DrawPixel

                    SUB x, #1
                    CMP x, #0

                BNE bottomBorderLoop

                leftBorderLoop:

                    BL DrawPixel

                    SUB y, #1
                    CMP y, #1

                BNE leftBorderLoop

                .unreq x
                ballWidth .req r0
                LDR ballWidth, =BallWidth
                LDR ballWidth, [ballWidth]

                .unreq y
                rightBorderAddress .req r1
                LDR rightBorderAddress, =TableRightBorder
                SUB rightBorder, ballWidth
                STR rightBorder, [rightBorderAddress]

                .unreq ballWidth
                ballHeight .req r0
                LDR ballHeight, =BallHeight
                LDR ballHeight, [ballHeight]

                .unreq rightBorderAddress
                bottomBorderAddress .req r1
                LDR bottomBorderAddress, =TableBottomBorder
                SUB bottomBorder, ballHeight
                STR bottomBorder, [bottomBorderAddress]

                .unreq ballHeight
                .unreq bottomBorderAddress
                .unreq screenWidth
                .unreq screenHeight
                .unreq rightBorder
                .unreq bottomBorder

                POP { r0, r1, r2, r3, r4, r5, pc }

    .globl DrawNet
    DrawNet:    PUSH { r0, r1, r2, r3, r4, lr }

                x .req r0
                MOV x, #1

                y .req r1

                dashCounter .req r2
                MOV dashCounter, #0

                rightBorder .req r3
                LDR rightBorder, =TableRightBorder
                LDR rightBorder, [rightBorder]

                screenHeight .req r4
                LDR screenHeight, =FrameBufferInfo
                LDR screenHeight, [screenHeight, #4]

                MOV y, screenHeight, LSR #1

                netLoop:

                    ADD dashCounter, #1

                    BL DrawPixel

                    CMP dashCounter, #10
                    MOVEQ dashCounter, #0
                    ADDEQ x, #(10 + 1)
                    ADDNE x, #1
                    CMP x, rightBorder

                BNE netLoop

                .unreq x
                .unreq y
                .unreq dashCounter
                .unreq rightBorder
                .unreq screenHeight

                POP { r0, r1, r2, r3, r4, pc }

    .globl WipeBall
    WipeBall:   PUSH { r0, r1, r2, r3, r4, r5, lr }

                x .req r0
                LDR x, =PreviousBallPositionX
                LDR x, [x]

                y .req r1
                LDR y, =PreviousBallPositionY
                LDR y, [y]

                ballWidth .req r2
                LDR ballWidth, =BallWidth
                LDR ballWidth, [ballWidth]

                remainingBallWidth .req r3
                MOV remainingBallWidth, ballWidth

                ballHeight .req r4
                LDR ballHeight, =BallHeight
                LDR ballHeight, [ballHeight]

                remainingBallHeight .req r5
                MOV remainingBallHeight, ballHeight

                foregroundColourValue .req r6
                LDR foregroundColourValue, =BackgroundColour
                LDR foregroundColourValue, [foregroundColourValue]

                foregroundColourAddress .req r7
                LDR foregroundColourAddress, =ForegoundColour
                STR foregroundColourValue, [foregroundColourAddress]

                wipeBallRowLoop:

                    wipeBallColumnLoop:

                        BL DrawPixel
                        SUB remainingBallWidth, #1
                        ADD x, #1
                        CMP remainingBallWidth, #0

                    BNE wipeBallColumnLoop

                    MOV remainingBallWidth, ballWidth
                    SUB remainingBallHeight, #1
                    SUB x, remainingBallWidth
                    ADD y, #1
                    CMP remainingBallHeight, #0

                BNE wipeBallRowLoop

                SUB y, ballHeight

                LDR foregroundColourValue, =GreenColour
                LDR foregroundColourValue, [foregroundColourValue]
                STR foregroundColourValue, [foregroundColourAddress]

                POP { r0, r1, r2, r3, r4, r5, pc }

    .globl DrawBall
    DrawBall:   PUSH { r0, r1, r2, r3, r4, r5, lr }

                BL WipeBall // TODO: For now

                x .req r0
                LDR x, =BallPositionX
                LDR x, [x]

                y .req r1
                LDR y, =BallPositionY
                LDR y, [y]

                ballWidth .req r2
                LDR ballWidth, =BallWidth
                LDR ballWidth, [ballWidth]

                remainingBallWidth .req r3
                MOV remainingBallWidth, ballWidth

                ballHeight .req r4
                LDR ballHeight, =BallHeight
                LDR ballHeight, [ballHeight]

                remainingBallHeight .req r5
                MOV remainingBallHeight, ballHeight

                ballRowLoop:

                    ballColumnLoop:

                        BL DrawPixel
                        SUB remainingBallWidth, #1
                        ADD x, #1
                        CMP remainingBallWidth, #0

                    BNE ballColumnLoop

                    MOV remainingBallWidth, ballWidth
                    SUB remainingBallHeight, #1
                    SUB x, remainingBallWidth
                    ADD y, #1
                    CMP remainingBallHeight, #0

                BNE ballRowLoop

                SUB y, ballHeight

                .unreq ballWidth
                previousBallPosition .req r2
                LDR previousBallPosition, =PreviousBallPositionX
                STR x, [previousBallPosition]

                LDR previousBallPosition, =PreviousBallPositionY
                STR y, [previousBallPosition]

                .unreq x
                .unreq y
                .unreq previousBallPosition
                .unreq remainingBallWidth
                .unreq ballHeight
                .unreq remainingBallHeight

                POP { r0, r1, r2, r3, r4, r5, pc }

    .globl DrawWord
    DrawWord:   PUSH { r3, lr }

                x .req r0
                y .req r1
                word .req r2
                testedNumber .req r3

                MOV testedNumber, #(1 << 31)

                testLoop:

                    TST word, testedNumber
                    BLEQ DrawZero
                    BLNE DrawOne
                    ADD x, #5

                    LSR testedNumber, #1
                    TEQ testedNumber, #0

                BNE testLoop

                SUB x, #(32 * 5)

                .unreq x
                .unreq y
                .unreq testedNumber
                .unreq word

                POP { r3, pc }

    .globl DrawTimeDifference
    DrawTimeDifference: PUSH { lr }

                        x .req r0
                        y .req r1
                        testedNumber .req r7
                        previousValue .req r10
                        testedRegister .req r11

                        MOV testedNumber, #1
                        LSL testedNumber, #31
                        LDR testedRegister, =0x20003004
                        LDR testedRegister, [testedRegister]
                        SUB testedRegister, testedRegister, previousValue

                        MOV x, #5
                        MOV y, #10

                        registerTestLoop:

                            TST testedRegister, testedNumber
                            BLEQ DrawZero
                            BLNE DrawOne
                            ADD x, #5

                            LSR testedNumber, #1
                            TEQ testedNumber, #0

                        BNE registerTestLoop

                        SUB x, #(32 * 5)

                        .unreq x
                        .unreq y
                        .unreq testedNumber
                        .unreq previousValue
                        .unreq testedRegister

                        POP { pc }

    .globl DrawOne
    DrawOne:    PUSH { r2, r3, r4, lr }

                x .req r0
                y .req r1

                foregroundColour .req r2
                LDR foregroundColour, =ForegoundColour

                backgroundColour .req r3
                LDR backgroundColour, =BackgroundColour
                LDR backgroundColour, [backgroundColour]

                previousForegroundColour .req r4

                /* Row 1 */
                    ADD x, #3
                    BL DrawPixel
                /* <- Row 1 */

                /* Row 2 */
                    SUB y, #1
                    BL DrawPixel
                /* <- Row 2 */

                /* Row 3 */
                    SUB y, #1
                    BL DrawPixel
                /* <- Row 3 */

                /* Row 4 */
                    SUB y, #1

                    SUB x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 4 */

                /* Row 5 */
                    SUB y, #1
                    BL DrawPixel
                /* <- Row 5 */

                LDR previousForegroundColour, [foregroundColour]
                STR backgroundColour, [foregroundColour]
                SUB x, #3
                ADD y, #4

                /* Row 1 */
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 1 */

                /* Row 2 */
                    SUB y, #1

                    BL DrawPixel

                    SUB x, #1
                    BL DrawPixel

                    SUB x, #1
                    BL DrawPixel
                /* <- Row 2 */

                /* Row 3 */
                    SUB y, #1

                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 3 */

                /* Row 4 */
                    SUB y, #1
                    SUB x, #1

                    BL DrawPixel

                    SUB x, #1
                    BL DrawPixel
                /* <- Row 4 */

                /* Row 5 */
                    SUB y, #1

                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 4 */

                STR previousForegroundColour, [foregroundColour]
                SUB x, #2
                ADD y, #4

                .unreq x
                .unreq y
                .unreq foregroundColour
                .unreq backgroundColour
                .unreq previousForegroundColour

                POP { r2, r3, r4, pc }

    .globl DrawZero
    DrawZero:   PUSH { r2, r3, r4, lr }

                x .req r0
                y .req r1

                foregroundColour .req r2
                LDR foregroundColour, =ForegoundColour

                backgroundColour .req r3
                LDR backgroundColour, =BackgroundColour
                LDR backgroundColour, [backgroundColour]

                previousForegroundColour .req r4

                /* Row 1 */
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 1 */

                /* Row 2 */
                    SUB y, #1

                    BL DrawPixel

                    SUB x, #3
                    BL DrawPixel
                /* <- Row 2 */

                /* Row 3 */
                    SUB y, #1

                    BL DrawPixel

                    ADD x, #3
                    BL DrawPixel
                /* <- Row 3 */

                /* Row 4 */
                    SUB y, #1

                    BL DrawPixel

                    SUB x, #3
                    BL DrawPixel
                /* <- Row 4 */

                /* Row 5 */
                    SUB y, #1

                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 5 */

                LDR previousForegroundColour, [foregroundColour]
                STR backgroundColour, [foregroundColour]
                SUB x, #2
                ADD y, #3

                /* Row 2 */
                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 2 */

                /* Row 3 */
                    SUB y, #1

                    BL DrawPixel

                    SUB x, #1
                    BL DrawPixel
                /* <- Row 3 */

                /* Row 4 */
                    SUB y, #1

                    BL DrawPixel

                    ADD x, #1
                    BL DrawPixel
                /* <- Row 4 */

                STR previousForegroundColour, [foregroundColour]
                SUB x, #2
                ADD y, #3

                .unreq x
                .unreq y
                .unreq foregroundColour
                .unreq backgroundColour
                .unreq previousForegroundColour

                POP { r2, r3, r4, pc }
