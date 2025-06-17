library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity proc_shifter is
  Port ( 
    in_clk      : in std_logic;
    in_reset    : in std_logic;
    in_msb      : in std_logic;    
    in_rec      : in std_logic;    
    in_load     : in std_logic;    
    in_shift    : in std_logic;    
    in_d1       : in std_logic_vector(2 downto 0);  
    in_d2       : in std_logic_vector(2 downto 0);  
    out_shift_done : out std_logic;
    out_q       : out std_logic_vector(5 downto 0);
    out_q0      : out std_logic                     
  );
end proc_shifter;

architecture Behavioral of proc_shifter is
    signal reg : std_logic_vector(5 downto 0) := (others => '0');
    signal s_shift_done : std_logic;
begin
    process(in_clk, in_reset)
    begin 
        if in_reset = '1' then
            reg <= (others => '0');  
        elsif rising_edge(in_clk) then
            s_shift_done <= '0';
            if in_load = '1' then 
                reg <= "000" & in_d2;  
            elsif in_rec = '1' then
                reg(5 downto 3) <= in_d1;
            elsif in_shift = '1' then
                reg <= in_msb & reg(5 downto 1);
                s_shift_done <= '1';
            end if;
        end if;
    end process;
    
    out_shift_done <= s_shift_done;
    out_q <= reg;        
    out_q0 <= reg(0);    
end Behavioral;