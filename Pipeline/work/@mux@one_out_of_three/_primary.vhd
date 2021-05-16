library verilog;
use verilog.vl_types.all;
entity MuxOne_out_of_three is
    port(
        data1           : in     vl_logic_vector(31 downto 0);
        data2           : in     vl_logic_vector(31 downto 0);
        data3           : in     vl_logic_vector(31 downto 0);
        control         : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end MuxOne_out_of_three;
