/*******************************************************/
/* This file contains subroutines for drawing numbers. */
/*                                                     */
/* Author: Piotr Justyna                               */
/*******************************************************/

.section .text

    .globl DrawOne
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

    .globl DrawZero
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

    .globl WipeBigNumber
    WipeBigNumber:  PUSH { r2, r3, r4, r5, r6, lr }

                    x .req r0
                    y .req r1

                    foregroundColour .req r2
                    LDR foregroundColour, =ForegoundColour

                    backgroundColour .req r3
                    LDR backgroundColour, =BackgroundColour
                    LDR backgroundColour, [backgroundColour]

                    previousForegroundColour .req r4
                    LDR previousForegroundColour, [foregroundColour]
                    STR backgroundColour, [foregroundColour]

                    xLimit .req r5
                    ADD xLimit, x, #50

                    yLimit .req r6
                    SUB yLimit, y, #101

                    wipeBigNumberRowCounter:

                        wipeBigNumberColumnCounter:

                            BL DrawPixel
                            ADD x, #1
                            CMP x, xLimit

                        BNE wipeBigNumberColumnCounter

                        BL DrawPixel
                        SUB x, #50
                        SUB y, #1
                        CMP y, yLimit

                    BNE wipeBigNumberRowCounter

                    ADD y, #101

                    STR previousForegroundColour, [foregroundColour]

                    .unreq x
                    .unreq y
                    .unreq foregroundColour
                    .unreq backgroundColour
                    .unreq previousForegroundColour
                    .unreq xLimit
                    .unreq yLimit

                    POP { r2, r3, r4, r5, r6, pc }

    .globl DrawBigZero
    DrawBigZero:    PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1

                    xLimit .req r2
                    ADD xLimit, x, #50

                    yLimit .req r3
                    SUB yLimit, y, #100

                    bigZeroBottomPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, xLimit

                    BNE bigZeroBottomPart

                    bigZeroRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, yLimit

                    BNE bigZeroRightPart

                    SUB xLimit, #50

                    bigZeroTopPart:

                        BL DrawPixel
                        SUB x, #1
                        CMP x, xLimit

                    BNE bigZeroTopPart

                    ADD yLimit, #100

                    bigZeroLeftPart:

                        BL DrawPixel
                        ADD y, #1
                        CMP y, yLimit

                    BNE bigZeroLeftPart

                    .unreq x
                    .unreq y
                    .unreq xLimit
                    .unreq yLimit

                    POP { r2, r3, pc }

    .globl DrawBigOne
    DrawBigOne:     PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    width .req r2
                    MOV width, #50

                    heightLimit .req r3
                    SUB heightLimit, y, #100

                    ADD x, width

                    bigOneRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigOneRightPart

                    ADD heightLimit, y, #50

                    bigOneTopPart:

                        BL DrawPixel
                        ADD y, #1
                        SUB x, #1
                        CMP y, heightLimit

                    BNE bigOneTopPart

                    ADD y, #50

                    POP { r2, r3, pc }

    .globl DrawBigTwo
    DrawBigTwo:     PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    ADD widthLimit, x, #50

                    heightLimit .req r3
                    SUB heightLimit, y, #50

                    bigTwoBottomPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigTwoBottomPart

                    SUB x, #50

                    bigTwoBottomLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigTwoBottomLeftPart

                    bigTwoMiddlePart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigTwoMiddlePart

                    SUB heightLimit, y, #50

                    bigTwoTopRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigTwoTopRightPart

                    SUB widthLimit, x, #50

                    bigTwoTopPart:

                        Bl DrawPixel
                        SUB x, #1
                        CMP x, widthLimit

                    BNE bigTwoTopPart

                    ADD y, #100

                    POP { r2, r3, pc }

    .globl DrawBigFive
    DrawBigFive:     PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    ADD widthLimit, x, #50

                    heightLimit .req r3
                    SUB heightLimit, y, #50

                    bigFiveBottomPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigFiveBottomPart

                    bigFiveBottomRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigFiveBottomRightPart

                    SUB widthLimit, x, #50

                    bigFiveMiddlePart:

                        BL DrawPixel
                        SUB x, #1
                        CMP x, widthLimit

                    BNE bigFiveMiddlePart

                    SUB heightLimit, y, #50

                    bigFiveTopLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigFiveTopLeftPart

                    ADD widthLimit, x, #50

                    bigFiveTopPart:

                        Bl DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigFiveTopPart

                    SUB x, #50
                    ADD y, #100

                    POP { r2, r3, pc }
