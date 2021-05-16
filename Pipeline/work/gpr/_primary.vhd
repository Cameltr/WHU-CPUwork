library verilog;
use verilog.vl_types.all;
entity gpr is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        rs              : in     vl_logic_vector(4 downto 0);
        rt              : in     vl_logic_vector(4 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        wd              : in     vl_logic_vector(31 downto 0);
        we              : in     vl_logic;
        outa            : out    vl_logic_vector(31 downto 0);
        outb            : out    vl_logic_vector(31 downto 0)
    );
end gpr;
