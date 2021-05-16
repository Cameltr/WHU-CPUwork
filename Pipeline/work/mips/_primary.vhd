library verilog;
use verilog.vl_types.all;
entity mips is
    generic(
        RA_ADDRESS      : vl_logic_vector(0 to 4) := (Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RA_ADDRESS : constant is 1;
end mips;
