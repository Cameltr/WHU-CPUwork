library verilog;
use verilog.vl_types.all;
entity dm is
    port(
        addr            : in     vl_logic_vector(31 downto 0);
        data_in         : in     vl_logic_vector(31 downto 0);
        MemWrite        : in     vl_logic;
        MemRead         : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end dm;
