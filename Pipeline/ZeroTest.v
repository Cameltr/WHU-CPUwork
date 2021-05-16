`include "E:/Pipelinecpu/ctrl_encode_def.v"

module ZeroTest (
    input [31:0] A,
    input [31:0] B,
    input [4:0] ALUOp,

    output reg zero
);
    always @(*) begin
        case (ALUOp)
            `ALUOp_EQL:  zero = (A == B)?1'b1:1'b0;
            `ALUOp_BNE:  zero = (A == B)?1'b0:1'b1;
            default: zero=0;
        endcase
    end
endmodule