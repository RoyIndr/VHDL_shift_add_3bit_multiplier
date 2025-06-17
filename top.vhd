library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  Port ( 
    in_clk      : in std_logic;
    in_reset    : in std_logic;
    in_start    : in std_logic;
    in_a        : in std_logic_vector(2 downto 0);
    in_b        : in std_logic_vector(2 downto 0);
    out_product : out std_logic_vector(5 downto 0);
    out_done    : out std_logic
  );
end top;

architecture Behavioral of top is
    signal s_shift_en, s_add_en, s_clear_acc, s_lsb, s_cnt_done, s_accu_done, s_shift_done : std_logic;
    signal s_product : std_logic_vector(5 downto 0);
begin
    CTRL: entity work.control_unit
        port map(
            in_clk       => in_clk,
            in_reset     => in_reset,
            in_start     => in_start,
            in_lsb       => s_lsb,
            in_cnt_done  => s_cnt_done,  
            out_shift_en  => s_shift_en,
            out_add_en    => s_add_en,
            out_clear_acc => s_clear_acc,
            out_done      => out_done,
            in_accu_done => s_accu_done,
            in_shift_done => s_shift_done
        );
    
    DP: entity work.data_processor
        port map(
            in_clk        => in_clk,
            in_resetProc  => in_reset,
            in_a          => in_a,
            in_b          => in_b,
            in_c          => '0',          
            out_f         => s_product,
            out_c         => open,         
            -- Control signals
            in_shift_en   => s_shift_en,
            in_add_en     => s_add_en,
            in_clear_acc  => s_clear_acc,
            out_lsb       => s_lsb,        
            out_cnt_done  => s_cnt_done,    
            out_accu_done => s_accu_done,
            out_shift_done => s_shift_done
        );
    
    out_product <= s_product;
end Behavioral;