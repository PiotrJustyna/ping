/*************************************************/
/* This file contains collision detection logic. */
/*                                               */
/* Author: Piotr Justyna                         */
/*************************************************/

.section .text

    .globl DetectCollisions
    DetectCollisions:   PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr }

                        paddleWidth .req r0
                        LDR paddleWidth, =PaddleWidth
                        LDR paddleWidth, [paddleWidth]

                        paddleHeight .req r1
                        LDR paddleHeight, =PaddleHeight
                        LDR paddleHeight, [paddleHeight]

                        ballWidth .req r2
                        LDR ballWidth, =BallWidth
                        LDR ballWidth, [ballWidth]

                        ballDirectionX .req r3
                        LDR ballDirectionX, =BallDirectionX
                        LDR ballDirectionX, [ballDirectionX]

                        ballDirectionY .req r4
                        LDR ballDirectionY, =BallDirectionY
                        LDR ballDirectionY, [ballDirectionY]

                        tableRightBorder .req r5
                        LDR tableRightBorder, =TableRightBorder
                        LDR tableRightBorder, [tableRightBorder]

                        tableBottomBorder .req r6
                        LDR tableBottomBorder, =TableBottomBorder
                        LDR tableBottomBorder, [tableBottomBorder]

                        topPaddleLocationLeftCornerX .req r7
                        LDR topPaddleLocationLeftCornerX, =TopPaddleLocationX
                        LDR topPaddleLocationLeftCornerX, [topPaddleLocationLeftCornerX]
                        SUB topPaddleLocationLeftCornerX, #1
                        SUB topPaddleLocationLeftCornerX, ballWidth

                        topPaddleLocationRightCornerX .req r8
                        ADD topPaddleLocationRightCornerX, topPaddleLocationLeftCornerX, #1
                        ADD topPaddleLocationRightCornerX, paddleWidth
                        ADD topPaddleLocationRightCornerX, ballWidth

                        topPaddleLocationY .req r9
                        LSL topPaddleLocationY, paddleHeight, #1
                        ADD topPaddleLocationY, #1

                        bottomPaddleLocationLeftCornerX .req r10
                        LDR bottomPaddleLocationLeftCornerX, =BottomPaddleLocationX
                        LDR bottomPaddleLocationLeftCornerX, [bottomPaddleLocationLeftCornerX]
                        SUB bottomPaddleLocationLeftCornerX, #1
                        SUB bottomPaddleLocationLeftCornerX, ballWidth

                        bottomPaddleLocationRightCornerX .req r11
                        ADD bottomPaddleLocationRightCornerX, bottomPaddleLocationLeftCornerX, #1
                        ADD bottomPaddleLocationRightCornerX, paddleWidth
                        ADD bottomPaddleLocationRightCornerX, ballWidth

                        bottomPaddleLocationY .req r12
                        SUB bottomPaddleLocationY, tableBottomBorder, paddleHeight, LSL #1
                        ADD bottomPaddleLocationY, #1

                        .unreq paddleWidth
                        x .req r0
                        LDR x, =BallPositionX
                        LDR x, [x]

                        .unreq paddleHeight
                        y .req r1
                        LDR y, =BallPositionY
                        LDR y, [y]

                        .unreq ballWidth
                        ballDirection .req r2

                        topHit:

                            CMP ballDirectionY, #0
                                BNE bottomHit
                                CMP x, topPaddleLocationLeftCornerX
                                    BLS bottomOfTopPaddleMissed
                                    CMP x, topPaddleLocationRightCornerX
                                        BHI bottomOfTopPaddleMissed
                                        CMP y, topPaddleLocationY
                                        B revertUpToDown

                            bottomOfTopPaddleMissed:

                                CMP y, #2

                            revertUpToDown:

                                MOVEQ ballDirectionY, #1

                        bottomHit:

                            CMP ballDirectionY, #1
                                BNE rightBorderHit
                                CMP x, bottomPaddleLocationLeftCornerX
                                    BLS topOfBottomPaddleMissed
                                    CMP x, bottomPaddleLocationRightCornerX
                                        BHI topOfBottomPaddleMissed
                                        CMP y, bottomPaddleLocationY
                                        B revertDownToUp

                            topOfBottomPaddleMissed:

                                CMP y, tableBottomBorder

                            revertDownToUp:

                                MOVEQ ballDirectionY, #0

                        rightBorderHit:

                            CMP ballDirectionX, #1
                                BNE leftBorderHit
                                CMP y, topPaddleLocationY
                                    BHI leftSideOfTopPaddleMissed
                                    CMP x, topPaddleLocationLeftCornerX
                                        BNE leftSideOfTopPaddleMissed
                                        B revertRightToLeft

                            leftSideOfTopPaddleMissed:

                                CMP y, bottomPaddleLocationY
                                    BLS leftSideOfBothPaddlesMissed
                                    CMP x, bottomPaddleLocationLeftCornerX
                                        BNE leftSideOfBothPaddlesMissed
                                        B revertRightToLeft

                            leftSideOfBothPaddlesMissed:

                                CMP x, tableRightBorder

                            revertRightToLeft:

                                MOVEQ ballDirectionX, #0

                        leftBorderHit:

                            CMP ballDirectionX, #0
                                BNE notGoingLeft
                                CMP y, topPaddleLocationY
                                    BHI rightSideOfTopPaddleMissed
                                    CMP x, topPaddleLocationRightCornerX
                                        BNE rightSideOfTopPaddleMissed
                                        B revertLeftToRight

                            rightSideOfTopPaddleMissed:

                                CMP y, bottomPaddleLocationY
                                    BLS rightSideOfBothPaddlesMissed
                                    CMP x, bottomPaddleLocationRightCornerX
                                        BNE rightSideOfBothPaddlesMissed
                                        B revertLeftToRight

                            rightSideOfBothPaddlesMissed:

                                CMP x, #1

                            revertLeftToRight:

                                MOVEQ ballDirectionX, #1

                            notGoingLeft:

                        CMP ballDirectionY, #1
                        ADDEQ y, #1
                        SUBNE y, #1

                        CMP ballDirectionX, #1
                        ADDEQ x, #1
                        SUBNE x, #1

                        LDR ballDirection, =BallDirectionX
                        STR ballDirectionX, [ballDirection]

                        LDR ballDirection, =BallDirectionY
                        STR ballDirectionY, [ballDirection]

                        .unreq ballDirection
                        newBallPosition .req r2

                        LDR newBallPosition, =BallPositionX
                        STR x, [newBallPosition]

                        LDR newBallPosition, =BallPositionY
                        STR y, [newBallPosition]

                        .unreq x
                        .unreq y
                        .unreq newBallPosition
                        .unreq ballDirectionX
                        .unreq ballDirectionY
                        .unreq tableRightBorder
                        .unreq tableBottomBorder
                        .unreq topPaddleLocationLeftCornerX
                        .unreq topPaddleLocationRightCornerX
                        .unreq topPaddleLocationY
                        .unreq bottomPaddleLocationLeftCornerX
                        .unreq bottomPaddleLocationRightCornerX
                        .unreq bottomPaddleLocationY

                        POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, pc }
