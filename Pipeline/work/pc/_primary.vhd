library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        newpc           : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        Keep_current_PC : in     vl_logic;
        oldpc           : out    vl_logic_vector(31 downto 0)
    );
end pc;
