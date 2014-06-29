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

    /* Draws a point on the screen. */
    /* 
        Params:
        - x (r0)
        - y (r1)
        - colour (r2)
        - size in pixels (r3) - that's the size of the point expressed in pixels
    */
    /* Returns: - */
    .globl DrawPoint
    DrawPoint:   PUSH { r4, r5, r6, r7, r8, r9, lr }

                    x .req r0
                    y .req r1
                    colour .req r2
                    sizeInPixels .req r3

                    frameBufferInfo .req r4
                    LDR frameBufferInfo, =FramebufferInfoAddress
                    LDR frameBufferInfo, [frameBufferInfo]

                    framebufferAddress .req r5
                    LDR framebufferAddress, [frameBufferInfo, #32]

                    screenWidth .req r6
                    LDR screenWidth, [frameBufferInfo, #0]

                    rowCounter .req r7
                    MOV rowCounter, #0

                    columnCounter .req r8
                    MOV columnCounter, #0

                    pixelAddress .req r9

                    drawPointsRows:

                        drawPointsColumns:

                            MLA pixelAddress, screenWidth, y, x
                            ADD pixelAddress, pixelAddress
                            ADD pixelAddress, framebufferAddress
                            STRH colour, [pixelAddress]
 
                            ADD x, #1
                            ADD columnCounter, #1
                            CMP columnCounter, sizeInPixels

                        BNE drawPointsColumns

                        SUB x, sizeInPixels
                        MOV columnCounter, #0
                        ADD y, #1
                        ADD rowCounter, #1
                        CMP rowCounter, sizeInPixels

                    BNE drawPointsRows

                    SUB y, sizeInPixels

                    .unreq x
                    .unreq y
                    .unreq colour
                    .unreq sizeInPixels
                    .unreq frameBufferInfo
                    .unreq framebufferAddress
                    .unreq screenWidth
                    .unreq rowCounter
                    .unreq columnCounter
                    .unreq pixelAddress           

                    POP { r4, r5, r6, r7, r8, r9, pc }

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
    DrawNet:    PUSH { r0, r1, r2, r3, r4, r5, lr }

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

                ballWidth .req r5
                LDR ballWidth, =BallWidth
                LDR ballWidth, [ballWidth]

                ADD rightBorder, ballWidth

                MOV y, screenHeight, LSR #1

                netLoop:

                    ADD dashCounter, #1

                    BL DrawPixel

                    CMP dashCounter, #10
                    MOVEQ dashCounter, #0
                    ADDEQ x, #(10 + 1)
                    ADDNE x, #1
                    CMP x, rightBorder

                BLS netLoop

                .unreq x
                .unreq y
                .unreq dashCounter
                .unreq rightBorder
                .unreq screenHeight
                .unreq ballWidth

                POP { r0, r1, r2, r3, r4, r5, pc }

    .globl WipeBall
    WipeBall:   PUSH { r0, r1, r2, r3, r4, r5, r6, lr }

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

                POP { r0, r1, r2, r3, r4, r5, r6, pc }

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

    .globl DrawScore
    DrawScore:  PUSH { r0, r1, r2, r3, r4, r5, lr }

                x .req r0
                y .req r1
                scoreToDraw .req r2
                LDR scoreToDraw, =TopPlayerScore
                LDR scoreToDraw, [scoreToDraw]

                screenHeight .req r3
                LDR screenHeight, =FramebufferInfoAddress
                LDR screenHeight, [screenHeight]
                LDR screenHeight, [screenHeight, #4]

                screenWidth .req r4
                LDR screenWidth, =FramebufferInfoAddress
                LDR screenWidth, [screenWidth]
                LDR screenWidth, [screenWidth, #0]

                scoreMargin .req r5
                LDR scoreMargin, =ScoreMargin
                LDR scoreMargin, [scoreMargin]

                SUB x, screenWidth, scoreMargin
                ADD x, #130

                MOV y, screenHeight, LSR #1
                SUB y, #20

                BL WipeBigNumber

                CMP scoreToDraw, #0
                BLEQ DrawBigZero
                BEQ drawBottomScore

                CMP scoreToDraw, #1
                BLEQ DrawBigOne
                BEQ drawBottomScore

                CMP scoreToDraw, #2
                BLEQ DrawBigTwo
                BEQ drawBottomScore

                CMP scoreToDraw, #3
                BLEQ DrawBigThree
                BEQ drawBottomScore

                CMP scoreToDraw, #4
                BLEQ DrawBigFour
                BEQ drawBottomScore

                CMP scoreToDraw, #5
                BLEQ DrawBigFive
                BEQ drawBottomScore

                CMP scoreToDraw, #6
                BLEQ DrawBigSix
                BEQ drawBottomScore

                CMP scoreToDraw, #7
                BLEQ DrawBigSeven
                BEQ drawBottomScore

                CMP scoreToDraw, #8
                BLEQ DrawBigEight
                BEQ drawBottomScore

                CMP scoreToDraw, #9
                BLEQ DrawBigNine
                BEQ drawBottomScore

                drawBottomScore:

                    ADD y, #140

                    LDR scoreToDraw, =BottomPlayerScore
                    LDR scoreToDraw, [scoreToDraw]

                    BL WipeBigNumber

                    CMP scoreToDraw, #0
                    BLEQ DrawBigZero
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #1
                    BLEQ DrawBigOne
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #2
                    BLEQ DrawBigTwo
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #3
                    BLEQ DrawBigThree
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #4
                    BLEQ DrawBigFour
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #5
                    BLEQ DrawBigFive
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #6
                    BLEQ DrawBigSix
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #7
                    BLEQ DrawBigSeven
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #8
                    BLEQ DrawBigEight
                    BEQ drawingScoresFinished

                    CMP scoreToDraw, #9
                    BLEQ DrawBigNine
                    BEQ drawingScoresFinished

                drawingScoresFinished:

                    .unreq x
                    .unreq y
                    .unreq scoreToDraw
                    .unreq screenHeight
                    .unreq screenWidth
                    .unreq scoreMargin

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
