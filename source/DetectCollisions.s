/*************************************************/
/* This file contains collision detection logic. */
/*                                               */
/* Author: Piotr Justyna                         */
/*************************************************/


.globl DetectCollisions
DetectCollisions:   PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr }

    x .req r0
    LDR x, =BallPositionX
    LDR x, [x]

    y .req r1
    LDR y, =BallPositionY
    LDR y, [y]

    ballDirectionX .req r2
    LDR ballDirectionX, =BallDirectionX
    LDR ballDirectionX, [ballDirectionX]

    newBallDirectionX .req r3
    MOV newBallDirectionX, ballDirectionX

    ballDirectionY .req r4
    LDR ballDirectionY, =BallDirectionY
    LDR ballDirectionY, [ballDirectionY]

    newBallDirectionY .req r5
    MOV newBallDirectionY, ballDirectionY

    tableRightBorder .req r6
    LDR tableRightBorder, =TableRightBorder
    LDR tableRightBorder, [tableRightBorder]

    tableBottomBorder .req r7
    LDR tableBottomBorder, =TableBottomBorder
    LDR tableBottomBorder, [tableBottomBorder]

    paddleWidth .req r8
    LDR paddleWidth, =PaddleWidth
    LDR paddleWidth, [paddleWidth]

    paddleHeight .req r9
    LDR paddleHeight, =PaddleHeight
    LDR paddleHeight, [paddleHeight]

    ballWidth .req r12
    LDR ballWidth, =BallWidth
    LDR ballWidth, [ballWidth]

    topPaddleLocationX .req r10
    LDR topPaddleLocationX, =TopPaddleLocationX
    LDR topPaddleLocationX, [topPaddleLocationX]
    SUB topPaddleLocationX, #1                          // Because of unsigned higher comparison (HI). It's >, not >=
    SUB topPaddleLocationX, ballWidth

    bottomPaddleLocationX .req r11
    LDR bottomPaddleLocationX, =BottomPaddleLocationX
    LDR bottomPaddleLocationX, [bottomPaddleLocationX]
    SUB bottomPaddleLocationX, #1                       // Because of unsigned higher comparison (HI). It's >, not >=
    SUB bottomPaddleLocationX, ballWidth                // Ball's collision surface is its whole width

    topHit:

        CMP ballDirectionY, #0
            BNE bottomHit
            CMP x, topPaddleLocationX
                BLS bottomOfTopPaddleMissed
                ADD topPaddleLocationX, #1              // Because of unsigned lower-or-equal comparison (LS). It's <=
                ADD topPaddleLocationX, paddleWidth
                ADD topPaddleLocationX, ballWidth
                CMP x, topPaddleLocationX
                    BHI bottomOfTopPaddleMissed
                    LSL paddleHeight, #1
                    ADD paddleHeight, #1
                    CMP y, paddleHeight
                    B revertUpToDown

        bottomOfTopPaddleMissed:

            CMP y, #2

        revertUpToDown:

            MOVEQ ballDirectionY, #1

    bottomHit:

        CMP ballDirectionY, #1
            BNE notGoingDown
            CMP x, bottomPaddleLocationX
                BLS topOfBottomPaddleMissed
                ADD bottomPaddleLocationX, #1                                   // Because of unsigned lower-or-equal comparison (LS). It's <=
                ADD bottomPaddleLocationX, paddleWidth
                ADD bottomPaddleLocationX, ballWidth
                CMP x, bottomPaddleLocationX
                    BHI topOfBottomPaddleMissed
                    LDR paddleHeight, =PaddleHeight
                    LDR paddleHeight, [paddleHeight]
                    SUB paddleHeight, tableBottomBorder, paddleHeight, LSL #1
                    ADD paddleHeight, #1
                    CMP y, paddleHeight
                    B revertDownToUp

        topOfBottomPaddleMissed:

            CMP y, tableBottomBorder

        revertDownToUp:

            MOVEQ ballDirectionY, #0

        notGoingDown:

    LDR paddleHeight, =PaddleHeight
    LDR paddleHeight, [paddleHeight]

    .unreq topPaddleLocationX
    topPaddleLocationY .req r10
    LDR topPaddleLocationY, =PaddleHeight
    LDR topPaddleLocationY, [topPaddleLocationY]
    LSL topPaddleLocationY, #1
    ADD topPaddleLocationY, #1

    .unreq bottomPaddleLocationX
    bottomPaddleLocationY .req r11
    LDR bottomPaddleLocationY, =PaddleHeight
    LDR bottomPaddleLocationY, [bottomPaddleLocationY]
    LSL bottomPaddleLocationY, #1
    SUB bottomPaddleLocationY, tableBottomBorder, paddleHeight, LSL #1

    rightBorderHit:

        CMP ballDirectionX, #1
            BNE notGoingRight
            CMP y, topPaddleLocationY
                BHI leftSideOfTopPaddleMissed
                .unreq topPaddleLocationY
                topPaddleLocationX .req r10
                LDR topPaddleLocationX, =TopPaddleLocationX
                LDR topPaddleLocationX, [topPaddleLocationX]
                SUB topPaddleLocationX, ballWidth
                CMP x, topPaddleLocationX
                    BNE leftSideOfTopPaddleMissed
                    B revertRightToLeft
        leftSideOfTopPaddleMissed:

            CMP y, bottomPaddleLocationY
                BLS leftSideOfBothPaddlesMissed
                .unreq bottomPaddleLocationY
                bottomPaddleLocationX .req r10
                LDR bottomPaddleLocationX, =BottomPaddleLocationX
                LDR bottomPaddleLocationX, [bottomPaddleLocationX]
                SUB bottomPaddleLocationX, ballWidth
                CMP x, bottomPaddleLocationX
                    BNE leftSideOfBothPaddlesMissed
                    B revertRightToLeft

        leftSideOfBothPaddlesMissed:

            CMP x, tableRightBorder

        revertRightToLeft:

            MOVEQ ballDirectionX, #0

        notGoingRight:

    .unreq topPaddleLocationX
    topPaddleLocationY .req r10
    LDR topPaddleLocationY, =PaddleHeight
    LDR topPaddleLocationY, [topPaddleLocationY]
    LSL topPaddleLocationY, #1
    ADD topPaddleLocationY, #1

    .unreq bottomPaddleLocationX
    bottomPaddleLocationY .req r11
    LDR bottomPaddleLocationY, =PaddleHeight
    LDR bottomPaddleLocationY, [bottomPaddleLocationY]
    LSL bottomPaddleLocationY, #1
    SUB bottomPaddleLocationY, tableBottomBorder, paddleHeight, LSL #1

    leftBorderHit:

        CMP ballDirectionX, #0
            BNE notGoingLeft
            CMP y, topPaddleLocationY
                BHI rightSideOfTopPaddleMissed
                .unreq topPaddleLocationY
                topPaddleLocationX .req r10
                LDR topPaddleLocationX, =TopPaddleLocationX
                LDR topPaddleLocationX, [topPaddleLocationX]
                ADD topPaddleLocationX, paddleWidth
                CMP x, topPaddleLocationX
                    BNE rightSideOfTopPaddleMissed
                    B revertLeftToRight
        rightSideOfTopPaddleMissed:

            CMP y, bottomPaddleLocationY
                BLS rightSideOfBothPaddlesMissed
                .unreq bottomPaddleLocationY
                bottomPaddleLocationX .req r10
                LDR bottomPaddleLocationX, =BottomPaddleLocationX
                LDR bottomPaddleLocationX, [bottomPaddleLocationX]
                ADD bottomPaddleLocationX, paddleWidth
                CMP x, bottomPaddleLocationX
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

    CMP ballDirectionX, newBallDirectionX
    LDRNE newBallDirectionX, =BallDirectionX
    STRNE ballDirectionX, [newBallDirectionX]

    CMP ballDirectionY, newBallDirectionY
    LDRNE newBallDirectionY, =BallDirectionY
    STRNE ballDirectionY, [newBallDirectionY]

    .unreq ballDirectionX
    newBallPositionX .req r2
    LDR newBallPositionX, =BallPositionX
    STR x, [newBallPositionX]

    .unreq newBallDirectionX
    newBallPositionY .req r3
    LDR newBallPositionY, =BallPositionY
    STR y, [newBallPositionY]

    .unreq x
    .unreq y
    .unreq newBallPositionX
    .unreq newBallPositionY
    .unreq ballDirectionY
    .unreq newBallDirectionY
    .unreq tableRightBorder
    .unreq tableBottomBorder
    .unreq topPaddleLocationX
    .unreq bottomPaddleLocationX
    .unreq paddleWidth
    .unreq paddleHeight

POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, pc }
