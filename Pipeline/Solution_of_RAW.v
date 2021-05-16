//The purpose of this module is to solve the problem of "read after write" 
//In order to solve this problem, I design a module to forward the data of WB to ID.
module Solution_of_RAW(
	input [4:0]RsAddr_id,
	input [4:0]RtAddr_id,
	input [4:0]RegWriteAddr_wb,
	input RegWrite_wb,

	output reg Rs_selection,
	output reg Rt_selection
);
	always@(*)
	begin
		if(RegWrite_wb && (RegWriteAddr_wb != 0) && (RegWriteAddr_wb == RsAddr_id))
			Rs_selection <= 1;
		else
			Rs_selection = 0;

		if(RegWrite_wb && (RegWriteAddr_wb != 0) && (RegWriteAddr_wb == RtAddr_id))
			Rt_selection <= 1;
		else
			Rt_selection <= 0;
	end
endmodule