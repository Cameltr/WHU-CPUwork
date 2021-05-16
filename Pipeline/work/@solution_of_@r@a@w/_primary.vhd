library verilog;
use verilog.vl_types.all;
entity Solution_of_RAW is
    port(
        RsAddr_id       : in     vl_logic_vector(4 downto 0);
        RtAddr_id       : in     vl_logic_vector(4 downto 0);
        RegWriteAddr_wb : in     vl_logic_vector(4 downto 0);
        RegWrite_wb     : in     vl_logic;
        Rs_selection    : out    vl_logic;
        Rt_selection    : out    vl_logic
    );
end Solution_of_RAW;
