
module mips( );
    reg clk, reset;
         
    initial begin
        $readmemh( "E:/Pipelinecpu/Test_Instr.txt", IM.IMem ) ; 
        $monitor("PC = 0x%8X, IR = 0x%8X", PC.oldpc, IM.Out );   

        clk = 1 ;
        reset = 0 ;
        #5 reset = 1 ;
        #20 reset = 0 ;
    end
    
    always #50 clk = ~clk;
    parameter RA_ADDRESS = 5'b11111;

    //module of PC
    //input
    wire Keep_current_PC;//We need keep PC constant so as to stall
    wire [1:0]  PC_sel;//Decide the final input of PC
    //output
    wire [31:0] old_PC;//current PC

    //module of npc
    wire [31:0] new_PC; 
    wire Whether_branch;

    //module of im
    wire [31:0] Instrl;

    //module of IF_ID
    //input
    wire flush;
    wire IF_ID_keep;//you have to pay attention! Because IF_ID_keep is use for keep the IF/ID constant so as to stall
    //output
    wire [31:0] NextPC_id;
    wire [31:0] Instruction_id;

    //module of extend
    wire Ctrl_extend;
    wire [31:0] ext_out;

    //module of gpr
    wire [1:0]  MemtoReg;
    wire [31:0] RegWriteData_wb;
    wire [1:0]  RegDst;
    wire [4:0]  RegWriteAddress_ex;
    wire RegWrite;
    wire [31:0] Out1;
    wire [31:0] Out2;

    //module of ctrl
    wire ALUSrcA;
    wire ALUSrcB;
    wire [4:0]  ALUCode;
    wire [31:0] ALU_out;
    wire Whether_jump;

    //module of ID_EX
    wire stall;
    wire [1:0] WB_MemtoReg_ex;
    wire WB_RegWrite_ex;
    wire MEM_MemWrite_ex;
    wire MEM_MemRead_ex;
    wire EX_ALUSrcA_ex;
    wire EX_ALUSrcB_ex;
    wire [4:0] EX_ALUCode_ex;
    wire [1:0] EX_RegDst_ex;
    wire [31:0] PC_ex;
    wire [31:0] Imm_ex;
    wire [4:0] RsAddress_ex;
    wire [4:0] RtAddress_ex;
    wire [4:0] RdAddress_ex;
    wire [31:0] RealOut1_ex;
    wire [31:0] RealOut2_ex;

    //these two signals decide the input signal of ALU from the signal of shamt or RealOut1 and from the immediate or RealOut2  (Attention!!! the selecting function is not fulfilled)
    wire [31:0] RealOut1;
    wire [31:0] RealOut2;

    //the final input signal of ALU
    wire [31:0] Cal1;
    wire [31:0] Cal2;



    //module of Forward Unit decides the input signal of RealOut1 and RealOut2 from the Out1 or RegWtireAddress_wb or ALUResult_mem 
    wire[1:0] ForwardA;
    wire[1:0] ForwardB;
    //these two signals decide the input signal of Hazard Detector from Out1, ALUResult_mem or ALUOut
    wire[1:0] ForwardC;
    wire[1:0] ForwardD;
    wire[31:0] IDRealRs;//When we use BNE or BEQ, we need to compare the values of two registers but we are not sure the value has been written into Rt or Rs,so these two signals is the final result of data resource in the comparison
    wire[31:0] IDRealRt;

    //EX_MEM
    wire [1:0] WB_MemtoReg_mem;//just play a role in the next data register 
    wire WB_RegWrite_mem; //just play a role in the next data register 
    wire MEM_MemWrite_mem;
    wire MEM_MemRead_mem;
    wire [4:0] RegWriteAddress_mem;
    wire [31:0] PC_mem;
    wire [31:0] ALUResult_mem;
    wire [31:0] MemWriteData_mem;

    //dm
    wire [31:0] dm_data_out;
    wire MemWrite;
    wire MemRead;

    //MEM_WB
    wire [1:0] WB_MemtoReg_wb;
    wire WB_RegWrite_wb;
    wire [4:0] RegWriteAddress_wb;
    wire [31:0] PC_wb;
    wire [31:0] ALUResult_wb;
    wire [31:0] MemOut_wb;

    //WBtoID
    wire Rs_sel,Rt_sel;
    wire [31:0] FinalOut1,FinalOut2;

    //decompose Instruction
    wire[5:0] op;
    wire[5:0] funct;
    wire [4:0] RsAddress_id;
    wire [4:0] RtAddress_id;
    wire [4:0] RdAddress_id;

    assign op = Instruction_id[31:26];
    assign funct = Instruction_id[5:0];
    assign RsAddress_id = Instruction_id[25:21];
    assign RtAddress_id = Instruction_id[20:16];
    assign RdAddress_id = Instruction_id[15:11];
    
    /**
     * IF Stage
     */
    im  IM(old_PC[11:2],Instrl);
    npc NPC(IDRealRs,old_PC,NextPC_id,Instruction_id,Whether_branch,PC_sel,new_PC);
    pc  PC(new_PC,clk,reset,Keep_current_PC,old_PC);

    //IF to ID register, the Flush function being integrated
    IF_ID if_id(clk,reset,flush,IF_ID_keep,old_PC,Instrl,/*output*/NextPC_id,Instruction_id);

    /**
     * ID stage
     */
    //The gpr module is not FIRST WRITE THEN READ so we have to design a third forwaring unit to pass the data to write back to ID for further use
    Solution_of_RAW solution_of_RAW(RsAddress_id,RtAddress_id,RegWriteAddress_wb,WB_RegWrite_wb,/*output*/Rs_sel,Rt_sel);

    //Read and write Registers
    gpr GRF(clk,reset,RsAddress_id,RtAddress_id,RegWriteAddress_wb,RegWriteData_wb,WB_RegWrite_wb,Out1,Out2);
    //Produce the signals according to op and funct used in other elements
    ctrl CTRL(op,funct,RegDst,ALUSrcA,ALUSrcB,MemRead,RegWrite,MemWrite,MemtoReg,PC_sel,Ctrl_extend,ALUCode,Whether_jump);

    //Forward the data for ID to judge Whether_branch
    //Opps!!!!!!!!!!!there are some dangerous factors.But the details are presented in the "Forwarding.v"
    MuxOne_out_of_three IDRealRS(Out1,ALUResult_mem,ALU_out/*NOT SAFE*/,ForwardC,/*output*/IDRealRs);
    MuxOne_out_of_three IDRealRT(Out2,ALUResult_mem,ALU_out/*NOT SAFE*/,ForwardD,/*output*/IDRealRt);

    //Extend the Immediate
    extend EXTEND(Ctrl_extend,Instruction_id[15:0],/*output*/ext_out);

    //Choose which register (rt, rd, $ra) is the real one to write back
    MuxOne_out_of_three REGDST(RtAddress_ex,RdAddress_ex,RA_ADDRESS,EX_RegDst_ex,/*output*/RegWriteAddress_ex);

    //Provide the real data in the Register
    MuxOne_out_of_two writebackGrf_muxA(Rs_sel,Out1,RegWriteData_wb,/*output*/FinalOut1);
    MuxOne_out_of_two writebackGrf_muxB(Rt_sel,Out2,RegWriteData_wb,/*output*/FinalOut2);
    
    //A small ALU to test whether the condition is satisfied to Whether_branch
    ZeroTest zeroTest(IDRealRs,IDRealRt,ALUCode,Whether_branch);

    //ID to EX register, with Stall function integrated
    ID_EX id_ex(clk,rst,stall,MemtoReg,RegWrite,MemWrite,MemRead,ALUCode,ALUSrcA,ALUSrcB,RegDst,RsAddress_id,RtAddress_id,RdAddress_id,NextPC_id,ext_out,FinalOut1,FinalOut2,/*output*/WB_MemtoReg_ex,WB_RegWrite_ex,MEM_MemWrite_ex,MEM_MemRead_ex,EX_ALUCode_ex,EX_ALUSrcA_ex,EX_ALUSrcB_ex,EX_RegDst_ex,RsAddress_ex,RtAddress_ex,RdAddress_ex,PC_ex,Imm_ex,RealOut1_ex,RealOut2_ex);

    /**
     * EX stage
     */
    //decide whether we should stall or flush the pipeline
    //when we need to stall the pipeline(lw), we need to let Keep_current_PC and IF_ID_keep become 1. PS:Keep_current_PC always keeps equal to IF_ID_keep
    //when we need to flush the pipline(beq/bne/j/jal), we need to let Whether_jump become 1
    HazardInspector hazardinspector(reset,Whether_branch,Whether_jump,RsAddress_id,RtAddress_id,RtAddress_ex,MEM_MemRead_ex,RegWriteAddress_ex,/*output*/Keep_current_PC,IF_ID_keep,stall,flush);
    
    //detect which data should be the input of ALU
    Forwarding forwarding(WB_RegWrite_mem,WB_RegWrite_wb,WB_RegWrite_ex/*NOT SAFE*/,RegWriteAddress_mem,RegWriteAddress_wb,RegWriteAddress_ex/*NOT SAFE*/,RsAddress_ex,RtAddress_ex,RsAddress_id,RtAddress_id,/*output*/ForwardA,ForwardB,ForwardC,ForwardD);

    //Choose from the data (Register, Memory, ALUResult)
    MuxOne_out_of_three alua(RealOut1_ex,RegWriteData_wb,ALUResult_mem,ForwardA,/*output*/RealOut1);//Forward choose A
    MuxOne_out_of_three alub(RealOut2_ex,RegWriteData_wb,ALUResult_mem,ForwardB,/*output*/RealOut2);//Forward choose B
    //Choose from data in Register or in Immediate
    MuxOne_out_of_two aluSrcA(EX_ALUSrcA_ex,RealOut1,{27'b0, Imm_ex[10:6]}/*Shamt*/,/*output*/Cal1);
    MuxOne_out_of_two aluSrcB(EX_ALUSrcB_ex,RealOut2,Imm_ex,/*output*/Cal2);
    //ALU
    alu ALU(Cal1, Cal2, EX_ALUCode_ex,/*output*/ALU_out,/*empty*/);

    //EX to MEM register
    EX_MEM ex_mem(clk,reset,WB_MemtoReg_ex,WB_RegWrite_ex,MEM_MemWrite_ex,MEM_MemRead_ex,RegWriteAddress_ex,PC_ex,ALU_out,RealOut2,/*output*/WB_MemtoReg_mem,WB_RegWrite_mem,MEM_MemWrite_mem,MEM_MemRead_mem,RegWriteAddress_mem,PC_mem,ALUResult_mem,MemWriteData_mem);

    /**
     * MEM Stage
     */
    dm DM(ALUResult_mem,MemWriteData_mem,MEM_MemWrite_mem,MEM_MemRead_mem,clk,reset,/*output*/dm_data_out);
    //MEM to WB register
    MEM_WB mem_wb(clk,reset,WB_MemtoReg_mem,WB_RegWrite_mem,RegWriteAddress_mem,PC_mem,ALUResult_mem,dm_data_out,/*output*/WB_MemtoReg_wb,WB_RegWrite_wb,RegWriteAddress_wb,PC_wb,ALUResult_wb,MemOut_wb);
    
    /**
     * WB Stage
     */
    //Choose from the data (ALUResult, Memory, old_PC) to write to register
    //DatatoReg_mux datatoreg(WB_MemtoReg_wb,ALUResult_wb,MemOut_wb,PC_wb,/*output*/RegWriteData_wb);
    MuxOne_out_of_three datatoreg(ALUResult_wb,MemOut_wb,PC_wb+32'd4,WB_MemtoReg_wb,RegWriteData_wb);
endmodule
