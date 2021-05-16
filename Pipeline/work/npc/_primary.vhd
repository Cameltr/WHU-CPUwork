library verilog;
use verilog.vl_types.all;
entity npc is
    port(
        IDRealRs        : in     vl_logic_vector(31 downto 0);
        oldPC           : in     vl_logic_vector(31 downto 0);
        id_pc           : in     vl_logic_vector(31 downto 0);
        Instr           : in     vl_logic_vector(31 downto 0);
        beq_zero        : in     vl_logic;
        PC_sel          : in     vl_logic_vector(1 downto 0);
        newPC           : out    vl_logic_vector(31 downto 0)
    );
end npc;
