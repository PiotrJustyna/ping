/**********************************/
/* This file contains game rules. */
/*                                */
/* Author: Piotr Justyna          */
/**********************************/

.section .text

	.globl TopPlayerShootsLeft
	TopPlayerShootsLeft:	PUSH { r0, r1, lr }

                            // Setting ball posession
                                topPlayerPosessionAddress .req r0
                                LDR topPlayerPosessionAddress, =TopPlayerHasTheBall

                                topPlayerPosession .req r1
                                LDR topPlayerPosession, [topPlayerPosessionAddress]

                                CMP topPlayerPosession, #0
                                BEQ topPlayerCannotShootLeft
                                MOV topPlayerPosession, #0
                                STR topPlayerPosession, [topPlayerPosessionAddress]
                            // <- Setting ball posession

                            .unreq topPlayerPosessionAddress
                            .unreq topPlayerPosession

                            // Setting ball direction
                            	ballDirectionXAddress .req r0
                            	LDR ballDirectionXAddress, =BallDirectionX

                            	newBallDirectionX .req r1
                            	MOV newBallDirectionX, #0

                            	STR newBallDirectionX, [ballDirectionXAddress]

                            	.unreq ballDirectionXAddress
                            	.unreq newBallDirectionX

                            	ballDirectionYAddress .req r0
                            	LDR ballDirectionYAddress, =BallDirectionY

                            	newBallDirectionY .req r1
                            	MOV newBallDirectionY, #1

                            	STR newBallDirectionY, [ballDirectionYAddress]

                            	.unreq ballDirectionYAddress
                            	.unreq newBallDirectionY
                            // <- Setting ball direction

                            // Releasing the ball
		                        canBallMoveAddress .req r0
		                        LDR canBallMoveAddress, =CanBallMove

		                        canBallMove .req r1
		                        MOV canBallMove, #1

		                        STR canBallMove, [canBallMoveAddress]

		                        .unreq canBallMoveAddress
								.unreq canBallMove
                            // <- Releasing the ball

                            topPlayerCannotShootLeft:

							POP { r0, r1, pc }

	.globl TopPlayerShootsRight
	TopPlayerShootsRight:	PUSH { r0, r1, lr }

                            // Setting ball posession
                                topPlayerPosessionAddress .req r0
                                LDR topPlayerPosessionAddress, =TopPlayerHasTheBall

                                topPlayerPosession .req r1
                                LDR topPlayerPosession, [topPlayerPosessionAddress]

                                CMP topPlayerPosession, #0
                                BEQ topPlayerCannotShootRight
                                MOV topPlayerPosession, #0
                                STR topPlayerPosession, [topPlayerPosessionAddress]
                            // <- Setting ball posession

                            .unreq topPlayerPosessionAddress
                            .unreq topPlayerPosession

                            // Setting ball direction
                            	ballDirectionXAddress .req r0
                            	LDR ballDirectionXAddress, =BallDirectionX

                            	newBallDirectionX .req r1
                            	MOV newBallDirectionX, #1

                            	STR newBallDirectionX, [ballDirectionXAddress]

                            	.unreq ballDirectionXAddress
                            	.unreq newBallDirectionX

                            	ballDirectionYAddress .req r0
                            	LDR ballDirectionYAddress, =BallDirectionY

                            	newBallDirectionY .req r1
                            	MOV newBallDirectionY, #1

                            	STR newBallDirectionY, [ballDirectionYAddress]

                            	.unreq ballDirectionYAddress
                            	.unreq newBallDirectionY
                            // <- Setting ball direction

                            // Releasing the ball
		                        canBallMoveAddress .req r0
		                        LDR canBallMoveAddress, =CanBallMove

		                        canBallMove .req r1
		                        MOV canBallMove, #1

		                        STR canBallMove, [canBallMoveAddress]

		                        .unreq canBallMoveAddress
								.unreq canBallMove
                            // <- Releasing the ball

                            topPlayerCannotShootRight:

							POP { r0, r1, pc }

	.globl BottomPlayerShootsLeft
	BottomPlayerShootsLeft:	PUSH { r0, r1, lr }

                            // Setting ball posession
                                bottomPlayerPosessionAddress .req r0
                                LDR bottomPlayerPosessionAddress, =BottomPlayerHasTheBall

                                bottomPlayerPosession .req r1
                                LDR  bottomPlayerPosession, [bottomPlayerPosessionAddress]

                                CMP bottomPlayerPosession, #0
                                BEQ bottomPlayerCannotShootLeft
                                MOV bottomPlayerPosession, #0
                                STR bottomPlayerPosession, [bottomPlayerPosessionAddress]
                            // <- Setting ball posession

                            .unreq bottomPlayerPosessionAddress
                            .unreq bottomPlayerPosession

                            // Setting ball direction
                            	ballDirectionXAddress .req r0
                            	LDR ballDirectionXAddress, =BallDirectionX

                            	newBallDirectionX .req r1
                            	MOV newBallDirectionX, #0

                            	STR newBallDirectionX, [ballDirectionXAddress]

                            	.unreq ballDirectionXAddress
                            	.unreq newBallDirectionX

                            	ballDirectionYAddress .req r0
                            	LDR ballDirectionYAddress, =BallDirectionY

                            	newBallDirectionY .req r1
                            	MOV newBallDirectionY, #0

                            	STR newBallDirectionY, [ballDirectionYAddress]

                            	.unreq ballDirectionYAddress
                            	.unreq newBallDirectionY
                            // <- Setting ball direction

                            // Releasing the ball
		                        canBallMoveAddress .req r0
		                        LDR canBallMoveAddress, =CanBallMove

		                        canBallMove .req r1
		                        MOV canBallMove, #1

		                        STR canBallMove, [canBallMoveAddress]

		                        .unreq canBallMoveAddress
								.unreq canBallMove
                            // <- Releasing the ball

							bottomPlayerCannotShootLeft:

							POP { r0, r1, pc }

	.globl BottomPlayerShootsRight
	BottomPlayerShootsRight:	PUSH { r0, r1, lr }

	                            // Setting ball posession
	                                bottomPlayerPosessionAddress .req r0
	                                LDR bottomPlayerPosessionAddress, =BottomPlayerHasTheBall

	                                bottomPlayerPosession .req r1
	                                LDR bottomPlayerPosession, [bottomPlayerPosessionAddress]

	                                CMP bottomPlayerPosession, #0
	                                BEQ bottomPlayerCannotShootRight
	                                MOV bottomPlayerPosession, #0
	                                STR bottomPlayerPosession, [bottomPlayerPosessionAddress]
	                            // <- Setting ball posession

	                            .unreq bottomPlayerPosessionAddress
	                            .unreq bottomPlayerPosession

	                            // Setting ball direction
	                            	ballDirectionXAddress .req r0
	                            	LDR ballDirectionXAddress, =BallDirectionX

	                            	newBallDirectionX .req r1
	                            	MOV newBallDirectionX, #1

	                            	STR newBallDirectionX, [ballDirectionXAddress]

	                            	.unreq ballDirectionXAddress
	                            	.unreq newBallDirectionX

	                            	ballDirectionYAddress .req r0
	                            	LDR ballDirectionYAddress, =BallDirectionY

	                            	newBallDirectionY .req r1
	                            	MOV newBallDirectionY, #0

	                            	STR newBallDirectionY, [ballDirectionYAddress]

	                            	.unreq ballDirectionYAddress
	                            	.unreq newBallDirectionY
	                            // <- Setting ball direction

	                            // Releasing the ball
			                        canBallMoveAddress .req r0
			                        LDR canBallMoveAddress, =CanBallMove

			                        canBallMove .req r1
			                        MOV canBallMove, #1

			                        STR canBallMove, [canBallMoveAddress]

			                        .unreq canBallMoveAddress
									.unreq canBallMove
	                            // <- Releasing the ball

	                            bottomPlayerCannotShootRight:

								POP { r0, r1, pc }

    .globl BottomPlayerScores
    BottomPlayerScores: PUSH { r0, r1, r2, r3, lr }

                        bottomPlayersScoreAddress .req r0
                        LDR bottomPlayersScoreAddress, =BottomPlayerScore

                        bottomPlayersScore .req r1
                        LDR bottomPlayersScore, [bottomPlayersScoreAddress]
                        ADD bottomPlayersScore, #1

                        currentFrameTime .req r2
                        LDR currentFrameTime, =FrameTime

                        slowFrameTime .req r3
                        LDR slowFrameTime, =SlowFrameTime
                        LDR slowFrameTime, [slowFrameTime]

                        STR slowFrameTime, [currentFrameTime]

                        CMP bottomPlayersScore, #9
                        MOVHI bottomPlayersScore, #0

                        STR bottomPlayersScore, [bottomPlayersScoreAddress]

                        BL DrawScore

                        .unreq bottomPlayersScoreAddress
                        .unreq bottomPlayersScore
                        .unreq currentFrameTime
                        .unreq slowFrameTime

                        canPaddlesMoveAddress .req r0
                        LDR canPaddlesMoveAddress, =CanPaddlesMove

                        canPaddlesMove .req r1
                        MOV canPaddlesMove, #0

                        STR canPaddlesMove, [canPaddlesMoveAddress]

                        .unreq canPaddlesMoveAddress
						.unreq canPaddlesMove

						BL DrawBottomAvatarWinning
						BL DrawTopAvatarLosing

                        POP { r0, r1, r2, r3, pc }

    .globl TopPlayerScores
    TopPlayerScores:    PUSH { r0, r1, r2, r3, lr }

                        topPlayersScoreAddress .req r0
                        LDR topPlayersScoreAddress, =TopPlayerScore

                        topPlayersScore .req r1
                        LDR topPlayersScore, [topPlayersScoreAddress]
                        ADD topPlayersScore, #1

                        currentFrameTime .req r2
                        LDR currentFrameTime, =FrameTime

                        slowFrameTime .req r3
                        LDR slowFrameTime, =SlowFrameTime
                        LDR slowFrameTime, [slowFrameTime]

                        STR slowFrameTime, [currentFrameTime]

                        CMP topPlayersScore, #9
                        MOVHI topPlayersScore, #0

                        STR topPlayersScore, [topPlayersScoreAddress]

                        BL DrawScore

                        .unreq topPlayersScoreAddress
                        .unreq topPlayersScore
                        .unreq currentFrameTime
                        .unreq slowFrameTime

                        canPaddlesMoveAddress .req r0
                        LDR canPaddlesMoveAddress, =CanPaddlesMove

                        canPaddlesMove .req r1
                        MOV canPaddlesMove, #0

                        STR canPaddlesMove, [canPaddlesMoveAddress]

                        .unreq canPaddlesMoveAddress
						.unreq canPaddlesMove

						BL DrawBottomAvatarLosing
						BL DrawTopAvatarWinning

                        POP { r0, r1, r2, r3, pc }

    .globl BottomPlayerGetsTheBall
    BottomPlayerGetsTheBall:    PUSH { r0, r1, r2, lr }

	                            // Resetting ball position
	                                ballPositionXAddress .req r0
	                                LDR ballPositionXAddress, =BallPositionX

	                                paddleWidth .req r1
	                                LDR paddleWidth, =PaddleWidth
	                                LDR paddleWidth, [paddleWidth]
	                                LSR paddleWidth, #1

	                                newBallPosition .req r2
	                                LDR newBallPosition, =BottomPaddleLocationX
	                                LDR newBallPosition, [newBallPosition]
	                                ADD newBallPosition, paddleWidth

	                                STR newBallPosition, [ballPositionXAddress]

	                                .unreq ballPositionXAddress
	                                .unreq paddleWidth

	                                ballPositionYAddress .req r0
	                                LDR ballPositionYAddress, =BallPositionY

	                                screenHeight .req r1
		                            LDR screenHeight, =FrameBufferInfo
		                            LDR screenHeight, [screenHeight, #4]

	                                MOV newBallPosition, screenHeight

	                                .unreq screenHeight
	                                ballHeight .req r1
	                                LDR  ballHeight, =BallHeight
	                                LDR ballHeight, [ballHeight]

	                                SUB newBallPosition, ballHeight

	                                .unreq ballHeight

	                                paddleHeight .req r1
	                                LDR paddleHeight, =PaddleHeight
	                                LDR paddleHeight, [paddleHeight]
	                                LSL paddleHeight, #1

	                                SUB newBallPosition, paddleHeight
	                                SUB newBallPosition, #1
	                                STR newBallPosition, [ballPositionYAddress]

	                                .unreq ballPositionYAddress
	                                .unreq newBallPosition
	                            // <- Resetting ball position

                                // Resetting ball direction
                                    ballDirectionXAddress .req r0
                                    LDR ballDirectionXAddress, =BallDirectionX

                                    newBallDirection, .req r1
                                    MOV newBallDirection, #0

                                    STR newBallDirection, [ballDirectionXAddress]

                                    .unreq ballDirectionXAddress


                                    ballDirectionYAddress .req r0
                                    LDR ballDirectionYAddress, =BallDirectionY

                                    Str newBallDirection, [ballDirectionYAddress]

                                    .unreq ballDirectionYAddress
                                    .unreq newBallDirection
                                // <- Resetting ball direction

                                // Resetting frame time
                                    currentFrameTime .req r0
                                    LDR currentFrameTime, =FrameTime

                                    fastFrameTime .req r1
                                    LDR fastFrameTime, =FastFrameTime
                                    LDR fastFrameTime, [fastFrameTime]

                                    STR fastFrameTime, [currentFrameTime]
                                // <- Resetting frame time

                                .unreq currentFrameTime
                                .unreq fastFrameTime

                                // Setting ball posession
                                    bottomPlayerPosessionAddress .req r0
                                    LDR bottomPlayerPosessionAddress, =BottomPlayerHasTheBall

                                    bottomPlayerPosession .req r1
                                    MOV bottomPlayerPosession, #1

                                    STR bottomPlayerPosession, [bottomPlayerPosessionAddress]
                                // <- Setting ball posession

                                .unreq bottomPlayerPosessionAddress
                                .unreq bottomPlayerPosession

		                        canPaddlesMoveAddress .req r0
		                        LDR canPaddlesMoveAddress, =CanPaddlesMove

		                        canPaddlesMove .req r1
		                        MOV canPaddlesMove, #1

		                        STR canPaddlesMove, [canPaddlesMoveAddress]

		                        .unreq canPaddlesMoveAddress
								.unreq canPaddlesMove

		                        canBallMoveAddress .req r0
		                        LDR canBallMoveAddress, =CanBallMove

		                        canBallMove .req r1
		                        MOV canBallMove, #0

		                        STR canBallMove, [canBallMoveAddress]

		                        .unreq canBallMoveAddress
								.unreq canBallMove

								BL DrawTopAvatar
								BL DrawBottomAvatar

                                POP { r0, r1, r2, pc }

    .globl TopPlayerGetsTheBall
    TopPlayerGetsTheBall:   PUSH { r0, r1, r2, lr }

                            // Resetting ball position
                                ballPositionXAddress .req r0
                                LDR ballPositionXAddress, =BallPositionX

                                paddleWidth .req r1
                                LDR paddleWidth, =PaddleWidth
                                LDR paddleWidth, [paddleWidth]
                                LSR paddleWidth, #1

                                newBallPosition .req r2
                                LDR newBallPosition, =TopPaddleLocationX
                                LDR newBallPosition, [newBallPosition]
                                ADD newBallPosition, paddleWidth

                                STR newBallPosition, [ballPositionXAddress]

                                .unreq ballPositionXAddress
                                .unreq paddleWidth

                                ballPositionYAddress .req r0
                                LDR ballPositionYAddress, =BallPositionY

                                paddleHeight .req r1
                                LDR paddleHeight, =PaddleHeight
                                LDR paddleHeight, [paddleHeight]
                                LSL paddleHeight, #1
                                ADD paddleHeight, #2

                                MOV newBallPosition, paddleHeight
                                STR newBallPosition, [ballPositionYAddress]

                                .unreq ballPositionYAddress
                                .unreq newBallPosition
                            // <- Resetting ball position

                            // Resetting ball direction
                                ballDirectionXAddress .req r0
                                LDR ballDirectionXAddress, =BallDirectionX

                                newBallDirection, .req r1
                                MOV newBallDirection, #0

                                STR newBallDirection, [ballDirectionXAddress]

                                .unreq ballDirectionXAddress


                                ballDirectionYAddress .req r0
                                LDR ballDirectionYAddress, =BallDirectionY

                                MOV newBallDirection, #1
                                STR newBallDirection, [ballDirectionYAddress]

                                .unreq ballDirectionYAddress
                                .unreq newBallDirection
                            // <- Resetting ball direction

                            // Resetting frame time
                                currentFrameTime .req r0
                                LDR currentFrameTime, =FrameTime

                                fastFrameTime .req r1
                                LDR fastFrameTime, =FastFrameTime
                                LDR fastFrameTime, [fastFrameTime]

                                STR fastFrameTime, [currentFrameTime]
                            // <- Resetting frame time

                            .unreq currentFrameTime
                            .unreq fastFrameTime

                            // Setting ball posession
                                topPlayerPosessionAddress .req r0
                                LDR topPlayerPosessionAddress, =TopPlayerHasTheBall

                                topPlayerPosession .req r1
                                MOV topPlayerPosession, #1

                                STR topPlayerPosession, [topPlayerPosessionAddress]
                            // <- Setting ball posession

                            .unreq topPlayerPosessionAddress
                            .unreq topPlayerPosession

	                        canPaddlesMoveAddress .req r0
	                        LDR canPaddlesMoveAddress, =CanPaddlesMove

	                        canPaddlesMove .req r1
	                        MOV canPaddlesMove, #1

	                        STR canPaddlesMove, [canPaddlesMoveAddress]

	                        .unreq canPaddlesMoveAddress
							.unreq canPaddlesMove

	                        canBallMoveAddress .req r0
	                        LDR canBallMoveAddress, =CanBallMove

	                        canBallMove .req r1
	                        MOV canBallMove, #0

	                        STR canBallMove, [canBallMoveAddress]

	                        .unreq canBallMoveAddress
							.unreq canBallMove

							BL DrawTopAvatar
							BL DrawBottomAvatar

                            POP { r0, r1, r2, pc }

    .globl BottomPlayerStartsTheGame
    BottomPlayerStartsTheGame:	PUSH { r0, r1, r2, lr }

	                            // Resetting ball position
	                                ballPositionXAddress .req r0
	                                LDR ballPositionXAddress, =BallPositionX

	                                paddleWidth .req r1
	                                LDR paddleWidth, =PaddleWidth
	                                LDR paddleWidth, [paddleWidth]
	                                LSR paddleWidth, #1

	                                newBallPosition .req r2
	                                LDR newBallPosition, =BottomPaddleLocationX
	                                LDR newBallPosition, [newBallPosition]
	                                ADD newBallPosition, paddleWidth

	                                STR newBallPosition, [ballPositionXAddress]

	                                .unreq ballPositionXAddress
	                                .unreq paddleWidth

	                                ballPositionYAddress .req r0
	                                LDR ballPositionYAddress, =BallPositionY

	                                screenHeight .req r1
		                            LDR screenHeight, =FrameBufferInfo
		                            LDR screenHeight, [screenHeight, #4]

	                                MOV newBallPosition, screenHeight

	                                .unreq screenHeight
	                                ballHeight .req r1
	                                LDR  ballHeight, =BallHeight
	                                LDR ballHeight, [ballHeight]

	                                SUB newBallPosition, ballHeight

	                                .unreq ballHeight

	                                paddleHeight .req r1
	                                LDR paddleHeight, =PaddleHeight
	                                LDR paddleHeight, [paddleHeight]
	                                LSL paddleHeight, #1

	                                SUB newBallPosition, paddleHeight
	                                SUB newBallPosition, #1
	                                STR newBallPosition, [ballPositionYAddress]

	                                .unreq ballPositionYAddress
	                                .unreq newBallPosition
	                            // <- Resetting ball position

                                // Resetting ball direction
                                    ballDirectionXAddress .req r0
                                    LDR ballDirectionXAddress, =BallDirectionX

                                    newBallDirection, .req r1
                                    MOV newBallDirection, #0

                                    STR newBallDirection, [ballDirectionXAddress]

                                    .unreq ballDirectionXAddress


                                    ballDirectionYAddress .req r0
                                    LDR ballDirectionYAddress, =BallDirectionY

                                    Str newBallDirection, [ballDirectionYAddress]

                                    .unreq ballDirectionYAddress
                                    .unreq newBallDirection
                                // <- Resetting ball direction

                                // Resetting frame time
                                    currentFrameTime .req r0
                                    LDR currentFrameTime, =FrameTime

                                    fastFrameTime .req r1
                                    LDR fastFrameTime, =FastFrameTime
                                    LDR fastFrameTime, [fastFrameTime]

                                    STR fastFrameTime, [currentFrameTime]
                                // <- Resetting frame time

                                .unreq currentFrameTime
                                .unreq fastFrameTime

                                // Setting ball posession
                                    bottomPlayerPosessionAddress .req r0
                                    LDR bottomPlayerPosessionAddress, =BottomPlayerHasTheBall

                                    bottomPlayerPosession .req r1
                                    MOV bottomPlayerPosession, #1

                                    STR bottomPlayerPosession, [bottomPlayerPosessionAddress]
                                // <- Setting ball posession

                                .unreq bottomPlayerPosessionAddress
                                .unreq bottomPlayerPosession

		                        canPaddlesMoveAddress .req r0
		                        LDR canPaddlesMoveAddress, =CanPaddlesMove

		                        canPaddlesMove .req r1
		                        MOV canPaddlesMove, #1

		                        STR canPaddlesMove, [canPaddlesMoveAddress]

		                        .unreq canPaddlesMoveAddress
								.unreq canPaddlesMove

		                        canBallMoveAddress .req r0
		                        LDR canBallMoveAddress, =CanBallMove

		                        canBallMove .req r1
		                        MOV canBallMove, #0

		                        STR canBallMove, [canBallMoveAddress]

		                        .unreq canBallMoveAddress
								.unreq canBallMove

                                POP { r0, r1, r2, pc }

    .globl TopPlayerStartsTheGame
    TopPlayerStartsTheGame:   PUSH { r0, r1, r2, lr }

                            // Resetting ball position
                                ballPositionXAddress .req r0
                                LDR ballPositionXAddress, =BallPositionX

                                paddleWidth .req r1
                                LDR paddleWidth, =PaddleWidth
                                LDR paddleWidth, [paddleWidth]
                                LSR paddleWidth, #1

                                newBallPosition .req r2
                                LDR newBallPosition, =TopPaddleLocationX
                                LDR newBallPosition, [newBallPosition]
                                ADD newBallPosition, paddleWidth

                                STR newBallPosition, [ballPositionXAddress]

                                .unreq ballPositionXAddress
                                .unreq paddleWidth

                                ballPositionYAddress .req r0
                                LDR ballPositionYAddress, =BallPositionY

                                paddleHeight .req r1
                                LDR paddleHeight, =PaddleHeight
                                LDR paddleHeight, [paddleHeight]
                                LSL paddleHeight, #1
                                ADD paddleHeight, #2

                                MOV newBallPosition, paddleHeight
                                STR newBallPosition, [ballPositionYAddress]

                                .unreq ballPositionYAddress
                                .unreq newBallPosition
                            // <- Resetting ball position

                            // Resetting ball direction
                                ballDirectionXAddress .req r0
                                LDR ballDirectionXAddress, =BallDirectionX

                                newBallDirection, .req r1
                                MOV newBallDirection, #0

                                STR newBallDirection, [ballDirectionXAddress]

                                .unreq ballDirectionXAddress


                                ballDirectionYAddress .req r0
                                LDR ballDirectionYAddress, =BallDirectionY

                                MOV newBallDirection, #1
                                STR newBallDirection, [ballDirectionYAddress]

                                .unreq ballDirectionYAddress
                                .unreq newBallDirection
                            // <- Resetting ball direction

                            // Resetting frame time
                                currentFrameTime .req r0
                                LDR currentFrameTime, =FrameTime

                                fastFrameTime .req r1
                                LDR fastFrameTime, =FastFrameTime
                                LDR fastFrameTime, [fastFrameTime]

                                STR fastFrameTime, [currentFrameTime]
                            // <- Resetting frame time

                            .unreq currentFrameTime
                            .unreq fastFrameTime

                            // Setting ball posession
                                topPlayerPosessionAddress .req r0
                                LDR topPlayerPosessionAddress, =TopPlayerHasTheBall

                                topPlayerPosession .req r1
                                MOV topPlayerPosession, #1

                                STR topPlayerPosession, [topPlayerPosessionAddress]
                            // <- Setting ball posession

                            .unreq topPlayerPosessionAddress
                            .unreq topPlayerPosession

	                        canPaddlesMoveAddress .req r0
	                        LDR canPaddlesMoveAddress, =CanPaddlesMove

	                        canPaddlesMove .req r1
	                        MOV canPaddlesMove, #1

	                        STR canPaddlesMove, [canPaddlesMoveAddress]

	                        .unreq canPaddlesMoveAddress
							.unreq canPaddlesMove

	                        canBallMoveAddress .req r0
	                        LDR canBallMoveAddress, =CanBallMove

	                        canBallMove .req r1
	                        MOV canBallMove, #0

	                        STR canBallMove, [canBallMoveAddress]

	                        .unreq canBallMoveAddress
							.unreq canBallMove

                            POP { r0, r1, r2, pc }
