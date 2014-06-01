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

                    //STR x, [topPaddleLocationX]
                    LDR x, [topPaddleLocationX]

                    y .req r1
                    MOV y, paddleHeight, LSL #1                 // y = paddleHeight * 2

                    topPaddleRowLoop:

                        topPaddleColumnLoop:

                            BL DrawPixel
                            ADD x, #1
                            SUB remainingPaddleWidth, #1
                            CMP remainingPaddleWidth, #0

                        BNE topPaddleColumnLoop

                        MOV remainingPaddleWidth, paddleWidth
                        SUB x, remainingPaddleWidth
                        SUB y, #1
                        SUB remainingPaddleHeight, #1
                        CMP remainingPaddleHeight, #0

                    BNE topPaddleRowLoop

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
    MoveTopPaddle:  PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, lr }

                    paddleHeight .req r2
                    LDR paddleHeight, =PaddleHeight
                    LDR paddleHeight, [paddleHeight]

                    remainingPaddleHeight .req r3
                    MOV remainingPaddleHeight, paddleHeight

                    paddleWidth .req r4
                    LDR paddleWidth, =PaddleWidth
                    LDR paddleWidth, [paddleWidth]

                    topPaddleLocationX .req r5
                    LDR topPaddleLocationX, =TopPaddleLocationX

                    scoreMargin .req r6
                    LDR scoreMargin, =ScoreMargin
                    LDR scoreMargin, [scoreMargin]
                    ADD scoreMargin, #1

                    screenWidth .req r7
                    LDR screenWidth, =FrameBufferInfo
                    LDR screenWidth, [screenWidth, #0]
                    SUB screenWidth, scoreMargin
                    SUB screenWidth, paddleWidth
                    ADD screenWidth, #1

                    x .req r0
                    LDR x, [topPaddleLocationX]

                    y .req r1
                    MOV y, paddleHeight, LSL #1                             // y = paddleHeight * 2

                    pinLevels .req r8
                    LDR pinLevels, =0x20200034
                    LDR pinLevels, [pinLevels]
                    LSR pinLevels, #7                                       // checking the level of 7th pin (left button)

                    ballPositionX .req r9
                    LDR ballPositionX, =BallPositionX
                    LDR ballPositionX, [ballPositionX]

                    ballPositionY .req r10
                    LDR ballPositionY, =BallPositionY
                    LDR ballPositionY, [ballPositionY]

                    ballWidth .req r11
                    LDR ballWidth, =BallWidth
                    LDR ballWidth, [ballWidth]

                    ADD ballPositionX, ballWidth

                    // Moving Left
                        TST pinLevels, #1                                           // Is input on pin 7 detected?
                        BEQ checkRightButton                                        // If not, and zero is detected, check the right button (pin 8).
                            CMP x, ballPositionX                                    
                                BNE ballMissedMovingLeft
                                CMP ballPositionY, y
                                BLS endOfButtonChecking

                                    ballMissedMovingLeft:

                                        CMP x, #1                                   // Paddle cannot cross the left border.
                                        BEQ endOfButtonChecking                     // If it does, stop it.
                                            BL WipeRightSideOfTopPaddle
                                            SUB x, #1

                                            movingLeftLeftSideOfTopPaddleRowLoop:

                                                BL DrawPixel

                                                SUB y, #1
                                                SUB remainingPaddleHeight, #1
                                                CMP remainingPaddleHeight, #0

                                            BNE movingLeftLeftSideOfTopPaddleRowLoop

                                            ADD y, paddleHeight
                                            MOV remainingPaddleHeight, paddleHeight
                                            STR x, [topPaddleLocationX]
                                            BL endOfButtonChecking
                    // <- Moving Left

                    // Moving Right
                        checkRightButton:

                            LSR pinLevels, #1                                           // Now, checking the 8th pin.
                            TST pinLevels, #1                                           // Is input on pin 7 detected?
                            BEQ endOfButtonChecking                                     // If not, finish button checking. No more buttons.
                                SUB ballPositionX, paddleWidth
                                SUB ballPositionX, ballWidth
                                SUB ballPositionX, #1
                                CMP x, ballPositionX
                                BNE ballMissedMovingRight
                                CMP ballPositionY, y
                                BLS endOfButtonChecking

                                    ballMissedMovingRight:

                                        CMP x, screenWidth                              // Check one more thing: paddle cannot cross the right border
                                        BEQ endOfButtonChecking                         // If it is crossing the right border, it cannot move further, finish button checking.
                                            BL WipeLeftSideOfTopPaddle                  // If not, wipe the left side and move right.
                                            ADD x, paddleWidth

                                            movingRightRightSideOfTopPaddleRowLoop:

                                                BL DrawPixel

                                                SUB y, #1
                                                SUB remainingPaddleHeight, #1
                                                CMP remainingPaddleHeight, #0

                                            BNE movingRightRightSideOfTopPaddleRowLoop

                                            ADD y, paddleHeight
                                            SUB x, paddleWidth
                                            ADD x, #1
                                            MOV remainingPaddleHeight, paddleHeight
                                            STR x, [topPaddleLocationX]
                                            B endOfButtonChecking
                    // <- Moving Right

                    endOfButtonChecking:

                    .unreq paddleWidth
                    .unreq paddleHeight
                    .unreq remainingPaddleHeight
                    .unreq topPaddleLocationX
                    .unreq x
                    .unreq y
                    .unreq pinLevels
                    .unreq scoreMargin
                    .unreq screenWidth

                    POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, pc }

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
                                SUB x, #1

                                rightSideOfTopPaddleRowLoop:

                                    BL DrawPixel

                                    SUB y, #1
                                    SUB remainingPaddleHeight, #1
                                    CMP remainingPaddleHeight, #0

                                BNE rightSideOfTopPaddleRowLoop

                                ADD y, paddleHeight
                                SUB x, paddleWidth
                                ADD x, #1
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
