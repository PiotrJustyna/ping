/*************************************************************************************************************/
/* This file contains various time-related tasks like capturing timestamps and calculating time differences. */
/*                                                                                                           */
/* Author: Piotr Justyna                                                                                     */
/*************************************************************************************************************/

.section .text

    /* Captures current timestamp and stores it in memory as start timestamp. */
    /* Params: - */
    /* Returns: - */
    .globl CaptureStartTimestamp
    CaptureStartTimestamp:  PUSH { r0, r1, r2, lr }

                            timerAddress .req r0
                            LDR timerAddress, =TimerAddress
                            LDR timerAddress, [timerAddress]

                            currentTimestamp .req r1
                            LDR currentTimestamp, [timerAddress]

                            startTimestamp .req r2
                            LDR startTimestamp, =StartTimestamp
                            STR currentTimestamp, [startTimestamp]

                            .unreq timerAddress
                            .unreq currentTimestamp
                            .unreq startTimestamp

                            POP { r0, r1, r2, pc }

    /* Captures current timestamp and stores it in memory as end timestamp. */
    /* Params: - */
    /* Returns: - */
    .globl CaptureEndTimestamp
    CaptureEndTimestamp:  PUSH { r0, r1, r2, lr }

                            timerAddress .req r0
                            LDR timerAddress, =TimerAddress
                            LDR timerAddress, [timerAddress]

                            currentTimestamp .req r1
                            LDR currentTimestamp, [timerAddress]

                            endTimestamp .req r2
                            LDR endTimestamp, =EndTimestamp
                            STR currentTimestamp, [endTimestamp]

                            .unreq timerAddress
                            .unreq currentTimestamp
                            .unreq endTimestamp

                            POP { r0, r1, r2, pc }

    /* Retrieves start and end timestamps from memory, calculates the difference and returns it. */
    /* Params: - */
    /* Returns: */
    /* - R0: timespan.*/
    .globl MeasureTimespan
    MeasureTimespan:    PUSH { r1, r2, lr }

                        result .req r0

                        startTimestamp .req r1
                        LDR startTimestamp, =StartTimestamp
                        LDR startTimestamp, [startTimestamp]

                        endTimestamp .req r2
                        LDR endTimestamp, =EndTimestamp
                        LDR endTimestamp, [endTimestamp]

                        SUB result, endTimestamp, startTimestamp

                        .unreq result
                        .unreq startTimestamp
                        .unreq endTimestamp

                        POP { r1, r2, pc }
