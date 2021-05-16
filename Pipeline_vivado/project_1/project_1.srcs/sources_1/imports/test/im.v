module im(input  [8:2]  addr,
            output [31:0] dout );

  reg  [31:0] ROM[127:0];
  
  initial begin
	$readmemh("studentnosorting.dat", ROM);
  end

  assign dout = ROM[addr]; 
endmodule  
