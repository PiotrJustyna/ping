    DrawScore:  PUSH { lr }

                x .req r0
                LDR x, =(1920 - 200 + 22)

                y .req r1
                LDR y, =((1080 / 2) - 21)

                colour .req r2
                LDR colour, =0xFF0

                // Top Score
                BL DrawBigZero

                LDR y, =((1080 / 2) + 21 + 300)

                //  Bottom Score
                BL DrawBigZero

                .unreq colour
                .unreq x
                .unreq y

                POP { pc }

    DrawBigZero:   PUSH { lr }

                x .req r0
                y .req r1

                xLimit .req r7
                ADD xLimit, x, #158

                yLimit .req r8
                SUB yLimit, y, #300

                topScoreLoop1:

                    BL DrawPixel
                    ADD x, #1
                    CMP x, xLimit

                BNE topScoreLoop1

                topScoreLoop2:

                    BL DrawPixel
                    SUB y, #1
                    CMP y, yLimit

                BNE topScoreLoop2

                SUB xLimit, #158

                topScoreLoop3:

                    BL DrawPixel
                    SUB x, #1
                    CMP x, xLimit

                BNE topScoreLoop3

                ADD yLimit, #300

                topScoreLoop4:

                    BL DrawPixel
                    ADD y, #1
                    CMP y, yLimit

                BNE topScoreLoop4

                .unreq x
                .unreq y
                .unreq xLimit
                .unreq yLimit

                POP { pc }
