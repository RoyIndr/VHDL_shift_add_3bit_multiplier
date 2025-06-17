library ieee; 
use ieee.std_logic_1164.all; 

entity proc_accu is 
    port(
        in_en       : in std_logic;
        in_clk      : in std_logic;
        in_reset    : in std_logic;
        in_d        : in std_logic_vector(2 downto 0);
        out_q       : out std_logic_vector(2 downto 0);
        out_accu_done : out std_logic
    );
end entity;

architecture rtl of proc_accu is
    signal s_data : std_logic_vector(2 downto 0) := (others => '0');
begin
    process(in_clk, in_reset)
    begin
        if in_reset = '1' then
            s_data  <= (others => '0');
            out_accu_done <= '0';
        elsif rising_edge(in_clk) then
            out_accu_done <= '0';
            if in_en = '1' then
                s_data  <= in_d;
                out_accu_done <= '1';
            end if;
        end if;
    end process;
    out_q <= s_data;    
end architecture;