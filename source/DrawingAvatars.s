/***************************************************/
/* This file contains avatars drawing subroutines. */
/*                                                 */
/* Author: Piotr Justyna                           */
/***************************************************/

.section .text

    .globl DrawTopAvatar
    DrawTopAvatar:  PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                    x .req r0

                    y .req r1
                    MOV y, #1

                    colour .req r2

                    sizeInPixels .req r3
                    MOV sizeInPixels, #5

                    screenWidth .req r4
                    LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                    LDR screenWidth, [screenWidth]              // ... framebuffer info...
                    LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                    scoreMargin .req r5
                    LDR scoreMargin, =ScoreMargin
                    LDR scoreMargin, [scoreMargin]

                    avatarOriginX .req r6
                    SUB avatarOriginX, screenWidth, scoreMargin
                    ADD avatarOriginX, #20

                    .unreq screenWidth
                    .unreq scoreMargin

                    topAvatarAddress .req r4
                    LDR topAvatarAddress, =TopAvatarNeutral
                    SUB topAvatarAddress, #2

                    numberOfRows .req r5
                    MOV numberOfRows, #44

                    numberOfColumns .req r7
                    MOV numberOfColumns, #36

                    columnCounter .req r8
                    MOV columnCounter, #0

                    rowCounter .req r9
                    MOV rowCounter, #0

                    MOV x, avatarOriginX

                    drawTopAvatarsRows:

                        drawTopAvatarsColumns:

                            LDR colour, [topAvatarAddress, #2]!
                            BL DrawPoint
                            ADD x, sizeInPixels
                            ADD columnCounter, #1
                            CMP columnCounter, numberOfColumns

                        BNE drawTopAvatarsColumns

                        MOV x, avatarOriginX
                        MOV columnCounter, #0
                        ADD y, sizeInPixels
                        ADD rowCounter, #1
                        CMP rowCounter, numberOfRows

                    BNE drawTopAvatarsRows

                    .unreq x
                    .unreq y
                    .unreq colour
                    .unreq sizeInPixels
                    .unreq topAvatarAddress
                    .unreq numberOfRows
                    .unreq numberOfColumns
                    .unreq columnCounter
                    .unreq rowCounter

                    POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }

    .globl DrawTopAvatarLosing
    DrawTopAvatarLosing:    PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, lr }

                            x .req r0

                            y .req r1
                            MOV y, #1

                            colour .req r2

                            sizeInPixels .req r3
                            MOV sizeInPixels, #5

                            screenWidth .req r4
                            LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                            LDR screenWidth, [screenWidth]              // ... framebuffer info...
                            LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                            scoreMargin .req r5
                            LDR scoreMargin, =ScoreMargin
                            LDR scoreMargin, [scoreMargin]

                            avatarOriginX .req r6
                            SUB avatarOriginX, screenWidth, scoreMargin
                            ADD avatarOriginX, #20

                            .unreq screenWidth
                            .unreq scoreMargin

                            avatarAddress .req r4
                            LDR avatarAddress, =TopAvatarLosing
                            SUB avatarAddress, #2

                            numberOfRows .req r5
                            MOV numberOfRows, #44

                            numberOfColumns .req r7
                            MOV numberOfColumns, #36

                            columnCounter .req r8
                            MOV columnCounter, #0

                            rowCounter .req r9
                            MOV rowCounter, #0

                            MOV x, avatarOriginX

                            drawTopAvatarsLosingRows:

                                drawTopAvatarsLosingColumns:

                                    LDR colour, [avatarAddress, #2]!
                                    BL DrawPoint
                                    ADD x, sizeInPixels
                                    ADD columnCounter, #1
                                    CMP columnCounter, numberOfColumns

                                BNE drawTopAvatarsLosingColumns

                                MOV x, avatarOriginX
                                MOV columnCounter, #0
                                ADD y, sizeInPixels
                                ADD rowCounter, #1
                                CMP rowCounter, numberOfRows

                            BNE drawTopAvatarsLosingRows

                            .unreq x
                            .unreq y
                            .unreq colour
                            .unreq sizeInPixels
                            .unreq avatarAddress
                            .unreq numberOfRows
                            .unreq numberOfColumns
                            .unreq columnCounter
                            .unreq rowCounter

                            POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, pc }

    .globl DrawTopAvatarWinning
    DrawTopAvatarWinning:   PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, lr }

                            x .req r0

                            y .req r1
                            MOV y, #1

                            colour .req r2

                            sizeInPixels .req r3
                            MOV sizeInPixels, #5

                            screenWidth .req r4
                            LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                            LDR screenWidth, [screenWidth]              // ... framebuffer info...
                            LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                            scoreMargin .req r5
                            LDR scoreMargin, =ScoreMargin
                            LDR scoreMargin, [scoreMargin]

                            avatarOriginX .req r6
                            SUB avatarOriginX, screenWidth, scoreMargin
                            ADD avatarOriginX, #20

                            .unreq screenWidth
                            .unreq scoreMargin

                            avatarAddress .req r4
                            LDR avatarAddress, =TopAvatarWinning
                            SUB avatarAddress, #2

                            numberOfRows .req r5
                            MOV numberOfRows, #44

                            numberOfColumns .req r7
                            MOV numberOfColumns, #36

                            columnCounter .req r8
                            MOV columnCounter, #0

                            rowCounter .req r9
                            MOV rowCounter, #0

                            MOV x, avatarOriginX

                            drawTopAvatarsWinningRows:

                                drawTopAvatarsWinningColumns:

                                    LDR colour, [avatarAddress, #2]!
                                    BL DrawPoint
                                    ADD x, sizeInPixels
                                    ADD columnCounter, #1
                                    CMP columnCounter, numberOfColumns

                                BNE drawTopAvatarsWinningColumns

                                MOV x, avatarOriginX
                                MOV columnCounter, #0
                                ADD y, sizeInPixels
                                ADD rowCounter, #1
                                CMP rowCounter, numberOfRows

                            BNE drawTopAvatarsWinningRows

                            .unreq x
                            .unreq y
                            .unreq colour
                            .unreq sizeInPixels
                            .unreq avatarAddress
                            .unreq numberOfRows
                            .unreq numberOfColumns
                            .unreq columnCounter
                            .unreq rowCounter

                            POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, pc }

    .globl DrawGameWinningBadgeForTheTopAvatar
    DrawGameWinningBadgeForTheTopAvatar:   PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                                            x .req r0

                                            y .req r1
                                            MOV y, #221

                                            colour .req r2

                                            sizeInPixels .req r3
                                            MOV sizeInPixels, #1

                                            screenWidth .req r4
                                            LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                                            LDR screenWidth, [screenWidth]              // ... framebuffer info...
                                            LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                                            scoreMargin .req r5
                                            LDR scoreMargin, =ScoreMargin
                                            LDR scoreMargin, [scoreMargin]

                                            avatarOriginX .req r6
                                            SUB avatarOriginX, screenWidth, scoreMargin
                                            ADD avatarOriginX, #20

                                            .unreq screenWidth
                                            .unreq scoreMargin

                                            winningBadgeAddress .req r4
                                            LDR winningBadgeAddress, =Winner
                                            SUB winningBadgeAddress, #2

                                            numberOfRows .req r5
                                            MOV numberOfRows, #50

                                            numberOfColumns .req r7
                                            MOV numberOfColumns, #180

                                            columnCounter .req r8
                                            MOV columnCounter, #0

                                            rowCounter .req r9
                                            MOV rowCounter, #0

                                            MOV x, avatarOriginX

                                            topAvatarsWinningBadgeRows:

                                                topAvatarsWinningBadgeColumns:

                                                    LDR colour, [winningBadgeAddress, #2]!
                                                    BL DrawPoint
                                                    ADD x, sizeInPixels
                                                    ADD columnCounter, #1
                                                    CMP columnCounter, numberOfColumns

                                                BNE topAvatarsWinningBadgeColumns

                                                MOV x, avatarOriginX
                                                MOV columnCounter, #0
                                                ADD y, sizeInPixels
                                                ADD rowCounter, #1
                                                CMP rowCounter, numberOfRows

                                            BNE topAvatarsWinningBadgeRows

                                            .unreq x
                                            .unreq y
                                            .unreq colour
                                            .unreq sizeInPixels
                                            .unreq winningBadgeAddress
                                            .unreq numberOfRows
                                            .unreq numberOfColumns
                                            .unreq columnCounter
                                            .unreq rowCounter

                                            POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }

    .globl DrawBottomAvatar
    DrawBottomAvatar:   PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, lr }

                        x .req r0
                        y .req r1
                        colour .req r2

                        sizeInPixels .req r3
                        MOV sizeInPixels, #5

                        screenWidth .req r4
                        LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                        LDR screenWidth, [screenWidth]              // ... framebuffer info...
                        LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                        scoreMargin .req r5
                        LDR scoreMargin, =ScoreMargin
                        LDR scoreMargin, [scoreMargin]

                        avatarOriginX .req r6
                        SUB avatarOriginX, screenWidth, scoreMargin
                        ADD avatarOriginX, #20

                        .unreq screenWidth
                        .unreq scoreMargin

                        screenHeight .req r4
                        LDR screenHeight, =FramebufferInfoAddress
                        LDR screenHeight, [screenHeight]
                        LDR screenHeight, [screenHeight, #4]

                        avatarOriginY .req r5
                        SUB avatarOriginY, screenHeight, #220

                        .unreq screenHeight

                        avatarAddress .req r4
                        LDR avatarAddress, =BottomAvatarNeutral
                        SUB avatarAddress, #2

                        numberOfRows .req r7
                        MOV numberOfRows, #44

                        numberOfColumns .req r8
                        MOV numberOfColumns, #36

                        columnCounter .req r9
                        MOV columnCounter, #0

                        rowCounter .req r10
                        MOV rowCounter, #0

                        MOV x, avatarOriginX
                        MOV y, avatarOriginY

                        drawBottomAvatarsRows:

                            drawBottomAvatarsColumns:

                                LDR colour, [avatarAddress, #2]!
                                BL DrawPoint
                                ADD x, sizeInPixels
                                ADD columnCounter, #1
                                CMP columnCounter, numberOfColumns

                            BNE drawBottomAvatarsColumns

                            MOV x, avatarOriginX
                            MOV columnCounter, #0
                            ADD y, sizeInPixels
                            ADD rowCounter, #1
                            CMP rowCounter, numberOfRows

                        BNE drawBottomAvatarsRows

                        .unreq x
                        .unreq y
                        .unreq colour
                        .unreq sizeInPixels
                        .unreq avatarAddress
                        .unreq numberOfRows
                        .unreq numberOfColumns
                        .unreq columnCounter
                        .unreq rowCounter

                        POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, pc }

    .globl DrawBottomAvatarLosing
    DrawBottomAvatarLosing: PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, lr }

                            x .req r0
                            y .req r1
                            colour .req r2

                            sizeInPixels .req r3
                            MOV sizeInPixels, #5

                            screenWidth .req r4
                            LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                            LDR screenWidth, [screenWidth]              // ... framebuffer info...
                            LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                            scoreMargin .req r5
                            LDR scoreMargin, =ScoreMargin
                            LDR scoreMargin, [scoreMargin]

                            avatarOriginX .req r6
                            SUB avatarOriginX, screenWidth, scoreMargin
                            ADD avatarOriginX, #20

                            .unreq screenWidth
                            .unreq scoreMargin

                            screenHeight .req r4
                            LDR screenHeight, =FramebufferInfoAddress
                            LDR screenHeight, [screenHeight]
                            LDR screenHeight, [screenHeight, #4]

                            avatarOriginY .req r5
                            SUB avatarOriginY, screenHeight, #220

                            .unreq screenHeight

                            avatarAddress .req r4
                            LDR avatarAddress, =BottomAvatarLosing
                            SUB avatarAddress, #2

                            numberOfRows .req r7
                            MOV numberOfRows, #44

                            numberOfColumns .req r8
                            MOV numberOfColumns, #36

                            columnCounter .req r9
                            MOV columnCounter, #0

                            rowCounter .req r10
                            MOV rowCounter, #0

                            MOV x, avatarOriginX
                            MOV y, avatarOriginY

                            drawBottomAvatarsLosingRows:

                                drawBottomAvatarsLosingColumns:

                                    LDR colour, [avatarAddress, #2]!
                                    BL DrawPoint
                                    ADD x, sizeInPixels
                                    ADD columnCounter, #1
                                    CMP columnCounter, numberOfColumns

                                BNE drawBottomAvatarsLosingColumns

                                MOV x, avatarOriginX
                                MOV columnCounter, #0
                                ADD y, sizeInPixels
                                ADD rowCounter, #1
                                CMP rowCounter, numberOfRows

                            BNE drawBottomAvatarsLosingRows

                            .unreq x
                            .unreq y
                            .unreq colour
                            .unreq sizeInPixels
                            .unreq avatarAddress
                            .unreq numberOfRows
                            .unreq numberOfColumns
                            .unreq columnCounter
                            .unreq rowCounter

                            POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, pc }

    .globl DrawBottomAvatarWinning
    DrawBottomAvatarWinning:    PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, lr }

                                x .req r0
                                y .req r1
                                colour .req r2

                                sizeInPixels .req r3
                                MOV sizeInPixels, #5

                                screenWidth .req r4
                                LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                                LDR screenWidth, [screenWidth]              // ... framebuffer info...
                                LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                                scoreMargin .req r5
                                LDR scoreMargin, =ScoreMargin
                                LDR scoreMargin, [scoreMargin]

                                avatarOriginX .req r6
                                SUB avatarOriginX, screenWidth, scoreMargin
                                ADD avatarOriginX, #20

                                .unreq screenWidth
                                .unreq scoreMargin

                                screenHeight .req r4
                                LDR screenHeight, =FramebufferInfoAddress
                                LDR screenHeight, [screenHeight]
                                LDR screenHeight, [screenHeight, #4]

                                avatarOriginY .req r5
                                SUB avatarOriginY, screenHeight, #220

                                .unreq screenHeight

                                avatarAddress .req r4
                                LDR avatarAddress, =BottomAvatarWinning
                                SUB avatarAddress, #2

                                numberOfRows .req r7
                                MOV numberOfRows, #44

                                numberOfColumns .req r8
                                MOV numberOfColumns, #36

                                columnCounter .req r9
                                MOV columnCounter, #0

                                rowCounter .req r10
                                MOV rowCounter, #0

                                MOV x, avatarOriginX
                                MOV y, avatarOriginY

                                drawBottomAvatarsWinningRows:

                                    drawBottomAvatarsWinningColumns:

                                        LDR colour, [avatarAddress, #2]!
                                        BL DrawPoint
                                        ADD x, sizeInPixels
                                        ADD columnCounter, #1
                                        CMP columnCounter, numberOfColumns

                                    BNE drawBottomAvatarsWinningColumns

                                    MOV x, avatarOriginX
                                    MOV columnCounter, #0
                                    ADD y, sizeInPixels
                                    ADD rowCounter, #1
                                    CMP rowCounter, numberOfRows

                                BNE drawBottomAvatarsWinningRows

                                .unreq x
                                .unreq y
                                .unreq colour
                                .unreq sizeInPixels
                                .unreq avatarAddress
                                .unreq numberOfRows
                                .unreq numberOfColumns
                                .unreq columnCounter
                                .unreq rowCounter

                                POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, pc }

    .globl DrawGameWinningBadgeForTheBottomAvatar
    DrawGameWinningBadgeForTheBottomAvatar: PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                                            x .req r0

                                            y .req r1
                                            LDR y, =809

                                            colour .req r2

                                            sizeInPixels .req r3
                                            MOV sizeInPixels, #1

                                            screenWidth .req r4
                                            LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                                            LDR screenWidth, [screenWidth]              // ... framebuffer info...
                                            LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                                            scoreMargin .req r5
                                            LDR scoreMargin, =ScoreMargin
                                            LDR scoreMargin, [scoreMargin]

                                            avatarOriginX .req r6
                                            SUB avatarOriginX, screenWidth, scoreMargin
                                            ADD avatarOriginX, #20

                                            .unreq screenWidth
                                            .unreq scoreMargin

                                            winningBadgeAddress .req r4
                                            LDR winningBadgeAddress, =Winner
                                            SUB winningBadgeAddress, #2

                                            numberOfRows .req r5
                                            MOV numberOfRows, #50

                                            numberOfColumns .req r7
                                            MOV numberOfColumns, #180

                                            columnCounter .req r8
                                            MOV columnCounter, #0

                                            rowCounter .req r9
                                            MOV rowCounter, #0

                                            MOV x, avatarOriginX

                                            bottomAvatarsWinningBadgeRows:

                                                bottomAvatarsWinningBadgeColumns:

                                                    LDR colour, [winningBadgeAddress, #2]!
                                                    BL DrawPoint
                                                    ADD x, sizeInPixels
                                                    ADD columnCounter, #1
                                                    CMP columnCounter, numberOfColumns

                                                BNE bottomAvatarsWinningBadgeColumns

                                                MOV x, avatarOriginX
                                                MOV columnCounter, #0
                                                ADD y, sizeInPixels
                                                ADD rowCounter, #1
                                                CMP rowCounter, numberOfRows

                                            BNE bottomAvatarsWinningBadgeRows

                                            .unreq x
                                            .unreq y
                                            .unreq colour
                                            .unreq sizeInPixels
                                            .unreq winningBadgeAddress
                                            .unreq numberOfRows
                                            .unreq numberOfColumns
                                            .unreq columnCounter
                                            .unreq rowCounter

                                            POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }

    .globl WipeBottomGameWinningBadge
    WipeBottomGameWinningBadge: PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                                x .req r0

                                y .req r1
                                LDR y, =809

                                colour .req r2

                                sizeInPixels .req r3
                                MOV sizeInPixels, #1

                                screenWidth .req r4
                                LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                                LDR screenWidth, [screenWidth]              // ... framebuffer info...
                                LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                                scoreMargin .req r5
                                LDR scoreMargin, =ScoreMargin
                                LDR scoreMargin, [scoreMargin]

                                avatarOriginX .req r6
                                SUB avatarOriginX, screenWidth, scoreMargin
                                ADD avatarOriginX, #20

                                .unreq screenWidth
                                .unreq scoreMargin

                                backgroundColour .req r4
                                LDR backgroundColour, =BackgroundColour
                                LDR colour, [backgroundColour]

                                numberOfRows .req r5
                                MOV numberOfRows, #50

                                numberOfColumns .req r7
                                MOV numberOfColumns, #180

                                columnCounter .req r8
                                MOV columnCounter, #0

                                rowCounter .req r9
                                MOV rowCounter, #0

                                MOV x, avatarOriginX

                                bottomAvatarsBlankWinningBadgeRows:

                                    bottomAvatarsBlankWinningBadgeColumns:

                                        BL DrawPoint
                                        ADD x, sizeInPixels
                                        ADD columnCounter, #1
                                        CMP columnCounter, numberOfColumns

                                    BNE bottomAvatarsBlankWinningBadgeColumns

                                    MOV x, avatarOriginX
                                    MOV columnCounter, #0
                                    ADD y, sizeInPixels
                                    ADD rowCounter, #1
                                    CMP rowCounter, numberOfRows

                                BNE bottomAvatarsBlankWinningBadgeRows

                                .unreq x
                                .unreq y
                                .unreq colour
                                .unreq sizeInPixels
                                .unreq backgroundColour
                                .unreq numberOfRows
                                .unreq numberOfColumns
                                .unreq columnCounter
                                .unreq rowCounter                                

                                POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }

    .globl WipeTopGameWinningBadge
    WipeTopGameWinningBadge:    PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                                x .req r0

                                y .req r1
                                LDR y, =221

                                colour .req r2

                                sizeInPixels .req r3
                                MOV sizeInPixels, #1

                                screenWidth .req r4
                                LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                                LDR screenWidth, [screenWidth]              // ... framebuffer info...
                                LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                                scoreMargin .req r5
                                LDR scoreMargin, =ScoreMargin
                                LDR scoreMargin, [scoreMargin]

                                avatarOriginX .req r6
                                SUB avatarOriginX, screenWidth, scoreMargin
                                ADD avatarOriginX, #20

                                .unreq screenWidth
                                .unreq scoreMargin

                                backgroundColour .req r4
                                LDR backgroundColour, =BackgroundColour
                                LDR colour, [backgroundColour]

                                numberOfRows .req r5
                                MOV numberOfRows, #50

                                numberOfColumns .req r7
                                MOV numberOfColumns, #180

                                columnCounter .req r8
                                MOV columnCounter, #0

                                rowCounter .req r9
                                MOV rowCounter, #0

                                MOV x, avatarOriginX

                                topAvatarsBlankWinningBadgeRows:

                                    topAvatarsBlankWinningBadgeColumns:

                                        BL DrawPoint
                                        ADD x, sizeInPixels
                                        ADD columnCounter, #1
                                        CMP columnCounter, numberOfColumns

                                    BNE topAvatarsBlankWinningBadgeColumns

                                    MOV x, avatarOriginX
                                    MOV columnCounter, #0
                                    ADD y, sizeInPixels
                                    ADD rowCounter, #1
                                    CMP rowCounter, numberOfRows

                                BNE topAvatarsBlankWinningBadgeRows

                                .unreq x
                                .unreq y
                                .unreq colour
                                .unreq sizeInPixels
                                .unreq backgroundColour
                                .unreq numberOfRows
                                .unreq numberOfColumns
                                .unreq columnCounter
                                .unreq rowCounter                                

                                POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }

    .globl DrawLandingScreen
    DrawLandingScreen:  PUSH { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, lr }

                        x .req r0
                        MOV x, #0

                        y .req r1
                        MOV y, #0

                        colour .req r2

                        sizeInPixels .req r3
                        MOV sizeInPixels, #10

                        screenWidth .req r4
                        LDR screenWidth, =FramebufferInfoAddress    // This looks crazy, but it goes like this: framebufferr info address...
                        LDR screenWidth, [screenWidth]              // ... framebuffer info...
                        LDR screenWidth, [screenWidth, #0]          // ... frambuffer info's first word, which is the screenWidth.

                        landingScreenAddress .req r5
                        LDR landingScreenAddress, =LandingScreen
                        SUB landingScreenAddress, #2

                        numberOfRows .req r6
                        MOV numberOfRows, #144

                        numberOfColumns .req r7
                        MOV numberOfColumns, #192

                        columnCounter .req r8
                        MOV columnCounter, #0

                        rowCounter .req r9
                        MOV rowCounter, #0

                        drawLandingScreenRows:

                            drawLandingScreenColumns:

                                LDR colour, [landingScreenAddress, #2]!
                                BL DrawPoint
                                ADD x, sizeInPixels
                                ADD columnCounter, #1
                                CMP columnCounter, numberOfColumns

                            BNE drawLandingScreenColumns

                            MOV x, #0
                            MOV columnCounter, #0
                            ADD y, sizeInPixels
                            ADD rowCounter, #1
                            CMP rowCounter, numberOfRows

                        BNE drawLandingScreenRows

                        .unreq x
                        .unreq y
                        .unreq colour
                        .unreq sizeInPixels
                        .unreq screenWidth
                        .unreq landingScreenAddress
                        .unreq numberOfRows
                        .unreq numberOfColumns
                        .unreq columnCounter
                        .unreq rowCounter

                        POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, pc }
