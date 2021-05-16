
module im(
    input [11:2] Addr,
    output [31:0] Out
    );

	reg [31:0] IMem[1023:0];
	assign Out = IMem[Addr];

endmodule
