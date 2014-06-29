/************************************************/
/* This file contains various global variables. */
/*                                              */
/* Author: Piotr Justyna                        */
/************************************************/

.section .data

    .align 4

    .globl FrameBufferInfo
    ///*
    FrameBufferInfo:    .int 1920   // #0 Width
                        .int 1080   // #4 Height
                        .int 1920   // #8 Virtual Width
                        .int 1080	// #12 Virtual Height
                        .int 0      // #16 Pitch, set by the GPU (from elinux: "number of bytes between each row of the frame buffer").
                        .int 16     // #20 Bit Dpeth
                        .int 0      // #24 X Margin
                        .int 0      // #28 Y Margin
                        .int 0      // #32 Framebuffer pointer. Set by the GPU.
                        .int 0      // #36 Framebuffer size, set by the GPU.
    //*/
    /*
    FrameBufferInfo:    .int 1280   // #0 Width
                        .int 1024   // #4 Height
                        .int 1280   // #8 Virtual Width
                        .int 1024   // #12 Virtual Height
                        .int 0      // #16 Pitch, set by the GPU (from elinux: "number of bytes between each row of the frame buffer").
                        .int 16     // #20 Bit Dpeth
                        .int 0      // #24 X Margin
                        .int 0      // #28 Y Margin
                        .int 0      // #32 Framebuffer pointer. Set by the GPU.
                        .int 0      // #36 Framebuffer size, set by the GPU.
    */

    .align 1

    .globl FramebufferInfoAddress
    FramebufferInfoAddress: .int 0

    .globl FrameTime
    FrameTime:   .int 1000

    .globl FastFrameTime
    FastFrameTime:   .int 1000

    .globl SlowFrameTime
    SlowFrameTime:   .int 1000

    .globl RedColour
    RedColour: .int 0b1111100000000000

    .globl GreenColour
    GreenColour: .int 0b11111100000

    .globl BlueColour
    BlueColour: .int 0b11111

    .globl GrayColour
    GrayColour: .int 0b00110001110011

    .globl WhiteColour
    WhiteColour: .int 0b1111111111111111

    .globl BlackColour
    BlackColour: .int 0

    .globl ForegoundColour
    ForegoundColour:    .int 0

    .globl BackgroundColour
    BackgroundColour:    .int 0

    .globl TimerAddress
    TimerAddress:   .int 0x20003004

    .globl StartTimestamp
    StartTimestamp:     .int 0

    .globl EndTimestamp
    EndTimestamp:     .int 0

    .globl PaddleWidth
    PaddleWidth:    .int 400

    .globl PaddleHeight
    PaddleHeight:    .int 10

    .globl TopPaddleLocationX
    TopPaddleLocationX: .int 22

    .globl BottomPaddleLocationX
    BottomPaddleLocationX: .int 115

    .globl ScoreMargin
    ScoreMargin:    .int 200

    .globl BallWidth
    BallWidth:  .int 10

    .globl BallHeight
    BallHeight:  .int 10

    .globl BallDirectionX
    BallDirectionX:  .int 1

    .globl BallDirectionY
    BallDirectionY:  .int 1

    .globl TableLeftBorder
    TableLeftBorder:    .int 5

    .globl TableTopBorder
    TableTopBorder:    .int 5

    .globl TableRightBorder
    TableRightBorder:   .int 0

    .globl TableBottomBorder
    TableBottomBorder:  .int 0

    .globl BallPositionX
    BallPositionX:  .int 1 + 15

    .globl BallPositionY
    BallPositionY:  .int 10 + 15

    .globl PreviousBallPositionX
    PreviousBallPositionX:  .int 1 + 15

    .globl PreviousBallPositionY
    PreviousBallPositionY:  .int 10 + 15

    .globl TopPlayerScore
    TopPlayerScore: .int 0

    .globl BottomPlayerScore
    BottomPlayerScore: .int 0

    .align 2

    .globl TopAvatar
    TopAvatar: .hword 0b1000111010111110,   0b1000111010111110, 0b1001011011111110, 0b1001111101011110, 0b1001111011111110, 0b0111110010110110, 0b0101101110010001, 0b0101001101110001, 0b0100101011110000, 0b0101001111110011, 0b0101010000010100, 0b0101110001010101, 0b0111010100011000, 0b1000011000011011, 0b0111111001111100, 0b0101001110110011, 0b0111010110011011, 0b1000011001111101, 0b1000011010011110, 0b0111111001111110, 0b1000011010011110, 0b1000011010011110, 0b0111111001011110, 0b0111011001011110, 0b0111011000111110, 0b0111011000111110, 0b0111011000011110, 0b1001011010011110, 0b1000011001011110, 0b0110110111111110, 0b0111010111111110, 0b0111011000011110, 0b0111011000011110, 0b0111011000011110, 0b0101110110011110, 0b0101110110111110, 0b1000011001011110, 0b1000011000111110, 0b0111111000011110, 0b1000111000111110, 0b1000110100111000, 0b0110001110110001, 0b0101001100110000, 0b0100001011001111, 0b0100001011001111, 0b0100001011001111, 0b0100001010101111, 0b0100001010101110, 0b0100001010101111, 0b0100001100010000, 0b0100101100110001, 0b0100001011001111, 0b0100001110010011, 0b0111011010011100, 0b1000011000111110, 0b0111010111111110, 0b0111010111111110, 0b0111111000011110, 0b0111010111011110, 0b0110110111011110, 0b0110110110111110, 0b0111010111011110, 0b0111111000011110, 0b1000010111111110, 0b1000010111111110, 0b0111010110111110, 0b0111010110111110, 0b0110110110011110, 0b0111110110111110, 0b0110110101111110, 0b0110110110011110, 0b0110110101111110, 0b1000010111111110, 0b1000010111111110, 0b1000010111111110, 0b1000110111011101, 0b1000010010110101, 0b0110001110110001, 0b0101001100110000, 0b0100101011101111, 0b0101001100010000, 0b0100101011101111, 0b0100001011001110, 0b0011101010001101, 0b0011101010001101, 0b0011001000101100, 0b0010101000101100, 0b0011101001101110, 0b0011101010001110, 0b0101010010110101, 0b1011011101111110, 0b0110110110111110, 0b0111010110111110, 0b0111010110111110, 0b0111010110011110, 0b0111010110111110, 0b0110110110011110, 0b1000110111011110, 0b0111010101111101, 0b0111010101111110, 0b0111110101111110, 0b0111010101111110, 0b0110110101011101, 0b0111010101011101, 0b0111010101111110, 0b0111010101011101, 0b0111110101111110, 0b0111110101111101, 0b0111110111011110, 0b0111110110111110, 0b1000110110111110, 0b1000110101111011, 0b0111010000010010, 0b0110001110010001, 0b0101001100110000, 0b0101101101010001, 0b0111110001010101, 0b1000010010010101, 0b0111001111110011, 0b0100101011001110, 0b0011001001001101, 0b0011001001101101, 0b0011001000101100, 0b0010101000001100, 0b0010101001001101, 0b0010101001001101, 0b0111110111011000, 0b1001011001011101, 0b0111110110111110, 0b0111110110011110, 0b0110010101011101, 0b0110010101011101, 0b0110110101111101, 0b1000010110111110, 0b0111110101111101, 0b0110110101011101, 0b0111010101111101, 0b0111010101111101, 0b0110110101011101, 0b0110110101011101, 0b0110110101011101, 0b0110110101011101, 0b1000010101111101, 0b0110110100111101, 0b0111110110111110, 0b0111110110111110, 0b0111110110011101, 0b1000010011010110, 0b0110101111110010, 0b0110101111110010, 0b0110001110110010, 0b0111010000010011, 0b1001110101111001, 0b1011010111011010, 0b1010110111011010, 0b1000110010010101, 0b0101001100010000, 0b0011101010001101, 0b0011001001001101, 0b0011001000101100, 0b0010101000001100, 0b0010101000001100, 0b0010101001101101, 0b1000111001011011, 0b1000010110011101, 0b0111110110011101, 0b0110010100111101, 0b0100110011111101, 0b0110010100111101, 0b1000110110111110, 0b1000010110011101, 0b0110110101011101, 0b0110010100111101, 0b0110110100111101, 0b0110010100011101, 0b0101110011111101, 0b0110010100011101, 0b0111010101011101, 0b0111110101111101, 0b0111110101111101, 0b0111010101111101, 0b0110110100111101, 0b0111010100111011, 0b0110110000110011, 0b0110110000110011, 0b0110110000010011, 0b0111010000110011, 0b1000110011110110, 0b1011010111011010, 0b1011011000011011, 0b1011010111111010, 0b1010010101111001, 0b1000110010110110, 0b0111001111110011, 0b0100001010101101, 0b0010101000001100, 0b0010100111101011, 0b0010000111001011, 0b0010000111001011, 0b0100001100110001, 0b0111010101011101, 0b0111010101111101, 0b0101110100011100, 0b0101010011111101, 0b0101110100111101, 0b0111010101011101, 0b1000010101011100, 0b0111110101111100, 0b0101110011111100, 0b0101110100111100, 0b0101110100111101, 0b0101010011111100, 0b0110110101011101, 0b0111010101111101, 0b0111110110011101, 0b0111110101111100, 0b0111010110011101, 0b1000010110111100, 0b1010110110011000, 0b0110001111110010, 0b0111010010010100, 0b1000110011010110, 0b1001010011110110, 0b1010010101111000, 0b1011010110111010, 0b1011010111011010, 0b1010010101111001, 0b1001110100111000, 0b1001110100010111, 0b1000110010110110, 0b0111001111110010, 0b0011101001101100, 0b0010100111001010, 0b0010000110001010, 0b0010000110101010, 0b0010101000101101, 0b0111110111111110, 0b0111010110111101, 0b0110010101111101, 0b0101110100111101, 0b0101110100111100, 0b0111010110011101, 0b1000010101111100, 0b1000010101111100, 0b0110110101011100, 0b0101110100111100, 0b0101010100011100, 0b0101110100111100, 0b0110110101111101, 0b0111010110011101, 0b0111110110111101, 0b0111110110111101, 0b0111110110111101, 0b1011010100110111, 0b1100010110111001, 0b0111010000110011, 0b1010010110111001, 0b1101011011111101, 0b1011111000011010, 0b1011010111011010, 0b1011010110111001, 0b1010110110011001, 0b1010010100110111, 0b1001110011110110, 0b1001010010110101, 0b1000110010010101, 0b1000010001010100, 0b0111001110110001, 0b0100101010101101, 0b0011000111101011, 0b0010000110101010, 0b0010101001001101, 0b0111010110111101, 0b0110010101011100, 0b0110110101111101, 0b0110010101011100, 0b0111010110011101, 0b0111110110111101, 0b1000010111011101, 0b1000010111111101, 0b0111110110011101, 0b0110110101011100, 0b0101110100111100, 0b0101110100011100, 0b0110010101011100, 0b0110010101011100, 0b0110110101011100, 0b0110110101011100, 0b0110010011111011, 0b1100110111011001, 0b1011010011010101, 0b1000110011010101, 0b1101011011111101, 0b1100111010011100, 0b1011111000111011, 0b1011011000011010, 0b1010010101011000, 0b1001110100010111, 0b1010010100110111, 0b1001010010010101, 0b1000110000110011, 0b1000110001010100, 0b1000010000110100, 0b1000010000110011, 0b0111101111110010, 0b0110101110110001, 0b0100101011101111, 0b0011001010101110, 0b0100110001010110, 0b0100010000010101, 0b0100001111010101, 0b0101010010010111, 0b0110110101011010, 0b0111010110011100, 0b0111010110011100, 0b0111010101111100, 0b0111010110011100, 0b0110010100111100, 0b0110010011111011, 0b0110010100111100, 0b0110010100111100, 0b0110110101011100, 0b0110110101011100, 0b0110110101011100, 0b0111110101011100, 0b1011110011110101, 0b1010010000010010, 0b1001010100010111, 0b1101011011011101, 0b1011110111111010, 0b1011010110011000, 0b1000010000110011, 0b0101101100001111, 0b0110001101010000, 0b1001010001110101, 0b1001010001110101, 0b1000110001010100, 0b1000001111110010, 0b1000001111110010, 0b1000010000010011, 0b0111101111110010, 0b0111110000010011, 0b0110101111010010, 0b0010101000101100, 0b0011001011001111, 0b0010101010101110, 0b0011101011001111, 0b0011001010101110, 0b0011001011101101, 0b0011101110010001, 0b0100001111110101, 0b0100110001110111, 0b0110010011111010, 0b0110110100011011, 0b0110110100011011, 0b0110110100111011, 0b0110110100111011, 0b0110110100111011, 0b0110110100011011, 0b0110110100011011, 0b0111110101011100, 0b1100010101011000, 0b1010010100010110, 0b1011010111011001, 0b1101011010011100, 0b1010110100110111, 0b1001010010010100, 0b1000110000110010, 0b0110101101010000, 0b0100101010101101, 0b0100101010001101, 0b0111101101110001, 0b1000001111010010, 0b1000001111110010, 0b1000001111110010, 0b1000001111110010, 0b0111101110110001, 0b0111101111010001, 0b0110001101010000, 0b0001100101101000, 0b0010000111001011, 0b0010101000101100, 0b0010100111101011, 0b0010101000001100, 0b0010101001101100, 0b0010001001101101, 0b0001101001001110, 0b0010101011110001, 0b0011001101110011, 0b0101010010010110, 0b0110110100111010, 0b0110110100011011, 0b0110110011111010, 0b0111010101011011, 0b0110110011111010, 0b0110110011111010, 0b0111010101011011, 0b1101011001111100, 0b1001010011110110, 0b1100011001011011, 0b1100111001111100, 0b1011010101011000, 0b1010010011110110, 0b1001010010110101, 0b0011101001001101, 0b0011101000001011, 0b0100101001101100, 0b0100001000101011, 0b0111001101010000, 0b0111101110110001, 0b1000001111010010, 0b1000001111110010, 0b1000010000010010, 0b0111001110110001, 0b0100101010001101, 0b0100001010001101, 0b0101001100101111, 0b0100001010001101, 0b0010000111001010, 0b0010000110101010, 0b0010100111101011, 0b0011001001101100, 0b0010001010001100, 0b0010001001101101, 0b0010101011110000, 0b0100001111010000, 0b0101110001110100, 0b0110110100011010, 0b0111010100111010, 0b0111010100111010, 0b0111110101111011, 0b0111110101011011, 0b0110110100011010, 0b1100011000011001, 0b1000110011010101, 0b1100111010111101, 0b1100010111111010, 0b1010110100110111, 0b1001110010110101, 0b1000110000010010, 0b0110101100001111, 0b0101001011101110, 0b0101001001101011, 0b0110101100101110, 0b0111001100101111, 0b0111101101110000, 0b0111001101010000, 0b0111001101001111, 0b0110101101110000, 0b0110101100101111, 0b0101001010101101, 0b0111001111010010, 0b1000110001110100, 0b1000010001010100, 0b0110001110010001, 0b0100101011001110, 0b0011000111101010, 0b0010100111101010, 0b0010000111101010, 0b0010000111101001, 0b0010101001001010, 0b0100101101110001, 0b0100101111010010, 0b0110110010011000, 0b0110110011011001, 0b0110110010111001, 0b0100110000010111, 0b0101010000111000, 0b1000110110111011, 0b1101011011111100, 0b1010010101111000, 0b1100111010011100, 0b1011110111011010, 0b1010110100011000, 0b1010010010110110, 0b1000101111110010, 0b0111001101001111, 0b0110101100001110, 0b0111001101110000, 0b1000110000110011, 0b1000110000010011, 0b0101101010101100, 0b0011000110001001, 0b0010100110001000, 0b0011000111001001, 0b0100001000001010, 0b0101101011101110, 0b0111110000010011, 0b1000110011010110, 0b1001010100010111, 0b1001010100110111, 0b1000110011110110, 0b0111001111110010, 0b0100001001101100, 0b0010000110001001, 0b0010000111001010, 0b0001100101101000, 0b0010000111101010, 0b0100101110010010, 0b0100101111010111, 0b0100101111110111, 0b0101010000010111, 0b0100101111110111, 0b0100101111110111, 0b1101011011111101, 0b1100111010111100, 0b1010110111011010, 0b1011010111011010, 0b1011010110011001, 0b1010110011110110, 0b1001110001010101, 0b1001010000010011, 0b1000101111110010, 0b1001010000110100, 0b1010010010010110, 0b1010110011010110, 0b1000110000010011, 0b0100001000001010, 0b0011000110101001, 0b0011101000001010, 0b0011100111001001, 0b0011100111101010, 0b0110101101001111, 0b0111110000110011, 0b1000110011010110, 0b1001010011110111, 0b1001110100010111, 0b1001010100010111, 0b1000110010110101, 0b0110101111010001, 0b0011101000101011, 0b0010000101101000, 0b0010000101101000, 0b0001000101000111, 0b0100101101010000, 0b0101110000010111, 0b0100110000010111, 0b0101010000110111, 0b0100101111110111, 0b0100101111010110, 0b1010110101010111, 0b1010010101111000, 0b1010010101111000, 0b1000110001110100, 0b1000010000010010, 0b1000110000010011, 0b1000001110010001, 0b0111101101001111, 0b0111001100101111, 0b1000101111110010, 0b1010010011110110, 0b1010010011010110, 0b1000001111010010, 0b0101101010001100, 0b0101001001001011, 0b0101001001001011, 0b0011000110101001, 0b0100001000101011, 0b0111001110110001, 0b1000010001110100, 0b1001010011010110, 0b1001010011110111, 0b1001010011110110, 0b1001010010110101, 0b1000110010010100, 0b1000010001110100, 0b0110001110010000, 0b0010000110101001, 0b0001100101001000, 0b0001100101100111, 0b0011001001001011, 0b0101101111010101, 0b0101110000010111, 0b0101110000110111, 0b0101010000010111, 0b0100101111110111, 0b0111001101110001, 0b0111010000010011, 0b1000110010010101, 0b0110001101001111, 0b0110101110110001, 0b0111001111010001, 0b0110001100001110, 0b0110001011001101, 0b0110101100001110, 0b1001010000110011, 0b1010110011010110, 0b1001110001110110, 0b0111101110010001, 0b0110101100001110, 0b0110101011101110, 0b0101101010101100, 0b0011000110101000, 0b0100001000001010, 0b0110001100001110, 0b1000010000110011, 0b1000110010010100, 0b1001010011010110, 0b1001010011110111, 0b1000110011010110, 0b1000110010110101, 0b1000010001110100, 0b0110101111010001, 0b0010100111001010, 0b0001100100100111, 0b0010000110001000, 0b0001100100100111, 0b0101001101110010, 0b0101101111110110, 0b0101001111010110, 0b0101010000010110, 0b0101110000110111, 0b0010000101101100, 0b0100101010101101, 0b0101001100001111, 0b0101001011001101, 0b0110001101110000, 0b0100001001001011, 0b0011000111001001, 0b0100001010001100, 0b0101001011001101, 0b0101101010101101, 0b0111001100101111, 0b1000101111010001, 0b0111001100101111, 0b0110001010101100, 0b0110101011101110, 0b0100101000101010, 0b0011000110101001, 0b0010100110001001, 0b0100001000101010, 0b0111101111010001, 0b0111001110010000, 0b0110001100001110, 0b0110001100001111, 0b0110101110110001, 0b0111110000010011, 0b0111110000110011, 0b0110101110010000, 0b0011000111101010, 0b0001100100100111, 0b0001100101100111, 0b0001000011100110, 0b0100101100110000, 0b0111010011011000, 0b0110110011011000, 0b0110110010111000, 0b0110010010010111, 0b0001000100101011, 0b0010000101101010, 0b0011001000001011, 0b0011101001001100, 0b0100001010001101, 0b0011001000001011, 0b0101101011101110, 0b0110101101010000, 0b0101001010001101, 0b0100001000101011, 0b0010100110001000, 0b0011100110101000, 0b0100101000101010, 0b0101101010101100, 0b0101101010001100, 0b0100101000101011, 0b0101101010101101, 0b0101001011001101, 0b0110001100101111, 0b1000010001110100, 0b0110101101110000, 0b0101001010101100, 0b0100101010101101, 0b0110001100001110, 0b0111101111010001, 0b0111101111110001, 0b0111101111110001, 0b0011000111101001, 0b0001100100100111, 0b0001100100100110, 0b0001000011100110, 0b0100001010001101, 0b0110110010010111, 0b0110110010110111, 0b0110010010010111, 0b0110010010010111, 0b0010101000001110, 0b0001000010101000, 0b0001100100101000, 0b0010000110001001, 0b0010100111101011, 0b0011001000101011, 0b0101001011101110, 0b0110001100101111, 0b0110101101010000, 0b0101101010101101, 0b0101001001001011, 0b0011100110101000, 0b0010100101101000, 0b0011100111001001, 0b0011100111001001, 0b0101101010001100, 0b0110101100101111, 0b0110001100001111, 0b1000010000110011, 0b1000010001010100, 0b0111110000110011, 0b0110101110010000, 0b0101101100101111, 0b0101001011001110, 0b0111001110010000, 0b0111110000110011, 0b0111110000010010, 0b0010100110101001, 0b0001100101001000, 0b0100001000101011, 0b0001000011100110, 0b0011001000001010, 0b0110010001010101, 0b0111010010110111, 0b0111010011010111, 0b0111010010110110, 0b0011001010110000, 0b0000100010101000, 0b0000100010100111, 0b0001000011100111, 0b0001100101001000, 0b0010000111001010, 0b0011101001101100, 0b0101001010101101, 0b0011100111101010, 0b0011100111101001, 0b0100101001001011, 0b0100001000101010, 0b0010100110001000, 0b0011101001101100, 0b0101001101010001, 0b0101001001101100, 0b0101101010001100, 0b0111101110110001, 0b1000110001010100, 0b0111101111110010, 0b1000110001010100, 0b1000110010010101, 0b1001010010010101, 0b1001010011010110, 0b1000110010110101, 0b1000010001110011, 0b0111101111110010, 0b0100101001101011, 0b0101101010101100, 0b0111001100001110, 0b0010100110001000, 0b0010000110001000, 0b0110010000110100, 0b0110110010110111, 0b0110110010010110, 0b0110110001110100, 0b0011101011110001, 0b0000100010101000, 0b0000100010100111, 0b0000100010000111, 0b0001000010100101, 0b0001100100000111, 0b0010100110101001, 0b0100001001001100, 0b0100101001001011, 0b0011100111101010, 0b0011100111101001, 0b0010000110001000, 0b0101001101010001, 0b0110110010010110, 0b0110001111110100, 0b0100001000001010, 0b0100101001001011, 0b0110001011101101, 0b0110101011101101, 0b0111101110010000, 0b0111001110010000, 0b1001010010010101, 0b1001110011010110, 0b1001010010110101, 0b1000110001110100, 0b1000010000010010, 0b0111101111010001, 0b0110101101001111, 0b0110101100001101, 0b0111001100101111, 0b0001100100000110, 0b0001100100000110, 0b0101101111010010, 0b0110110001110101, 0b0111010010110101, 0b0110110001110100, 0b0100001101110011, 0b0000100011001001, 0b0000100010001000, 0b0000100010000111, 0b0000100010000110, 0b0001000010100101, 0b0001000011100110, 0b0010100101101000, 0b0011100111001001, 0b0011100111001001, 0b0011000111101010, 0b0101101110110011, 0b0110010000010101, 0b0101101111110100, 0b0110001111010011, 0b0100001001001011, 0b0011100111101010, 0b0110101100001110, 0b0111001110010000, 0b0111001110110000, 0b0111001110010000, 0b0111101110110000, 0b1000110000110010, 0b1000110000010010, 0b1000001111110001, 0b0111101111110001, 0b0111101111010001, 0b0111101111010001, 0b0111101110110000, 0b0010100101101000, 0b0001000011100110, 0b0001000011100110, 0b0101001101010000, 0b0110110000110010, 0b0110010000110011, 0b0110110001010010, 0b0100101111110101, 0b0011001010110000, 0b0000100010001000, 0b0000100010000111, 0b0000100010000110, 0b0000100010000110, 0b0000100010000101, 0b0000100010000101, 0b0001100011100111, 0b0001100100001001, 0b0011101010001111, 0b0101001110110101, 0b0111110010110111, 0b1000010001110011, 0b0111001110110000, 0b0100001001001011, 0b0100101001001100, 0b0110101101110000, 0b0111001111010001, 0b0110101100101110, 0b0110001100001110, 0b0110001011101101, 0b0111001101001110, 0b0111101101101111, 0b0111101110110000, 0b0111101111010001, 0b0110101100101110, 0b1000001111110010, 0b0011000111001001, 0b0001000011100110, 0b0001100011100101, 0b0001000011100101, 0b0100101011101101, 0b0110001111010000, 0b0110110001010011, 0b0110001111110000, 0b0101010000110110, 0b0100001111010101, 0b0001000011101001, 0b0000100010000111, 0b0000100010000111, 0b0000100010000110, 0b0000100010000110, 0b0000100010000110, 0b0001000011001010, 0b0001100100101101, 0b0001000011101000, 0b0101001110010100, 0b0101001110110100, 0b0101001100001111, 0b0100101001101100, 0b0101001010101101, 0b0101101011001101, 0b0110101011001110, 0b0110101011101110, 0b0110001011001110, 0b0101101010101101, 0b0110101101001111, 0b0111101110110000, 0b0111001110001111, 0b0111101111010000, 0b0110101101101111, 0b0001100011000101, 0b0001100011100110, 0b0001000011100110, 0b0001000011000101, 0b0001100011100101, 0b0001100011100101, 0b0011001000001001, 0b0110001111010001, 0b0110001111110000, 0b0101101111001111, 0b0101110010010111, 0b0100110000010110, 0b0010101001001111, 0b0000100010001000, 0b0000100010000111, 0b0000100010000111, 0b0000100010000110, 0b0000100010000110, 0b0001000011101011, 0b0010000101101110, 0b0001100011101010, 0b0011001001101111, 0b0100001100110010, 0b0010000100000110, 0b0011000111101001, 0b0100001001101100, 0b0110101100101111, 0b0111001110110001, 0b0111101111110010, 0b0111101111010001, 0b0111101111010001, 0b0111101111010001, 0b0111101111010000, 0b0111101110110000, 0b0111001110001111, 0b0100101001101011, 0b0000100010100100, 0b0001000011000101, 0b0001000011100110, 0b0001000011000101, 0b0001100011000101, 0b0001100011100101, 0b0010100110000111, 0b0101001110010000, 0b0101101111010000, 0b0101101111001111, 0b0101001111110101, 0b0100001111110110, 0b0011101100010010, 0b0000100010001000, 0b0000100010001000, 0b0000100010000111, 0b0000100001100111, 0b0001000010000111, 0b0001000010000111, 0b0001000011001010, 0b0010000101101100, 0b0001000011101000, 0b0011001010001110, 0b0001100011100101, 0b0001100100100110, 0b0010000100100110, 0b0101001010101101, 0b0111001101110000, 0b0111101110110001, 0b0111101111010001, 0b0111001110110000, 0b0111001110001111, 0b0111001101101110, 0b0110101101001110, 0b0110101101001110, 0b0010100110101000, 0b0001000011000101, 0b0001100011100101, 0b0001000011000101, 0b0001000011000101, 0b0001000011000101, 0b0001100011100101, 0b0001100100000101, 0b0100101100001101, 0b0101101110101111, 0b0101101111001111, 0b0010101001001110, 0b0100101111110110, 0b0100101111110110, 0b0000100010001001, 0b0000100001101000, 0b0000100010001000, 0b0000100001100111, 0b0000100001100110, 0b0000100010000111, 0b0001000010101000, 0b0001100100101100, 0b0001000010101000, 0b0001100100101000, 0b0001000010000100, 0b0000100010000100, 0b0001000010000100, 0b0010000100000110, 0b0011100111001001, 0b0101001010101100, 0b0101101010101100, 0b0101101011001100, 0b0101101011001100, 0b0110001011101100, 0b0110101101001101, 0b0110001100101110, 0b0001100011100110, 0b0001100011100101, 0b0001000011000101, 0b0001000011000101, 0b0000100010000100, 0b0001000011000101, 0b0001100011100101, 0b0001100100000101, 0b0011101001001010, 0b0101001110001110, 0b0100101101101110, 0b0100101111010100, 0b0101010000110111, 0b0101010000110111, 0b0001000011001010, 0b0000100010001001, 0b0000100001101000, 0b0000100001101000, 0b0000100001100111, 0b0000100001100111, 0b0001000010000111, 0b0010000101001100, 0b0001100100001010, 0b0000100001100101, 0b0000100010000011, 0b0000100010000011, 0b0001100100000110, 0b0011000110101001, 0b0011000110101001, 0b0100001000001011, 0b0101001001101011, 0b0101001010101100, 0b0101101011101101, 0b0110001100101110, 0b0110101101001110, 0b0011101000001001, 0b0001100011100101, 0b0001100011100101, 0b0001000011000101, 0b0001000010100100, 0b0001000010100100, 0b0001000010100100, 0b0001100011100101, 0b0001100011000101, 0b0011000111001000, 0b0100101100101101, 0b0100101101001110, 0b0101010000010110, 0b0101010000010110, 0b0100101111110110, 0b0001000100101011, 0b0000100010001010, 0b0000100001101000, 0b0000100010001001, 0b0000100001101000, 0b0000100001100111, 0b0001000010100111, 0b0001000100001010, 0b0001100101001100, 0b0000100001100110, 0b0000100001100011, 0b0001000010100100, 0b0010100101000111, 0b0011100111101010, 0b0011100111001001, 0b0011100111101010, 0b0100101001101011, 0b0101001010101100, 0b0110001011101101, 0b0110001100101110, 0b0100101010001100, 0b0101001010101100, 0b0001100100000110, 0b0001100011100101, 0b0001100011100110, 0b0010000101100111, 0b0001000011100101, 0b0001000010100100, 0b0001100011000100, 0b0001000011000100, 0b0010000101100110, 0b1001010101010110, 0b1100011010111011, 0b0100110000010110, 0b0100110000010110, 0b0100110000010110, 0b0001100101101100, 0b0000100010001010, 0b0000100001101001, 0b0000100010001001, 0b0000100001101000, 0b0000100001100110, 0b0001100010100110, 0b0001100100001011, 0b0001100101101100, 0b0000100010000111, 0b0001000010000100, 0b0001100011000101, 0b0011000110001000, 0b0100001000001011, 0b0011101000001010, 0b0011100111101010, 0b0100001000101010, 0b0101001010101100, 0b0101101011101101, 0b0101001011001100, 0b0100101001001011, 0b0100101010001100, 0b0001100011000101, 0b0001100011100101, 0b0010000101000111, 0b0010100110001000, 0b0011100111101001, 0b0010100110101000, 0b0001100011100101, 0b0001000011000101, 0b0001100011100101, 0b0101101100101110, 0b1101011100111101, 0b0100101111110101, 0b0100101111110101, 0b0100001111010101, 0b0001100110001100, 0b0000100001101001, 0b0000100010001010, 0b0000100001101001, 0b0000100010001001, 0b0001000010000110, 0b0001000011100111, 0b0001000100101010, 0b0001000100101100, 0b0001000010101000, 0b0001000011000110, 0b0010100110001000, 0b0011100111101001, 0b0100001000001010, 0b0100101001001011, 0b0100101001001011, 0b0100101001001011, 0b0101001010101100, 0b0101101011001101, 0b0100001000101010, 0b0110001100101110, 0b0010000101000111, 0b0001000011100101, 0b0001100100000110, 0b0110001110010000, 0b1000010010010100, 0b1000110011010110, 0b1000110010110101, 0b0101001011001101, 0b0010000100000110, 0b0001100011100101, 0b0011100111101001, 0b1011011000011001, 0b0100101111110101, 0b0100101111110101, 0b0100001110110101, 0b0010000111001101, 0b0000100001101000, 0b0000100010001010, 0b0000100001101001, 0b0000100010001001, 0b0001100011101001, 0b0001000011001001, 0b0001000011101001, 0b0001000100001010, 0b0001000010101000, 0b0001100011100111, 0b0011101000001010, 0b0100001000001010, 0b0100001000101010, 0b0100101001101011, 0b0101001010001100, 0b0101001010101100, 0b0101101011101101, 0b0101101011101110, 0b0101101100001110, 0b0011101000101011, 0b0001000011100101, 0b0001100011100110, 0b0011001000001010, 0b1000010010010101, 0b1000110011110110, 0b1001010100010111, 0b1001010100111000, 0b1000110100010111, 0b0011101000001010, 0b0010000100100110, 0b0101101100101110, 0b0111110000110010, 0b0100101111110101, 0b0100101111010100, 0b0100101111010101, 0b0010000110001100, 0b0000100001100111, 0b0000100001101001, 0b0000100001101000, 0b0001000010101000, 0b0001100011101010, 0b0001100101001101, 0b0001100111001110, 0b0000100010101000, 0b0001000010100111, 0b0001100011100111, 0b0100001000101011, 0b0100001000101011, 0b0100001000101011, 0b0100101001101011, 0b0101001010001100, 0b0101101010101101, 0b0110001100101111, 0b0110101101010000, 0b0101101100101111, 0b0001100100000110, 0b0001100011100101, 0b0001100100000110, 0b0110101111110010, 0b1000010010110101, 0b1000110011110110, 0b1001010100110111, 0b1001010100111000, 0b1001010100111000, 0b0111010000010010, 0b0010100101000111, 0b0101101100001101, 0b1001110101010110, 0b0100101111110101, 0b0100001110010100, 0b0100001110010100, 0b0010000110001011, 0b0000100001100111, 0b0000100001101000, 0b0001000010001001, 0b0001100010101000, 0b0001100100001010, 0b0001100101001101, 0b0001000101101101, 0b0001000011001001, 0b0001000010000110, 0b0010000100100111, 0b0100001001001011, 0b0100001001101011, 0b0100001001001011, 0b0100101001101100, 0b0101001010001100, 0b0101101011001101, 0b0110001100110000, 0b0110101101110000, 0b0011100111101001, 0b0001100011100101, 0b0001100011100101, 0b0011101001001011, 0b0111110010010101, 0b1000110011010110, 0b1001010011110110, 0b1001010100110111, 0b1001010100110111, 0b1001010100010111, 0b1000110011110110, 0b0100101010101100, 0b0111010001010010, 0b1100111100111101, 0b0100110000010101, 0b0011101101010010, 0b0100001111010101, 0b0001100101101100, 0b0000100001101000, 0b0000100001100111, 0b0000100001101000, 0b0001100011001001, 0b0001000011001011, 0b0001100101101101, 0b0001000100001100, 0b0000100010101001, 0b0001000010000111, 0b0010000101101000, 0b0100001010001100, 0b0100101010001100, 0b0100001001001011, 0b0100101010001100, 0b0101001011001101, 0b0101101011101110, 0b0110001100101111, 0b0101101011101110, 0b0001100011100110, 0b0001100011100110, 0b0001100100100111, 0b0110101111110010, 0b1000010010010101, 0b1000110011010110, 0b1001010011110110, 0b1001010100010111, 0b1001110100110111, 0b1001010100010111, 0b1000110011110110, 0b0111110001010011, 0b0110110000010010, 0b1010010110111000, 0b0101010000110110, 0b0011101100010010, 0b0100001111010101, 0b0001100101001100, 0b0000100001101001, 0b0000100001101000, 0b0000100001100111, 0b0000100010001010, 0b0001100101101101, 0b0001000100101011, 0b0001000011001001, 0b0000100001100111, 0b0000100001100111, 0b0001000010100100, 0b0100001001101100, 0b0100001010101101, 0b0100001001001011, 0b0100101010101101, 0b0101101011101110, 0b0110001100101111, 0b0110001101010000, 0b0010100110001000, 0b0001100011100101, 0b0001100011100110, 0b0100101010101101, 0b0111110001010100, 0b1000010010010101, 0b1000110010110110, 0b1001010011010110, 0b1001010011110110, 0b1001010011110110, 0b1001010011110111, 0b1001010011010110, 0b0111110001110011, 0b0110110000110010, 0b1000110101010111, 0b0101010000110110, 0b0011101100110010, 0b0101010000010110, 0b0001000100101011, 0b0000100001101001, 0b0000100001101010, 0b0000100001101001, 0b0000100001101000, 0b0001000011001011, 0b0000100011101011, 0b0000100001101000, 0b0000100001100111, 0b0000100001100110, 0b0000100001100100, 0b0001100100000110, 0b0011101000101011, 0b0011101000101011, 0b0101001010101101, 0b0101101100101111, 0b0110001101010000, 0b0100001001001011, 0b0001100011100110, 0b0001100011100110, 0b0010000101000111, 0b0111010000110011, 0b0111110001110100, 0b1000010001110100, 0b1000110010110101, 0b1000110010110101, 0b1001010011010110, 0b1001010011010110, 0b1000110010110101, 0b1000110010010100, 0b1000010001010011, 0b0111010001110011, 0b0111010000110011, 0b0101010000010110, 0b0011101100110010, 0b0101010000010110, 0b0001000100001010, 0b0000100001101001, 0b0000100001101001, 0b0000100001101010, 0b0000100001101001, 0b0000100010001001, 0b0001100101001101, 0b0000100010001010, 0b0000100001101000, 0b0000100001100111, 0b0000100001100101, 0b0001000010000100, 0b0001000011100101, 0b0011101000001010, 0b0101001011101110, 0b0101101101010000, 0b0100001010001100, 0b0001100011100110, 0b0001000011100101, 0b0001000011100110, 0b0100001010101101, 0b0111110001110100, 0b1000010010010100, 0b1000010010010100, 0b1000010010010100, 0b1000110010110101, 0b1000110010110101, 0b1000110010010100, 0b1000010001110011, 0b1000010000110011, 0b0111110000110010, 0b0110001111010001, 0b0110001111110010, 0b0100101111110101, 0b0011101101110011, 0b0100101111010101, 0b0001000011001001, 0b0000100001101000, 0b0000100001101000, 0b0000100010001000, 0b0000100001101000, 0b0000100010001000, 0b0001000010101001, 0b0000100010001010, 0b0000100010001010, 0b0000100010001001, 0b0000100010000110, 0b0001000010100101, 0b0001000010100100, 0b0001000011000101, 0b0010100110101001, 0b0010100110001000, 0b0001000011000110, 0b0001000011100101, 0b0001000011100101, 0b0001100100000110, 0b0110101111110010, 0b1000010010110101, 0b1000010010010101, 0b1000010010010100, 0b1000010001110011, 0b1000110010110100, 0b1000110010110101, 0b1000110001110100, 0b1000010000110011, 0b0111110000010010, 0b0111110000110010, 0b0110101111110001, 0b0101001101001111, 0b0100001110110100, 0b0011101101010011, 0b0100101111110110, 0b0000100010101000, 0b0000100010001000, 0b0000100010001000, 0b0000100001101000, 0b0000100001101000, 0b0000100001101000, 0b0000100001101000, 0b0000100010001000, 0b0000100010001000, 0b0000100010001001, 0b0000100001100111, 0b0000100010000100, 0b0001000010000100, 0b0001000010100100, 0b0001000011000101, 0b0001000011000101, 0b0001000011100101, 0b0001000011100101, 0b0001100011100110, 0b0010100110001000, 0b0111110001010100, 0b1000010010010101, 0b1000010010010100, 0b1000010001110100, 0b1000010001110011, 0b1000110001110100, 0b1000110010010100, 0b1000010001010011, 0b0111110000010010, 0b0111110000010001, 0b0111110000110010, 0b0111010000010010, 0b0101101101110000, 0b0100101110110100, 0b0100101110010100, 0b0100101110110101, 0b0000100001101000, 0b0000100001101000, 0b0000100001101001, 0b0000100010001001, 0b0000100001101001, 0b0000100001101001, 0b0000100001101001, 0b0000100001101001, 0b0000100001101001, 0b0000100001101000, 0b0000100010001000, 0b0000100001100100, 0b0001000010000100, 0b0001000010100100, 0b0001000010100101, 0b0001000011000101, 0b0001000011000101, 0b0001000011000101, 0b0001000011100101, 0b0011101000101010, 0b0111110000110011, 0b1000010001110011, 0b1000010001110011, 0b1000010001110011, 0b1000010001110011, 0b1000010001110011, 0b1000110001110011, 0b1000010001010011, 0b0111110000010010, 0b0111110000010010, 0b0111110000010010, 0b0111010000010010, 0b0101101111010001, 0b0100101110110100, 0b0100101111010100, 0b0100001101010010, 0b0000100001100111, 0b0000100001101000, 0b0000100010001000, 0b0000100001101001, 0b0000100001101010, 0b0000100001101010, 0b0000100001101010, 0b0000100001101001, 0b0000100010001001, 0b0000100010001001, 0b0000100001101001, 0b0000100001100101, 0b0000100010000100, 0b0001000010100100, 0b0001000011000101, 0b0001000011000101, 0b0001000011000101, 0b0001000011000101, 0b0001000011100101, 0b0011101000101010, 0b0111010000010010, 0b0111110000010010, 0b1000010000110010, 0b1000010001110011, 0b1000010010010100, 0b1000010001110011, 0b1000110001110011, 0b1000010001010010, 0b0111110000010001, 0b0111101111110001, 0b0111110000010010, 0b0111110000010010, 0b0101001101110000
