library verilog;
use verilog.vl_types.all;
entity DatatoReg_mux is
    port(
        DatatoReg       : in     vl_logic_vector(1 downto 0);
        ALU_data        : in     vl_logic_vector(31 downto 0);
        Mem_data        : in     vl_logic_vector(31 downto 0);
        oldPc           : in     vl_logic_vector(31 downto 0);
        DatatoReg_out   : out    vl_logic_vector(31 downto 0)
    );
end DatatoReg_mux;
