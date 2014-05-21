/***********************************************/
/* This file contains GPU-related subroutines. */
/*                                             */
/* Author: Piotr Justyna                       */
/***********************************************/

.section .text

    .globl InitialiseFrameBuffer
    InitialiseFrameBuffer:  PUSH { lr }

                            framebufferMailboxChannel .req r0
                            framebufferMailboxMessage .req r1
                            framebufferInfoAddress .req r2
                            mailboxBase .req r3
                            mailboxStatus .req r4
                            wholeMessage .req r5
                            readChannel .req r6
                            filteredMessage .req r7
                            
                            LDR framebufferInfoAddress, =FrameBufferInfo                        
                            MOV framebufferMailboxMessage, framebufferInfoAddress       /* Framebuffer info address is the message to be sent to the framebuffer channel. */
                            ADD framebufferMailboxMessage, #0x40000000                  /* Adding 0x40000000 tells the GPU not to use cache for writing back to the structure under framebufferInfoAddress (If the L2 cache is enabled, and it is by default). Changes are immediately visible to the CPU. */
                            MOV framebufferMailboxChannel, #1                           /* Set the mailbox channel to the framebuffer (1). */
                            LDR mailboxBase, =0x2000B880                                /* Set the mailbox base address. */

                            /* Send the framebufferInfo structure address to the mailbox. */
                            statusWriteLoop:                                            /* Loop in search of the correct mailbox status. */

                                LDR mailboxStatus, [mailboxBase, #0x18]                 /* Get the status word from the mailbox address. */
                                TST mailboxStatus, #0x80000000                          /* Check if the top, 31th bit of the status is 1 (1 * 2^31 + 0 * 2 ^(30 ... 0)). */
                                
                            BNE statusWriteLoop                                         /* Loop if not. */

                            ADD framebufferMailboxMessage, framebufferMailboxChannel    /* Mailbox is ready to write to, assemble the message. */
                            STR framebufferMailboxMessage, [mailboxBase, #0x20]         /* Send the assembled message to 20th byte of the mailbox ("Write" word). */

                            /* Read from the framebuffer mailbox. */
                            rightMailLoop:                                              /* Loop in search of the correct channel. */

                                statusReadLoop:                                         /* Loop in search of the correct mailbox status. */

                                    LDR mailboxStatus, [mailboxBase, #0x18]             /* Get the status word from the mailbox address. */
                                    TST mailboxStatus, #0x40000000                      /* Check if the 30th (top - 1, ) bit of the status is 1 (1 * 2^30 + 0 * 2 ^(29 ... 0)). */

                                BNE statusReadLoop                                      /* Loop if not. */
                                
                                LDR wholeMessage, [mailboxBase, #0]                     /* Mailbox is ready to read from, read the whole message from 0th byte of the mailbox ("Read" word). */

                                AND readChannel, wholeMessage, #0b1111                  /* Isolate the channel number from thw whole message (last 4 bits). */
                                TEQ readChannel, framebufferMailboxChannel              /* Check if the whole message is coming from the correct channel. */
                                
                            BNE rightMailLoop                                           /* If not, loop. */

                            .unreq framebufferMailboxChannel
                            framebufferMailboxReadResult .req r0

                            AND filteredMessage, wholeMessage, #0xFFFFFFF0              /* Isolate the message only (no channel). */
                            TEQ filteredMessage, #0                                     /* Check if the read result is 0. */
                            MOVNE filteredMessage, #0                                   /* If so, this means an error and this value will have to be propagated further. */
                            MOV framebufferMailboxReadResult, filteredMessage           /* Returning the filtered message indicating an error. */
                            BNE return

                            MOV framebufferMailboxReadResult, framebufferInfoAddress    /* If, however, the filteredMessage is 0, return newly read framebufferInfoAddress through framebufferMailboxReadResult (r0) */
                            
                            .unreq framebufferMailboxMessage
                            .unreq framebufferInfoAddress
                            .unreq mailboxBase
                            .unreq mailboxStatus
                            .unreq wholeMessage
                            .unreq readChannel
                            .unreq filteredMessage
                            .unreq framebufferMailboxReadResult
                            
                            return:

                                POP { pc }
