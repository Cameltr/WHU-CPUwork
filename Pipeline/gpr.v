module gpr(
    input clk,
    input rst,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] wd,
    input we,
    output [31:0] outa,
    output [31:0] outb
    );
	
	reg [31:0] Gpr[31:0];
	integer  i;
	
	always @(posedge clk or posedge rst) begin
		if(rst)
			for(i = 0; i < 32; i = i+1)
				Gpr[i] = 0;
	 	else if(we)
			begin
			Gpr[rd] = (rd == 0)?0:wd;
			$display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", 0, Gpr[1], Gpr[2], Gpr[3], Gpr[4], Gpr[5], Gpr[6], Gpr[7]);
			$display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", Gpr[8], Gpr[9], Gpr[10], Gpr[11], Gpr[12], Gpr[13], Gpr[14], Gpr[15]);
			$display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", Gpr[16], Gpr[17], Gpr[18], Gpr[19], Gpr[20], Gpr[21], Gpr[22], Gpr[23]);
			$display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", Gpr[24], Gpr[25], Gpr[26], Gpr[27], Gpr[28], Gpr[29], Gpr[30], Gpr[31]);
			$display("R[%4X]=%8X", rd, Gpr[rd]);
   		end
	end
	assign outa = (rs == 0) ? 0: Gpr[rs];
	assign outb = (rt == 0) ? 0: Gpr[rt];
endmodule
