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

                    .unreq x
                    .unreq y
                    .unreq width
                    .unreq heightLimit

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

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

                    POP { r2, r3, pc }

    .globl DrawBigThree
    DrawBigThree:   PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    ADD widthLimit, x, #50

                    heightLimit .req r3
                    SUB heightLimit, y, #50

                    bigThreeBottomPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigThreeBottomPart

                    bigThreeBottomRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigThreeBottomRightPart

                    SUB widthLimit, x, #50

                    bigThreeMiddlePart:

                        BL DrawPixel
                        SUB x, #1
                        CMP x, widthLimit

                    BNE bigThreeMiddlePart

                    ADD x, #50
                    SUB heightLimit, #50

                    bigThreeTopRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigThreeTopRightPart

                    SUB widthLimit, x, #50

                    bigThreeTopPart:

                        BL DrawPixel
                        SUB x, #1
                        CMP x, widthLimit

                    BNE bigThreeTopPart

                    ADD y, #100

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

                    POP { r2, r3, pc }

    .globl DrawBigFour
    DrawBigFour:   PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    MOV widthLimit, x

                    heightLimit .req r3
                    SUB heightLimit, y, #50

                    ADD x, #50

                    bigFourBottomRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigFourBottomRightPart

                    bigFourMiddlePart:

                        BL DrawPixel
                        SUB x, #1
                        CMP x, widthLimit

                    BNE bigFourMiddlePart

                    SUB heightLimit, #50

                    bigFourTopLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigFourTopLeftPart

                    ADD x, #50
                    ADD y, #50

                    bigFourTopRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigFourTopRightPart

                    SUB x, #50
                    ADD y, #100

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

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

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

                    POP { r2, r3, pc }

    .globl DrawBigSix
    DrawBigSix:     PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    ADD widthLimit, x, #50

                    heightLimit .req r3
                    SUB heightLimit, y, #50

                    bigSixBottomPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigSixBottomPart

                    bigSixBottomRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigSixBottomRightPart

                    SUB x, #50
                    ADD y, #50

                    bigSixBottomLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigSixBottomLeftPart

                    bigSixMiddlePart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigSixMiddlePart

                    SUB x, #50
                    SUB heightLimit, y, #50

                    bigSixTopLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigSixTopLeftPart

                    bigSixTopPart:

                        Bl DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigSixTopPart

                    SUB x, #50
                    ADD y, #100

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

                    POP { r2, r3, pc }

    .globl DrawBigSeven
    DrawBigSeven:   PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    MOV widthLimit, x

                    heightLimit .req r3
                    SUB heightLimit, y, #100

                    ADD x, #50

                    bigSevenBottomRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigSevenBottomRightPart

                    bigSevenTopPart:

                        BL DrawPixel
                        SUB x, #1
                        CMP x, widthLimit

                    BNE bigSevenTopPart

                    ADD y, #100

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

                    POP { r2, r3, pc }

    .globl DrawBigEight
    DrawBigEight:   PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    ADD widthLimit, x, #50

                    heightLimit .req r3
                    SUB heightLimit, y, #50

                    bigEightBottomPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigEightBottomPart

                    bigEightBottomRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigEightBottomRightPart

                    SUB x, #50
                    ADD y, #50

                    bigEightBottomLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigEightBottomLeftPart

                    bigEightMiddlePart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigEightMiddlePart

                    SUB heightLimit, y, #50

                    bigEightTopRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigEightTopRightPart

                    SUB x, #50
                    ADD y, #50

                    bigEightTopLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigEightTopLeftPart

                    bigEightTopPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigEightTopPart

                    SUB x, #50
                    ADD y, #100

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

                    POP { r2, r3, pc }

    .globl DrawBigNine
    DrawBigNine:   PUSH { r2, r3, lr }

                    x .req r0
                    y .req r1
                    widthLimit .req r2
                    ADD widthLimit, x, #50

                    heightLimit .req r3
                    SUB heightLimit, y, #50

                    bigNineBottomPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigNineBottomPart

                    bigNineBottomRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigNineBottomRightPart

                    SUB x, #50

                    bigNineMiddlePart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigNineMiddlePart

                    SUB heightLimit, y, #50

                    bigNineTopRightPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigNineTopRightPart

                    SUB x, #50
                    ADD y, #50

                    bigNineTopLeftPart:

                        BL DrawPixel
                        SUB y, #1
                        CMP y, heightLimit

                    BNE bigNineTopLeftPart

                    bigNineTopPart:

                        BL DrawPixel
                        ADD x, #1
                        CMP x, widthLimit

                    BNE bigNineTopPart

                    SUB x, #50
                    ADD y, #100

                    .unreq x
                    .unreq y
                    .unreq widthLimit
                    .unreq heightLimit

                    POP { r2, r3, pc }

