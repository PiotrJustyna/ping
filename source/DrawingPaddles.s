/***************************************************/
/* This file contains paddles drawing subroutines. */
/*                                                 */
/* Author: Piotr Justyna                           */
/***************************************************/

.section .text

    .globl DrawTopPaddle
    DrawTopPaddle:  PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, lr }

                    paddleWidth .req r2
                    LDR paddleWidth, =PaddleWidth
                    LDR paddleWidth, [paddleWidth]

                    remainingPaddleWidth .req r3
                    MOV remainingPaddleWidth, paddleWidth

                    paddleHeight .req r4
                    LDR paddleHeight, =PaddleHeight
                    LDR paddleHeight, [paddleHeight]

                    remainingPaddleHeight .req r5
                    MOV remainingPaddleHeight, paddleHeight

                    screenWidth .req r6
                    LDR screenWidth, =FrameBufferInfo
                    LDR screenWidth, [screenWidth, #0]

                    scoreMargin .req r7
                    LDR scoreMargin, =ScoreMargin
                    LDR scoreMargin, [scoreMargin]

                    topPaddleLocationX .req r8
                    LDR topPaddleLocationX, =TopPaddleLocationX

                    x .req r0
                    SUB x, screenWidth, scoreMargin
                    SUB x, paddleWidth
                    LSR x, #1                                   // x = (screenWidth - scoreMargin - paddleWidth) / 2

                    STR x, [topPaddleLocationX]

                    y .req r1
                    MOV y, paddleHeight, LSL #1                 // y = paddleHeight * 2

                    topPaddleRowLoop1:

                        topPaddleColumnLoop1:

                            BL DrawPixel
                            ADD x, #1
                            SUB remainingPaddleWidth, #1
                            CMP remainingPaddleWidth, #0

                        BNE topPaddleColumnLoop1

                        MOV remainingPaddleWidth, paddleWidth
                        SUB x, remainingPaddleWidth
                        SUB y, #1
                        SUB remainingPaddleHeight, #1
                        CMP remainingPaddleHeight, #0

                    BNE topPaddleRowLoop1

                    .unreq paddleWidth
                    .unreq remainingPaddleWidth
                    .unreq paddleHeight
                    .unreq remainingPaddleHeight
                    .unreq screenWidth
                    .unreq scoreMargin
                    .unreq topPaddleLocationX
                    .unreq x
                    .unreq y

                    POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, pc }

    .globl MoveTopPaddle
    MoveTopPaddle:  PUSH { r0, r1, r2, r3, r4, r5, r6, r7, lr }

                    paddleHeight .req r2
                    LDR paddleHeight, =PaddleHeight
                    LDR paddleHeight, [paddleHeight]

                    remainingPaddleHeight .req r3
                    MOV remainingPaddleHeight, paddleHeight

                    paddleWidth .req r4
                    LDR paddleWidth, =PaddleWidth
                    LDR paddleWidth, [paddleWidth]

                    remainingPaddleWidth .req r5
                    MOV remainingPaddleWidth, paddleWidth

                    topPaddleLocationX .req r6
                    LDR topPaddleLocationX, =TopPaddleLocationX

                    x .req r0
                    LDR x, [topPaddleLocationX]

                    y .req r1
                    MOV y, paddleHeight, LSL #1     // y = paddleHeight * 2

                    pinLevels .req r7
                    LDR pinLevels, =0x20200034
                    LDR pinLevels, [pinLevels]
                    LSR pinLevels, #7

                    // Moving Right
                        TST pinLevels, #1
                        BNE checkLeftButton
                        BL WipeLeftSideOfTopPaddle
                        ADD x, #1
                        ADD x, paddleWidth

                        leftSideOfTopPaddleRowLoop1:

                            BL DrawPixel

                            SUB y, #1
                            SUB remainingPaddleHeight, #1
                            CMP remainingPaddleHeight, #0

                        BNE leftSideOfTopPaddleRowLoop1

                        ADD y, paddleHeight
                        SUB x, paddleWidth
                        MOV remainingPaddleHeight, paddleHeight
                    // <- Moving Right

                    // Moving Left
                        checkLeftButton:

                            LSR pinLevels, #1
                            TST pinLevels, #1
                            BNE endOfButtonChecking
                            BL WipeRightSideOfTopPaddle
                            SUB x, #1

                            leftSideOfTopPaddleRowLoop2:

                                BL DrawPixel

                                SUB y, #1
                                SUB remainingPaddleHeight, #1
                                CMP remainingPaddleHeight, #0

                            BNE leftSideOfTopPaddleRowLoop2

                            ADD y, paddleHeight
                            MOV remainingPaddleHeight, paddleHeight
                    // <- Moving Left

                    endOfButtonChecking:

                        STR x, [topPaddleLocationX]

                    .unreq paddleWidth
                    .unreq paddleHeight
                    .unreq remainingPaddleWidth
                    .unreq remainingPaddleHeight
                    .unreq topPaddleLocationX
                    .unreq x
                    .unreq y

                    POP { r0, r1, r2, r3, r4, r5, r6, r7, pc }

    .globl WipeLeftSideOfTopPaddle
    WipeLeftSideOfTopPaddle:    PUSH { r4, r5, lr }

                                x .req r0
                                y .req r1
                                paddleHeight .req r2
                                remainingPaddleHeight .req r3

                                foregroundColourValue .req r4
                                LDR foregroundColourValue, =BackgroundColour
                                LDR foregroundColourValue, [foregroundColourValue]

                                foregroundColourAddress .req r5
                                LDR foregroundColourAddress, =ForegoundColour
                                STR foregroundColourValue, [foregroundColourAddress]

                                leftSideOfTopPaddleRowLoop:

                                    BL DrawPixel

                                    SUB y, #1
                                    SUB remainingPaddleHeight, #1
                                    CMP remainingPaddleHeight, #0

                                BNE leftSideOfTopPaddleRowLoop

                                ADD y, paddleHeight
                                MOV remainingPaddleHeight, paddleHeight

                                LDR foregroundColourValue, =GreenColour
                                LDR foregroundColourValue, [foregroundColourValue]
                                STR foregroundColourValue, [foregroundColourAddress]

                                .unreq x
                                .unreq y
                                .unreq paddleHeight
                                .unreq remainingPaddleHeight
                                .unreq foregroundColourValue
                                .unreq foregroundColourAddress

                                POP { r4, r5, pc }

    .globl WipeRightSideOfTopPaddle
    WipeRightSideOfTopPaddle:   PUSH { r5, r6, lr }

                                x .req r0
                                y .req r1
                                paddleHeight .req r2
                                remainingPaddleHeight .req r3
                                paddleWidth .req r4

                                foregroundColourValue .req r5
                                LDR foregroundColourValue, =BackgroundColour
                                LDR foregroundColourValue, [foregroundColourValue]

                                foregroundColourAddress .req r6
                                LDR foregroundColourAddress, =ForegoundColour
                                STR foregroundColourValue, [foregroundColourAddress]

                                ADD x, paddleWidth

                                rightSideOfTopPaddleRowLoop:

                                    BL DrawPixel

                                    SUB y, #1
                                    SUB remainingPaddleHeight, #1
                                    CMP remainingPaddleHeight, #0

                                BNE rightSideOfTopPaddleRowLoop

                                ADD y, paddleHeight
                                SUB x, paddleWidth
                                MOV remainingPaddleHeight, paddleHeight

                                LDR foregroundColourValue, =GreenColour
                                LDR foregroundColourValue, [foregroundColourValue]
                                STR foregroundColourValue, [foregroundColourAddress]

                                .unreq x
                                .unreq y
                                .unreq paddleHeight
                                .unreq remainingPaddleHeight
                                .unreq paddleWidth
                                .unreq foregroundColourValue
                                .unreq foregroundColourAddress

                                POP { r5, r6, pc }
