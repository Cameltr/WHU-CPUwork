
module extend(
    input ExtOp,
    input [15:0] in,
    
    output [31:0] out
);
    assign out=ExtOp?{{16{in[15]}},in[15:0]}:{{16{1'b0}},in[15:0]};
endmodule
