library verilog;
use verilog.vl_types.all;
entity ID_EX is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stall           : in     vl_logic;
        WB_MemtoReg_id  : in     vl_logic_vector(1 downto 0);
        WB_RegWrite_id  : in     vl_logic;
        MEM_MemWrite_id : in     vl_logic;
        MEM_MemRead_id  : in     vl_logic;
        EX_ALUCode_id   : in     vl_logic_vector(4 downto 0);
        EX_ALUSrcA_id   : in     vl_logic;
        EX_ALUSrcB_id   : in     vl_logic;
        EX_RegDst_id    : in     vl_logic_vector(1 downto 0);
        RsAddr_id       : in     vl_logic_vector(4 downto 0);
        RtAddr_id       : in     vl_logic_vector(4 downto 0);
        RdAddr_id       : in     vl_logic_vector(4 downto 0);
        PC_id           : in     vl_logic_vector(31 downto 0);
        Imm_id          : in     vl_logic_vector(31 downto 0);
        RsData_id       : in     vl_logic_vector(31 downto 0);
        RtData_id       : in     vl_logic_vector(31 downto 0);
        WB_MemtoReg_ex  : out    vl_logic_vector(1 downto 0);
        WB_RegWrite_ex  : out    vl_logic;
        MEM_MemWrite_ex : out    vl_logic;
        MEM_MemRead_ex  : out    vl_logic;
        EX_ALUCode_ex   : out    vl_logic_vector(4 downto 0);
        EX_ALUSrcA_ex   : out    vl_logic;
        EX_ALUSrcB_ex   : out    vl_logic;
        EX_RegDst_ex    : out    vl_logic_vector(1 downto 0);
        RsAddr_ex       : out    vl_logic_vector(4 downto 0);
        RtAddr_ex       : out    vl_logic_vector(4 downto 0);
        RdAddr_ex       : out    vl_logic_vector(4 downto 0);
        PC_ex           : out    vl_logic_vector(31 downto 0);
        Imm_ex          : out    vl_logic_vector(31 downto 0);
        RsData_ex       : out    vl_logic_vector(31 downto 0);
        RtData_ex       : out    vl_logic_vector(31 downto 0)
    );
end ID_EX;
