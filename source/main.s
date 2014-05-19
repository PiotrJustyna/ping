.section .init

    .globl _start
    _start: MOV sp, #0x8000
            B Main

.section .text

    Main:   BL InitialiseFrameBuffer
            frameBufferInfo .req r0
            TEQ frameBufferInfo, #0                             // If the framebuffer info address is 0 (TEQ not to affect V and C flags), there's an error.
            BEQ errorLoop
            framebufferInfoAddress .req r1
            LDR framebufferInfoAddress, =FramebufferInfoAddress
            STR frameBufferInfo, [framebufferInfoAddress]       // Preserve the framebuffer info address so it doesn't have to be stored in registers.
            .unreq frameBufferInfo
            .unreq framebufferInfoAddress

            // Setting foreground colour
                foregroundColourValue .req r0
                LDR foregroundColourValue, =GrayColour
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
                MOV x, #5

                y .req r1
                MOV y, #11

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

                BL DrawFrame
                BL DrawTopPaddle
                BL DrawBottomPaddle

                whileTrue:

                    BL CaptureStartTimestamp

                    BL DrawNet
                    // BL DrawTopPaddle
                    // BL DrawBottomPaddle
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

    DrawBottomPaddle:  PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                    paddleWidth .req r2
                    LDR paddleWidth, =PaddleWidth
                    LDR paddleWidth, [paddleWidth]

                    paddleHeight .req r3
                    LDR paddleHeight, =PaddleHeight
                    LDR paddleHeight, [paddleHeight]

                    remainingPaddleWidth .req r4
                    MOV remainingPaddleWidth, paddleWidth

                    remainingPaddleHeight .req r5
                    MOV remainingPaddleHeight, paddleHeight

                    screenWidth .req r6
                    LDR screenWidth, =FrameBufferInfo
                    LDR screenWidth, [screenWidth, #0]

                    screenHeight .req r7
                    LDR screenHeight, =FrameBufferInfo
                    LDR screenHeight, [screenHeight, #4]

                    scoreMargin .req r8
                    LDR scoreMargin, =ScoreMargin
                    LDR scoreMargin, [scoreMargin]

                    bottomPaddleLocationX .req r9
                    LDR bottomPaddleLocationX, =BottomPaddleLocationX

                    x .req r0
                    SUB x, screenWidth, scoreMargin
                    SUB x, paddleWidth
                    LSR x, #1                                   // x = (screenWidth - scoreMargin - paddleWidth) / 2

                    STR x, [bottomPaddleLocationX]

                    y .req r1
                    SUB y, screenHeight, paddleHeight, LSL #1   // y = screenHeight - (paddleHeight * 2)

                    topPaddleRowLoop:

                        topPaddleColumnLoop:

                            BL DrawPixel
                            ADD x, #1
                            SUB remainingPaddleWidth, #1
                            CMP remainingPaddleWidth, #0

                        BNE topPaddleColumnLoop

                        MOV remainingPaddleWidth, paddleWidth
                        SUB x, remainingPaddleWidth
                        ADD y, #1
                        SUB remainingPaddleHeight, #1
                        CMP remainingPaddleHeight, #0

                    BNE topPaddleRowLoop

                    .unreq paddleWidth
                    .unreq paddleHeight
                    .unreq remainingPaddleWidth
                    .unreq remainingPaddleHeight
                    .unreq screenWidth
                    .unreq screenHeight
                    .unreq scoreMargin
                    .unreq bottomPaddleLocationX
                    .unreq x
                    .unreq y

                    POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }

    DrawTopPaddle:   PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                        paddleWidth .req r2
                        LDR paddleWidth, =PaddleWidth
                        LDR paddleWidth, [paddleWidth]

                        paddleHeight .req r3
                        LDR paddleHeight, =PaddleHeight
                        LDR paddleHeight, [paddleHeight]

                        remainingPaddleWidth .req r4
                        MOV remainingPaddleWidth, paddleWidth

                        remainingPaddleHeight .req r5
                        MOV remainingPaddleHeight, paddleHeight

                        screenWidth .req r6
                        LDR screenWidth, =FrameBufferInfo
                        LDR screenWidth, [screenWidth, #0]

                        screenHeight .req r7
                        LDR screenHeight, =FrameBufferInfo
                        LDR screenHeight, [screenHeight, #4]

                        scoreMargin .req r8
                        LDR scoreMargin, =ScoreMargin
                        LDR scoreMargin, [scoreMargin]

                        topPaddleLocationX .req r9
                        LDR topPaddleLocationX, =TopPaddleLocationX

                        x .req r0
                        SUB x, screenWidth, scoreMargin
                        SUB x, paddleWidth
                        LSR x, #1                       // x = (screenWidth - scoreMargin - paddleWidth) / 2

                        STR x, [topPaddleLocationX]

                        y .req r1
                        MOV y, paddleHeight, LSL #1     // y = paddleHeight * 2

                        bottomPaddleRowLoop:

                            bottomPaddleColumnLoop:

                                BL DrawPixel
                                ADD x, #1
                                SUB remainingPaddleWidth, #1
                                CMP remainingPaddleWidth, #0

                            BNE bottomPaddleColumnLoop

                            MOV remainingPaddleWidth, paddleWidth
                            SUB x, remainingPaddleWidth
                            SUB y, #1
                            SUB remainingPaddleHeight, #1
                            CMP remainingPaddleHeight, #0

                        BNE bottomPaddleRowLoop

                        .unreq paddleWidth
                        .unreq paddleHeight
                        .unreq remainingPaddleWidth
                        .unreq remainingPaddleHeight
                        .unreq screenWidth
                        .unreq screenHeight
                        .unreq scoreMargin
                        .unreq topPaddleLocationX
                        .unreq x
                        .unreq y

                        POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }

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

                LDR foregroundColourValue, =GrayColour
                LDR foregroundColourValue, [foregroundColourValue]
                STR foregroundColourValue, [foregroundColourAddress]

                POP { r0, r1, r2, r3, r4, r5, pc }

    DrawBall:   PUSH { r0, r1, r2, r3, r4, r5, lr }

                BL WipeBall

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

                // Capturing ball width before its register gets reused
                /*
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
                */
                // <- Capturing ball width before its register gets reused

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
