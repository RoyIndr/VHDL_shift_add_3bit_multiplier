library ieee;
use ieee.std_logic_1164.all;

entity proc_adder is
    port(
        in_a    : in std_logic_vector(2 downto 0);
        in_b    : in std_logic_vector(2 downto 0);
        in_c    : in std_logic;
        in_shift_done   : in std_logic;
        out_y   : out std_logic_vector(2 downto 0);
        out_c   : out std_logic
    );
end entity;

architecture structural of proc_adder is
    signal s_out            : std_logic_vector(3 downto 0) := (others => '0');
    signal s_c3, s_cout     : std_logic;
    signal s_c1, s_c2       : std_logic;
    
    component fullAdder
        port(
            in_a    : in std_logic;
            in_b    : in std_logic;
            in_c    : in std_logic;
            out_f   : out std_logic;
            out_c   : out std_logic 
        );
    end component;
      
begin
    -- bit 0
    fa0 : fullAdder
        port map(
            in_a => in_a(0),
            in_b => in_b(0),
            in_c => in_c,
            out_f => out_y(0),
            out_c => s_c1
        );  
        
    --bit 1
    fa1 : fullAdder
        port map(
            in_a => in_a(1),
            in_b => in_b(1),
            in_c => s_c1,
            out_f => out_y(1),
            out_c => s_c2
        );
        
    --bit 2
    fa2 : fullAdder
        port map(
            in_a => in_a(2),
            in_b => in_b(2),
            in_c => s_c2,
            out_f => out_y(2),
            out_c => out_c
        );  

end architecture;