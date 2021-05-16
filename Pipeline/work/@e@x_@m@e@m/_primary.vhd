library verilog;
use verilog.vl_types.all;
entity EX_MEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        WB_MemtoReg_ex  : in     vl_logic_vector(1 downto 0);
        WB_RegWrite_ex  : in     vl_logic;
        MEM_MemWrite_ex : in     vl_logic;
        MEM_MemRead_ex  : in     vl_logic;
        RegWriteAddr_ex : in     vl_logic_vector(4 downto 0);
        PC_ex           : in     vl_logic_vector(31 downto 0);
        ALUResult_ex    : in     vl_logic_vector(31 downto 0);
        MemWriteData_ex : in     vl_logic_vector(31 downto 0);
        WB_MemtoReg_mem : out    vl_logic_vector(1 downto 0);
        WB_RegWrite_mem : out    vl_logic;
        MEM_MemWrite_mem: out    vl_logic;
        MEM_MemRead_mem : out    vl_logic;
        RegWriteAddr_mem: out    vl_logic_vector(4 downto 0);
        PC_mem          : out    vl_logic_vector(31 downto 0);
        ALUResult_mem   : out    vl_logic_vector(31 downto 0);
        MemWriteData_mem: out    vl_logic_vector(31 downto 0)
    );
end EX_MEM;
