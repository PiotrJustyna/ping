/************************************************/
/* This file contains various global variables. */
/*                                              */
/* Author: Piotr Justyna                        */
/************************************************/

.section .data

    .align 4

    .globl FrameBufferInfo
    /*
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
    */
    ///*
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
    //*/

    .globl FramebufferInfoAddress
    FramebufferInfoAddress: .int 0

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
    BlackColour: .int 0b0

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
    TopPaddleLocationX: .int 0

    .globl BottomPaddleLocationX
    BottomPaddleLocationX: .int 0

    .globl ScoreMargin
    ScoreMargin:    .int 200

    .globl BallWidth
    BallWidth:  .int 10

    .globl BallHeight
    BallHeight:  .int 10

    .globl BallDirectionX
    BallDirectionX:  .int 0

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
    //BallPositionX:  .int 660 - 19             // lower and upper left
    BallPositionX:  .int 340 + 400 + 19         // lower and upper right
    //BallPositionX:  .int 660 + 400 + 19         // lower and upper right
    //BallPositionX:  .int 340 - 19
    //BallPositionX:  .int 740 + 19

    .globl BallPositionY
    //BallPositionY:  .int 40
    //BallPositionY:  .int 1024 - 30
    BallPositionY:  .int 1025 - 50              // lower right : 50, 49, 48
    //BallPositionY:  .int 1080 - 50              // lower right : 50, 49, 48

    .globl PreviousBallPositionX
    //PreviousBallPositionX:  .int 660 - 19     // lower and upper left
    PreviousBallPositionX:  .int 340 + 400 + 19 // lower and upper right
    //PreviousBallPositionX:  .int 660 + 400 + 19 // lower and upper right
    //PreviousBallPositionX:  .int 340 - 19
    //PreviousBallPositionX:  .int 740 + 19

    .globl PreviousBallPositionY
    //PreviousBallPositionY:  .int 40           // 38, 39, 40? upper right?
    //PreviousBallPositionY:  .int 1024 - 30
    PreviousBallPositionY:  .int 1024 - 49      // lower right : 50, 49, 48
    //PreviousBallPositionY:  .int 1080 - 49      // lower right : 50, 49, 48
