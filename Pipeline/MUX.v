module MuxOne_out_of_two(
	input control,
	input [31:0] data1,
	input [31:0] data2,
	output [31:0] out
);
    assign out=control?data2:data1;
endmodule

module MuxOne_out_of_three(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [1:0] control,
    output [31:0] out
);
    reg [31:0] temp;

    always @(*)
    begin
        case (control)
            2'b00: temp = data1;
            2'b01: temp = data2;
            2'b10: temp = data3;
        endcase
    end
    assign out=temp;
endmodule

module DatatoReg_mux(
	input [1:0] DatatoReg,
	input [31:0] ALU_data,
	input [31:0] Mem_data,
	input [31:0] oldPc,
	output reg [31:0] DatatoReg_out
);
	
	always@(ALU_data or Mem_data or DatatoReg)
    begin
		case(DatatoReg)
			2'b00: DatatoReg_out = ALU_data;
			2'b01: DatatoReg_out = Mem_data;
            2'b10: DatatoReg_out = oldPc + 32'd4;
		endcase
	end
endmodule

