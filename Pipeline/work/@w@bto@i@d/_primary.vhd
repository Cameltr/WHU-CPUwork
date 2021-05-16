library verilog;
use verilog.vl_types.all;
entity WBtoID is
    port(
        RsAddr_id       : in     vl_logic_vector(4 downto 0);
        RtAddr_id       : in     vl_logic_vector(4 downto 0);
        RegWriteAddr_wb : in     vl_logic_vector(4 downto 0);
        RegWrite_wb     : in     vl_logic;
        Rs_sel          : out    vl_logic;
        Rt_sel          : out    vl_logic
    );
end WBtoID;
