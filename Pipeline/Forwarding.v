/**
 * WARNING: This code is not safe, it use the result that may has not been caculated
 */
module Forwarding(
    input RegWrite_mem,
    input RegWrite_wb,
    input RegWrite_ex,
    input[4:0] RegWriteAddr_mem,
    input[4:0] RegWriteAddr_wb,
    input[4:0] RegWriteAddr_ex,
    input[4:0] RsAddr_ex,
    input[4:0] RtAddr_ex,
    //Forwarding in ID
    input[4:0] RsAddr_id,
    input[4:0] RtAddr_id,
    //the control signal of forwarding in EX, which is only for data adventure
    output reg[1:0] ForwardA,
    output reg[1:0] ForwardB,
    //the control signal of forwarding in ID, which is only for control adventure
    output reg[1:0] ForwardC,
    output reg[1:0] ForwardD
);

    

    always @(*)
    begin
        //Forwarding in EX that is used for data adventure
        //the instructions of "RegWriteAddr_mem !=0 and RegWriteAddr_wb!=0" are to prevent we modifying the value of $zero
        if(RegWrite_mem&&(RegWriteAddr_mem!=0)&&(RegWriteAddr_mem==RsAddr_ex))//when the pass two instruction's calculated result has not been written into Rs
            ForwardA=2'b10;
        else if(RegWrite_wb&&(RegWriteAddr_wb!=0)&&(RegWriteAddr_wb==RsAddr_ex))//when the pass one instruction's calculated result has not been written into Rs
            ForwardA=2'b01;
        else
            ForwardA=2'b00;
        if(RegWrite_mem&&(RegWriteAddr_mem!=0)&&(RegWriteAddr_mem==RtAddr_ex))//when the pass two instruction's calculated result has not been written into Rt
            ForwardB=2'b10;
        else if(RegWrite_wb&&(RegWriteAddr_wb!=0)&&(RegWriteAddr_wb==RtAddr_ex))//when the pass one instruction's calculated result has not been written into Rt
            ForwardB=2'b01;
        else
            ForwardB=2'b00;//Wow! I don't have to forward any data!

        //Forwarding in ID that is for control adventure
        //Well, what I have to admit is that the forward is not safe, especially the high frequence of CPU, because I assume that EX will not take up any time and we can forward the result of ALU to ID and use it to BNE/BEQ's register data's comparison. Furthermore, why the ALUResult_mem delivered into the MUX is the same reason.
        if(RegWrite_ex&&(RegWriteAddr_ex!=0)&&(RegWriteAddr_ex==RsAddr_id))//when the pass one instruction's calculated result has not been written into the destination
            ForwardC=2'b10;//choose the pass one instruction's calculated resulted of ALU
        else if(RegWrite_wb&&(RegWriteAddr_wb!=0)&&(RegWriteAddr_wb==RsAddr_id))//when the pass two instruction's calculated result has not been written into the destination
            ForwardC=2'b01;//choose the pass two instruction's calculated resulted of ALU
        else
            ForwardC=2'b00;//Wow, I do not need to forward any data!

        if(RegWrite_ex&&(RegWriteAddr_ex!=0)&&(RegWriteAddr_ex==RtAddr_id))//when the pass one instruction's calculated result has not been written into the destination
            ForwardD=2'b10;//choose the pass one instruction's calculated resulted of ALU
        else if(RegWrite_wb&&(RegWriteAddr_wb!=0)&&(RegWriteAddr_wb==RtAddr_id))//when the pass two instruction's calculated result has not been written into the destination
            ForwardD=2'b01;//choose the pass two instruction's calculated resulted of ALU
        else
            ForwardD=2'b00;//Wow, I do not need to forward any data!
    end
endmodule
/*
Well, I have to admit that the module is not perfect because when the instruction of lw is followed by a BNE/BEQ, we need to stall a period, but the test does not have this kind of instrucions, so I do not perfect the whole function.
*/