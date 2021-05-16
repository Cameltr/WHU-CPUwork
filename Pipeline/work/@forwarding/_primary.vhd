library verilog;
use verilog.vl_types.all;
entity Forwarding is
    port(
        RegWrite_mem    : in     vl_logic;
        RegWrite_wb     : in     vl_logic;
        RegWrite_ex     : in     vl_logic;
        RegWriteAddr_mem: in     vl_logic_vector(4 downto 0);
        RegWriteAddr_wb : in     vl_logic_vector(4 downto 0);
        RegWriteAddr_ex : in     vl_logic_vector(4 downto 0);
        RsAddr_ex       : in     vl_logic_vector(4 downto 0);
        RtAddr_ex       : in     vl_logic_vector(4 downto 0);
        RsAddr_id       : in     vl_logic_vector(4 downto 0);
        RtAddr_id       : in     vl_logic_vector(4 downto 0);
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0);
        ForwardC        : out    vl_logic_vector(1 downto 0);
        ForwardD        : out    vl_logic_vector(1 downto 0)
    );
end Forwarding;
