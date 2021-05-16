//顶层文件
`timescale 1ns/1ns
module sccomp(clk, rstn, reg_sel, seg, dig);
   input          clk;
   input          rstn;
   input [4:0]    reg_sel;
   output [7:0]   seg;
   output [7:0]   dig;
   
   wire [31:0]    instr;
   wire [31:0]    PC;
   wire           MemWrite;
   wire [31:0]    dm_addr, dm_din, dm_dout;
   
   wire rst = ~rstn;
   
   wire [31:0]  reg_data;
   reg [7:0] seg;
   reg [7:0] dig;
   reg [36:0] counter;
   integer k;
    
  // instantiation of single-cycle CPU   
   sccpu U_SCCPU(
         .clk(clk),                 // input:  cpu clock
         .rst(rst),                 // input:  reset
         .instr(instr),             // input:  instruction
         .readdata(dm_dout),        // input:  data to cpu  
         .MemWrite(MemWrite),       // output: memory write signal
         .PC(PC),                   // output: PC
         .aluout(dm_addr),          // output: address from cpu to memory
         .writedata(dm_din),        // output: data from cpu to memory
         .reg_sel(reg_sel),         // input:  register selection
         .reg_data(reg_data)        // output: register data
         );
       
  // instantiation of data memory  
   dm    U_DM(
         .clk(clk),           // input:  cpu clock
         .DMWr(MemWrite),     // input:  ram write
         .addr(dm_addr[8:2]), // input:  ram address
         .din(dm_din),        // input:  data to ram
         .dout(dm_dout)       // output: data from ram
         );
         
  // instantiation of intruction memory (used for simulation)
   im    U_IM ( 
      .addr(PC[8:2]),     // input:  rom address
      .dout(instr)        // output: instruction
   );
   
   always @(posedge clk)
      counter = counter + 1;
   always @(counter[20:18])
      begin
      case (counter[20:18])
      3'b000 : dig = 8'b01111111;
      3'b001 : dig = 8'b10111111;
      3'b010 : dig = 8'b11011111;
      3'b011 : dig = 8'b11101111;
      3'b100 : dig = 8'b11110111;
      3'b101 : dig = 8'b11111011;
      3'b110 : dig = 8'b11111101;
      3'b111 : dig = 8'b11111110;
      endcase
      end
   always @(dig)
        begin
        case (dig)
        8'b01111111 : k = 7;
        8'b10111111 : k = 6;
        8'b11011111 : k = 5;
        8'b11101111 : k = 4;
        8'b11110111 : k = 3;
        8'b11111011 : k = 2;
        8'b11111101 : k = 1;
        8'b11111110 : k = 0;
        endcase
        case (reg_data[4 * k + 3 -: 4])
        4'h0 : seg = 8'hc0; //"0"
        4'h1 : seg = 8'hf9; //"1"
        4'h2 : seg = 8'ha4; //"2"
        4'h3 : seg = 8'hb0; //"3"
        4'h4 : seg = 8'h99; //"4"
        4'h5 : seg = 8'h92; //"5"
        4'h6 : seg = 8'h82; //"6"
        4'h7 : seg = 8'hf8; //"7"
        4'h8 : seg = 8'h80; //"8"
        4'h9 : seg = 8'h90; //"9"
        4'ha : seg = 8'h88; //"a"
        4'hb : seg = 8'h83; //"b"
        4'hc : seg = 8'hc6; //"c"
        4'hd : seg = 8'ha1; //"d"
        4'he : seg = 8'h86; //"e"
        4'hf : seg = 8'h8e; //"f"
        endcase
      end
        
endmodule

