library verilog;
use verilog.vl_types.all;
entity HazardInspector is
    port(
        rst             : in     vl_logic;
        Branch          : in     vl_logic;
        Whether_jump    : in     vl_logic;
        RsAddr_id       : in     vl_logic_vector(4 downto 0);
        RtAddr_id       : in     vl_logic_vector(4 downto 0);
        RtAddr_ex       : in     vl_logic_vector(4 downto 0);
        MEM_MemRead_ex  : in     vl_logic;
        RegWriteAddr_ex : in     vl_logic_vector(4 downto 0);
        Keep_current_PC : out    vl_logic;
        IFIDWrite       : out    vl_logic;
        stall           : out    vl_logic;
        flush           : out    vl_logic
    );
end HazardInspector;
