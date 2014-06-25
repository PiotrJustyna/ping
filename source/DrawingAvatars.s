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
                    LDR topAvatarAddress, =TopAvatar
                    SUB topAvatarAddress, #2

                    numberOfRows .req r5
                    MOV numberOfRows, #43

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
                        SUB avatarOriginY, screenHeight, #215

                        .unreq screenHeight

                        topAvatarAddress .req r4
                        LDR topAvatarAddress, =TopAvatar
                        SUB topAvatarAddress, #2

                        numberOfRows .req r7
                        MOV numberOfRows, #43

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

                                LDR colour, [topAvatarAddress, #2]!
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
                        .unreq topAvatarAddress
                        .unreq numberOfRows
                        .unreq numberOfColumns
                        .unreq columnCounter
                        .unreq rowCounter

                        POP { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, pc }
