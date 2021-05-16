library verilog;
use verilog.vl_types.all;
entity ZeroTest is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        ALUOp           : in     vl_logic_vector(4 downto 0);
        zero            : out    vl_logic
    );
end ZeroTest;
