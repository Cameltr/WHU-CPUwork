
`include "E:/Pipelinecpu/ctrl_encode_def.v"

module alu(
    input [31:0] A,
    input [31:0] B,
    input [4:0] ALUOp,

    output reg [31:0] C,
    output reg zero
);
	

	 always @(A or B or ALUOp) begin
		case(ALUOp)
			`ALUOp_ADDU: C = A + B;           //addu
			`ALUOp_SUBU: C = A - B;           //subu
            `ALUOp_ADD:  C = $signed(A) + $signed(B);
            `ALUOp_SUB:  C = $signed(A) - $signed(B);
            `ALUOp_AND:  C = A & B;
			`ALUOp_OR:   C = A | B;
            `ALUOp_EQL:  zero = (A == B)?1'b1:1'b0;//beq
            `ALUOp_BNE:  zero = (A == B)?1'b0:1'b1;//bne
            `ALUOp_SLT:  C = ($signed(A) < $signed(B));//C = (A < B) ? 32'd1 : 32'd0;
            `ALUOp_SLL:  C = B << A[4:0];//A从 rs和shamt里选
            `ALUOp_SRL:  C = B >> A[4:0];
            `ALUOp_SRA:  C = $signed(B) >>> A[4:0];
            `ALUOp_LUI:  C = B << 16;
		endcase
	 end
	 
endmodule



