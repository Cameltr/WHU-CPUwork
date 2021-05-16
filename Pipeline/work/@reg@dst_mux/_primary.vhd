library verilog;
use verilog.vl_types.all;
entity RegDst_mux is
    port(
        RegDst          : in     vl_logic_vector(1 downto 0);
        RtAddr          : in     vl_logic_vector(4 downto 0);
        RdAddr          : in     vl_logic_vector(4 downto 0);
        RegWriteAddr    : out    vl_logic_vector(4 downto 0)
    );
end RegDst_mux;
