library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proc_counter is
    port (
        in_en       : in std_logic;
        in_clk      : in std_logic;
        in_reset    : in std_logic;
        out_cnt_done: out std_logic;
        out_q       : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behavioral of proc_counter is
    signal s_count : unsigned(3 downto 0) := (others => '0');
begin
    process(in_clk, in_reset)
    begin
        if in_reset = '1' then
            s_count <= (others => '0');
        elsif rising_edge(in_clk) then
            
            if in_en = '1' then
                if s_count < 3 then  
                    s_count <= s_count + 1;
                else
                    s_count <= (others => '0');
                end if;
            end if;
        end if;
     end process;
     
     out_cnt_done <= '1' when s_count = 3 else '0';
     out_q <= std_logic_vector(s_count);
end architecture;