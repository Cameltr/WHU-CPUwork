`timescale 1ns/1ns
// 测试文件
module sccomp_tb();
 //定义输入输出端口   
   reg  clk, rstn;
   reg  [4:0] reg_sel;
    

//实例化顶层文件
   sccomp U_SCCOMP(
      .clk(clk), .rstn(rstn), .reg_sel(reg_sel)
   );

 //初始化信号量并加载指令存储器，将指令添加到存储器中  
   initial 
   begin
      clk = 1;
      rstn = 1;
      #5 ;
      rstn = 0;
      #20 ;
      rstn = 1;
      #1000 ;
      reg_sel = 1;
   end
 //50ns一次时钟翻转 
    always 
	begin
		#50 clk = ~clk;
	if (clk == 1'b1) begin
	  $display("pc:\t %h", U_SCCOMP.PC);
    $display("instr:\t %h", U_SCCOMP.instr);
    $display("rf00-03:\t %h %h %h %h", 0, U_SCCOMP.U_SCCPU.U_RF.rf[1], U_SCCOMP.U_SCCPU.U_RF.rf[2], U_SCCOMP.U_SCCPU.U_RF.rf[3]);
    $display("rf04-07:\t %h %h %h %h", U_SCCOMP.U_SCCPU.U_RF.rf[4], U_SCCOMP.U_SCCPU.U_RF.rf[5], U_SCCOMP.U_SCCPU.U_RF.rf[6], U_SCCOMP.U_SCCPU.U_RF.rf[7]);
    $display("rf08-11:\t %h %h %h %h", U_SCCOMP.U_SCCPU.U_RF.rf[8], U_SCCOMP.U_SCCPU.U_RF.rf[9], U_SCCOMP.U_SCCPU.U_RF.rf[10], U_SCCOMP.U_SCCPU.U_RF.rf[11]);
    $display("rf12-15:\t %h %h %h %h", U_SCCOMP.U_SCCPU.U_RF.rf[12], U_SCCOMP.U_SCCPU.U_RF.rf[13], U_SCCOMP.U_SCCPU.U_RF.rf[14], U_SCCOMP.U_SCCPU.U_RF.rf[15]);
    $display("rf16-19:\t %h %h %h %h", U_SCCOMP.U_SCCPU.U_RF.rf[16], U_SCCOMP.U_SCCPU.U_RF.rf[17], U_SCCOMP.U_SCCPU.U_RF.rf[18], U_SCCOMP.U_SCCPU.U_RF.rf[19]);
    $display("rf20-23:\t %h %h %h %h", U_SCCOMP.U_SCCPU.U_RF.rf[20], U_SCCOMP.U_SCCPU.U_RF.rf[21], U_SCCOMP.U_SCCPU.U_RF.rf[22], U_SCCOMP.U_SCCPU.U_RF.rf[23]);
    $display("rf24-27:\t %h %h %h %h", U_SCCOMP.U_SCCPU.U_RF.rf[24], U_SCCOMP.U_SCCPU.U_RF.rf[25], U_SCCOMP.U_SCCPU.U_RF.rf[26], U_SCCOMP.U_SCCPU.U_RF.rf[27]);
    $display("rf28-31:\t %h %h %h %h", U_SCCOMP.U_SCCPU.U_RF.rf[28], U_SCCOMP.U_SCCPU.U_RF.rf[29], U_SCCOMP.U_SCCPU.U_RF.rf[30], U_SCCOMP.U_SCCPU.U_RF.rf[31]);
  end
  else begin
    $display("pc: %h", U_SCCOMP.U_SCCPU.PC);
    $display("instr: %h", U_SCCOMP.U_SCCPU.instr);
  end
  end
endmodule
