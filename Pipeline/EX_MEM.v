module EX_MEM( 
    input clk,
    input rst,
    //control signals
    input [1:0] WB_MemtoReg_ex,
    input WB_RegWrite_ex,
    input MEM_MemWrite_ex,
    input MEM_MemRead_ex,
    //address
    input [4:0] RegWriteAddr_ex,
    //data
    input [31:0] PC_ex,
    input [31:0] ALUResult_ex,
    input [31:0] MemWriteData_ex,
    
    output reg[1:0] WB_MemtoReg_mem,
    output reg WB_RegWrite_mem,
    output reg MEM_MemWrite_mem,
    output reg MEM_MemRead_mem,
    output reg[4:0] RegWriteAddr_mem,
    output reg[31:0] PC_mem,
    output reg[31:0] ALUResult_mem,
    output reg[31:0] MemWriteData_mem
);

    always @(posedge rst) begin
        WB_MemtoReg_mem<=0;
        WB_RegWrite_mem<=0;
        MEM_MemWrite_mem<=0;
        MEM_MemRead_mem<=0;
        RegWriteAddr_mem<=0;
        PC_mem<=0;
        ALUResult_mem<=0;
        MemWriteData_mem<=0;
    end
    always @(posedge clk ) begin
        WB_MemtoReg_mem<=WB_MemtoReg_ex;
        WB_RegWrite_mem<=WB_RegWrite_ex;
        MEM_MemWrite_mem<=MEM_MemWrite_ex;
        MEM_MemRead_mem<=MEM_MemRead_ex;
        RegWriteAddr_mem<=RegWriteAddr_ex;
        PC_mem<=PC_ex;
        ALUResult_mem<=ALUResult_ex;
        MemWriteData_mem<=MemWriteData_ex;
    end
endmodule