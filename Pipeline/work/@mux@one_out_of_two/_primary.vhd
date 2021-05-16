library verilog;
use verilog.vl_types.all;
entity MuxOne_out_of_two is
    port(
        control         : in     vl_logic;
        data1           : in     vl_logic_vector(31 downto 0);
        data2           : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end MuxOne_out_of_two;
