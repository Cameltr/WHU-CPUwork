module ID_EX(
    input clk,
    input rst,
    input stall,
    //control signal
    input [1:0]WB_MemtoReg_id,
    input WB_RegWrite_id,
    input MEM_MemWrite_id,
    input MEM_MemRead_id,
    input [4:0]EX_ALUCode_id,
    input EX_ALUSrcA_id,
    input EX_ALUSrcB_id,
    input [1:0]EX_RegDst_id,
    //address
    input [4:0]RsAddr_id,
    input [4:0]RtAddr_id,
    input [4:0]RdAddr_id,
    //data
    input [31:0]PC_id,
    input [31:0]Imm_id,
    input [31:0]RsData_id,
    input [31:0]RtData_id,

    output reg [1:0] WB_MemtoReg_ex,
    output reg WB_RegWrite_ex,
    output reg MEM_MemWrite_ex,
    output reg MEM_MemRead_ex,
    output reg [4:0] EX_ALUCode_ex,
    output reg EX_ALUSrcA_ex,
    output reg EX_ALUSrcB_ex,
    output reg [1:0] EX_RegDst_ex,
    output reg [4:0] RsAddr_ex,
    output reg [4:0] RtAddr_ex,
    output reg [4:0] RdAddr_ex,
    output reg [31:0] PC_ex,
    output reg [31:0] Imm_ex,
    output reg [31:0] RsData_ex,
    output reg [31:0] RtData_ex
);
    always @(posedge rst) begin
        WB_MemtoReg_ex<=0;
        WB_RegWrite_ex<=0;
        MEM_MemWrite_ex<=0;
        MEM_MemRead_ex<=0;
        EX_ALUCode_ex<=0;
        EX_ALUSrcA_ex<=0;
        EX_ALUSrcB_ex<=0;
        EX_RegDst_ex<=0;
        RsAddr_ex<=0;
        RtAddr_ex<=0;
        RdAddr_ex<=0;
        PC_ex<=0;
        Imm_ex<=0;
        RsData_ex<=0;
        RtData_ex<=0;
    end

    always @ (posedge clk)
    begin
        // clear all control signals
        if(stall) begin
            WB_MemtoReg_ex<=0;
            WB_RegWrite_ex<=0;
            MEM_MemWrite_ex<=0;
            MEM_MemRead_ex<=0;
            EX_ALUCode_ex<=0;
            EX_ALUSrcA_ex<=0;
            EX_ALUSrcB_ex<=0;
            EX_RegDst_ex<=0;
        end
        else begin
            WB_MemtoReg_ex<=WB_MemtoReg_id;
            WB_RegWrite_ex<=WB_RegWrite_id;
            MEM_MemWrite_ex<=MEM_MemWrite_id;
            MEM_MemRead_ex<=MEM_MemRead_id;
            EX_ALUCode_ex<=EX_ALUCode_id;
            EX_ALUSrcA_ex<=EX_ALUSrcA_id;
            EX_ALUSrcB_ex<=EX_ALUSrcB_id;
            EX_RegDst_ex<=EX_RegDst_id;
            RsAddr_ex<=RsAddr_id;
            RtAddr_ex<=RtAddr_id;
            RdAddr_ex<=RdAddr_id;
            PC_ex<=PC_id;
            Imm_ex<=Imm_id;
            RsData_ex<=RsData_id;
            RtData_ex<=RtData_id;
        end
    end
endmodule