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

    ballDirectionY .req r4
    LDR ballDirectionY, =BallDirectionY
    LDR ballDirectionY, [ballDirectionY]

    newBallDirectionY .req r5

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
    SUB topPaddleLocationX, ballWidth                   // Ball's collision surface is its whole width

    bottomPaddleLocationX .req r11
    LDR bottomPaddleLocationX, =BottomPaddleLocationX
    LDR bottomPaddleLocationX, [bottomPaddleLocationX]
    SUB bottomPaddleLocationX, #1                       // Because of unsigned higher comparison (HI). It's >, not >=
    SUB bottomPaddleLocationX, ballWidth                // Ball's collision surface is its whole width

    // Top hit
        CMP ballDirectionY, #0
            BNE notGoingUp
            CMP x, topPaddleLocationX
                BLS bottomOfTopPaddleMissed
                ADD topPaddleLocationX, #1              // Because of unsigned lower-or-equal comparison (LS). It's <=
                ADD topPaddleLocationX, paddleWidth
                ADD topPaddleLocationX, #10
                CMP x, topPaddleLocationX
                    BHI bottomOfTopPaddleMissed
                    LSL paddleHeight, #1
                    ADD paddleHeight, #1                // At this height is the top paddle
                    CMP y, paddleHeight
                    B revertUpToDown

        bottomOfTopPaddleMissed:

            CMP y, #2

        revertUpToDown:

            MOVEQ newBallDirectionY, #1
            LDREQ ballDirectionY, =BallDirectionY
            STREQ newBallDirectionY, [ballDirectionY]
            MOVEQ ballDirectionY, newBallDirectionY

        notGoingUp:
    // Top hit

    // Bottom hit
        CMP ballDirectionY, #1
            BNE notGoingDown
            CMP x, bottomPaddleLocationX
                BLS topOfBottomPaddleMissed
                ADD bottomPaddleLocationX, #1                                   // Because of unsigned lower-or-equal comparison (LS). It's <=
                ADD bottomPaddleLocationX, paddleWidth
                ADD bottomPaddleLocationX, #10
                CMP x, bottomPaddleLocationX
                    BHI topOfBottomPaddleMissed
                    LDR paddleHeight, =PaddleHeight
                    LDR paddleHeight, [paddleHeight]
                    SUB paddleHeight, tableBottomBorder, paddleHeight, LSL #1
                    ADD paddleHeight, #1                                        // At this height is the bottom paddle
                    CMP y, paddleHeight
                    B revertDownToUp

        topOfBottomPaddleMissed:

            CMP y, tableBottomBorder

        revertDownToUp:

            MOVEQ newBallDirectionY, #0
            LDREQ ballDirectionY, =BallDirectionY    // TODO: te 3 linijki mozna zamknac w subrutynie dla top i bottom collision
            STREQ newBallDirectionY, [ballDirectionY]
            MOVEQ ballDirectionY, newBallDirectionY

        notGoingDown:
    // <- Bottom hit

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

    // Right border hit
        CMP ballDirectionX, #1
            BNE notGoingRight
            CMP y, topPaddleLocationY
                BHI leftSideOfTopPaddleMissed
                .unreq topPaddleLocationY
                topPaddleLocationX .req r10
                LDR topPaddleLocationX, =TopPaddleLocationX
                LDR topPaddleLocationX, [topPaddleLocationX]
                SUB topPaddleLocationX, #10                     // TODO
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
                SUB bottomPaddleLocationX, #10                     // TODO
                CMP x, bottomPaddleLocationX
                    BNE leftSideOfBothPaddlesMissed
                    B revertRightToLeft

        leftSideOfBothPaddlesMissed:

            CMP x, tableRightBorder

        revertRightToLeft:

            MOVEQ newBallDirectionX, #0
            LDREQ ballDirectionX, =BallDirectionX       // TODO: 3 linijki mozna uzyc ponownie
            STREQ newBallDirectionX, [ballDirectionX]
            MOVEQ ballDirectionX, newBallDirectionX

        notGoingRight:
    // <- Right border hit

    .unreq topPaddleLocationX
    topPaddleLocationY .req r10                                         // TODO: przydaloby sie zdefiniowac to tylko raz i trzymac to w rejestrze
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

    // Left border hit
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
                //ADD topPaddleLocationX, #11     // TODO: moze to 10 trzeba wcielic do paddle width
                CMP x, bottomPaddleLocationX
                    BNE rightSideOfBothPaddlesMissed
                    B revertLeftToRight

        rightSideOfBothPaddlesMissed:

            CMP x, #1

        revertLeftToRight:

            MOVEQ newBallDirectionX, #1
            LDREQ ballDirectionX, =BallDirectionX       // TODO: 3 linijki mozna uzyc ponownie
            STREQ newBallDirectionX, [ballDirectionX]
            MOVEQ ballDirectionX, newBallDirectionX

        notGoingLeft:
    // <- Left border hit

    CMP ballDirectionY, #1
    ADDEQ y, #1
    SUBNE y, #1

    CMP ballDirectionX, #1
    ADDEQ x, #1
    SUBNE x, #1

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
