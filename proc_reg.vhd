library ieee;
use ieee.std_logic_1164.all;

entity proc_reg is
    port (
        in_load     : in std_logic;
        in_clk      : in std_logic;
        in_reset    : in std_logic;
        in_d        : in std_logic_vector(2 downto 0);
        out_q       : out std_logic_vector(2 downto 0)
    );
end entity;

architecture rtl of proc_reg is
    signal s_q : std_logic_vector(2 downto 0);
begin
    process(in_clk, in_reset)
    begin   
        if in_reset = '1' then
            s_q <= (others => '0');
        elsif rising_edge(in_clk) then
            if in_load = '1' then
                s_q <= in_d;
            end if;
        end if;
    end process;
    
    out_q <= s_q;
end architecture;