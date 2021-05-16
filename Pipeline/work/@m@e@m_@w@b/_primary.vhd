library verilog;
use verilog.vl_types.all;
entity MEM_WB is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        WB_MemtoReg_mem : in     vl_logic_vector(1 downto 0);
        WB_RegWrite_mem : in     vl_logic;
        RegWriteAddr_mem: in     vl_logic_vector(4 downto 0);
        PC_mem          : in     vl_logic_vector(31 downto 0);
        ALUResult_mem   : in     vl_logic_vector(31 downto 0);
        MemOut_mem      : in     vl_logic_vector(31 downto 0);
        WB_MemtoReg_wb  : out    vl_logic_vector(1 downto 0);
        WB_RegWrite_wb  : out    vl_logic;
        RegWriteAddr_wb : out    vl_logic_vector(4 downto 0);
        PC_wb           : out    vl_logic_vector(31 downto 0);
        ALUResult_wb    : out    vl_logic_vector(31 downto 0);
        MemOut_wb       : out    vl_logic_vector(31 downto 0)
    );
end MEM_WB;
