module HazardInspector(
    input rst,
    input Branch,
    input Whether_jump,
    input[4:0] RsAddr_id,
    input[4:0] RtAddr_id,
    input[4:0] RtAddr_ex,
    input MEM_MemRead_ex,
    input [4:0]RegWriteAddr_ex,
    
    output reg Keep_current_PC,
    output reg IFIDWrite,
    output reg stall,
    output reg flush
);

    always @(posedge rst)begin
            Keep_current_PC <= 1;
            IFIDWrite <= 1;
            stall <= 0;
            flush <= 0;
    end
    always @(*)
    begin
        if(MEM_MemRead_ex&&(RegWriteAddr_ex != 0)
		   &&((RtAddr_ex==RsAddr_id)||(RtAddr_ex==RtAddr_id)))//lw --data adventure
        begin
            Keep_current_PC<=0;// we not need to update the PC
            IFIDWrite<=0;//keep the IF/ID constant
            stall<=1;//we don't deliver the data of ID to ID/EX
            flush <= 0;
        end
        else if(Branch||Whether_jump) begin
            //when we need to flush the pipline(beq/bne/j/jal), we need to let Whether_jump become 1
            flush <= 1;
        end
        else 
        begin
            Keep_current_PC <= 1;
            IFIDWrite <= 1;
            stall <= 0;
            flush <= 0;
        end
    end
endmodule