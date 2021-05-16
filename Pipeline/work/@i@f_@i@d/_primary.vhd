library verilog;
use verilog.vl_types.all;
entity IF_ID is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        flush           : in     vl_logic;
        IF_ID_keep      : in     vl_logic;
        PC_if           : in     vl_logic_vector(31 downto 0);
        Inst_if         : in     vl_logic_vector(31 downto 0);
        PC_id           : out    vl_logic_vector(31 downto 0);
        Inst_id         : out    vl_logic_vector(31 downto 0)
    );
end IF_ID;
