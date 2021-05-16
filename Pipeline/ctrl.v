`include "E:/Pipelinecpu/ctrl_encode_def.v"
`include "E:/Pipelinecpu/instruction_def.v"

module ctrl(
    input [5:0] opcode,
    input [5:0] func,

    output reg [1:0] RegDst,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg MemRead,
    output reg RegWrite,
    output reg MemWrite,
    output reg [1:0] DatatoReg,
    output reg [1:0] PC_sel,
    output reg ExtOp,
    output reg [4:0] ALUCtrl,
    output reg Jump
);

	always @(opcode or func ) begin
		case(opcode)
		`INSTR_RTYPE_OP:
            begin
                RegDst <= 2'b01;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                MemRead <= 0;
                RegWrite <= 1;
                MemWrite <= 0;
                DatatoReg <= 2'b00;
                PC_sel <= 2'b00;
                ExtOp <= 0;
                Jump <= 0;
				case(func)
				`INSTR_ADDU_FUNCT:
					ALUCtrl <= `ALUOp_ADDU;
				`INSTR_SUBU_FUNCT:
					ALUCtrl <= `ALUOp_SUBU;
                `INSTR_ADD_FUNCT:
                    ALUCtrl <= `ALUOp_ADDU;
                `INSTR_SUB_FUNCT:
                    ALUCtrl <= `ALUOp_SUBU;
                `INSTR_AND_FUNCT:
                    ALUCtrl <= `ALUOp_AND;
                `INSTR_OR_FUNCT:
                    ALUCtrl <= `ALUOp_OR;
                `INSTR_SLT_FUNCT:
                    ALUCtrl <= `ALUOp_SLT;
                `INSTR_SLL_FUNCT:
                    begin
                    ALUSrcA <= 1;
                    ALUCtrl <= `ALUOp_SLL;
                    end
                `INSTR_SRL_FUNCT:
                    begin
                        ALUSrcA <= 1;
                        ALUCtrl <= `ALUOp_SRL;
                    end
                `INSTR_SRA_FUNCT:
                    begin
                        ALUSrcA <= 1;
                        ALUCtrl <= `ALUOp_SRA;
                    end
                `INSTR_JR_FUNCT:
                    begin
                        PC_sel <= 2'b11;
                        RegWrite <= 0;
						ALUCtrl <= `ALUOp_ADD;
                        Jump <= 1;
                    end
				endcase
            end
			
            //lui
            `INSTR_LUI_OP:
            begin
                RegDst <= 2'b00;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                MemWrite <= 1'b0;
                DatatoReg <= 2'b00;
                PC_sel <= 2'b00;
                ExtOp <= 0;
                ALUCtrl <= `ALUOp_LUI;
                Jump <= 0;
            end
            
            //addi
            `INSTR_ADDI_OP:	  
            begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 1;
				MemRead <= 0;
				RegWrite <= 1;
				MemWrite <= 0;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b00;
				ExtOp <= 1;
				ALUCtrl <= `ALUOp_ADD;
                Jump <= 0;
            end
            
            //ori
			`INSTR_ORI_OP:
			begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 1;
				MemRead <= 0;
				RegWrite <= 1;
				MemWrite <= 0;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b00;
				ExtOp <= 0;
				ALUCtrl <= `ALUOp_OR;
                Jump <= 0;
			end

			//slti
			`INSTR_SLTI_OP:
			begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 1;
				MemRead <= 0;
				RegWrite <= 1;
				MemWrite <= 0;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b00;
				ExtOp <= 1;//EXT_SIGNED
				ALUCtrl <= `ALUOp_SLT;//
                Jump <= 0;
			end

            //sw
            `INSTR_SW_OP:
            begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 1;
				MemRead <= 0;
				RegWrite <= 0;
				MemWrite <= 1;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b00;
				ExtOp <= 1;
				ALUCtrl <= `ALUOp_ADD;
                Jump <= 0;
            end

            //lw
            `INSTR_LW_OP:
            begin
				RegDst <= 2'b00;
				ALUSrcB <= 1;
                ALUSrcA <= 0;
				MemRead <= 1;
				RegWrite <= 1;
				MemWrite <= 0;
				DatatoReg <= 2'b01;
				PC_sel <= 2'b00;
				ExtOp <= 1;
				ALUCtrl <= `ALUOp_ADD;
                Jump <= 0;
            end

			//beq 
			`INSTR_BEQ_OP:  
			begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 0;
				MemRead <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b01;
				ExtOp <= 1;
				ALUCtrl <= `ALUOp_EQL;
                Jump <= 0;
			end
            
			//bne
			`INSTR_BNE_OP:  
			begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 0;
				MemRead <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b01;
				ExtOp <= 1;
				ALUCtrl <= `ALUOp_BNE;
                Jump <= 0;
			end
            
			//j
			`INSTR_J_OP:  
			begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 0;
				MemRead <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b10;
				ExtOp <= 0;
				ALUCtrl <= `ALUOp_ADD;
                Jump <= 1;
			end

			//jal
			`INSTR_JAL_OP:  
			begin
				RegDst <= 2'b10;
                ALUSrcA <= 0;
				ALUSrcB <= 0;
				MemRead <= 0;
				RegWrite <= 1;
				MemWrite <= 0;
				DatatoReg <= 2'b10;
				PC_sel <= 2'b10;
				ExtOp <= 0;
				ALUCtrl <= `ALUOp_ADD;
                Jump <= 1;
			end

		default:  
			begin
				RegDst <= 2'b00;
                ALUSrcA <= 0;
				ALUSrcB <= 0;
				MemRead <= 0;
				RegWrite <= 0;
				MemWrite <= 0;
				DatatoReg <= 2'b00;
				PC_sel <= 2'b00;
				ExtOp <= 0;
				ALUCtrl <= 5'b000;
                Jump <= 0;
			end

		endcase
	 end
	 

endmodule
