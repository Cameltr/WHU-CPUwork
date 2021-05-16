module MEM_WB(  
    input clk,
    input rst,
    //control signals
    input [1:0] WB_MemtoReg_mem,
    input WB_RegWrite_mem,
    //address
    input [4:0] RegWriteAddr_mem,
    //data
    input [31:0] PC_mem,
    input [31:0] ALUResult_mem,
    input [31:0] MemOut_mem,
    
    output reg[1:0] WB_MemtoReg_wb,
    output reg WB_RegWrite_wb,
    output reg[4:0] RegWriteAddr_wb,
    output reg[31:0] PC_wb,
    output reg[31:0] ALUResult_wb,
    output reg[31:0] MemOut_wb
);
    always @(posedge rst) begin
        WB_MemtoReg_wb<=0;
        WB_RegWrite_wb<=0;
        PC_wb<=0;
        ALUResult_wb<=0;
        MemOut_wb<=0;
        RegWriteAddr_wb<=0;
    end
    always @(posedge clk ) begin
        WB_MemtoReg_wb<=WB_MemtoReg_mem;
        WB_RegWrite_wb<=WB_RegWrite_mem;
        PC_wb<=PC_mem;
        ALUResult_wb<=ALUResult_mem;
        MemOut_wb<=MemOut_mem;
        RegWriteAddr_wb<=RegWriteAddr_mem;
    end
endmodule