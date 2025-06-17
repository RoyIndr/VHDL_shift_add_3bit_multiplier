library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
  Port ( 
    in_clk          : in std_logic;
    in_reset        : in std_logic;
    in_start        : in std_logic;
    in_lsb          : in std_logic;
    in_cnt_done     : in std_logic;
    in_accu_done    : in std_logic;
    in_shift_done   : in std_logic;
    out_shift_en    : out std_logic;
    out_add_en      : out std_logic;
    out_clear_acc   : out std_logic;
    out_done        : out std_logic
    
  );
end control_unit;

architecture Behavioral of control_unit is
    type state_type is (IDLE, INIT, CHECK, ADD, WAIT_ADD, SHIFT, WAIT_SHIFT, FINISH);
    signal s_state : state_type := IDLE;
    
begin
    process(in_clk, in_reset)
    begin
        if in_reset = '1' then
            s_state <= IDLE;
            out_shift_en <= '0';
            out_add_en <= '0';
            out_clear_acc <= '0';
            out_done <= '0';
            
        elsif rising_edge(in_clk) then
            out_shift_en <= '0';
            out_add_en <= '0';
            out_clear_acc <= '0';
            out_done <= '0';
            
            case s_state is
                when IDLE =>
                    if in_start = '1' then
                        out_clear_acc <= '1';
                        s_state <= INIT;
                    end if;
                
                when INIT => 
                    s_state <= CHECK;
                
                when CHECK =>
                    if in_cnt_done = '1' then
                        s_state <= FINISH;
                    elsif in_lsb = '1' then
                        s_state <= ADD;
                    else
                        s_state <= SHIFT;
                    end if;
                
                when ADD =>
                    out_add_en <= '1';
                    
                    s_state <= WAIT_ADD;
                
                when WAIT_ADD => 
                    out_add_en <= '0';
                    if in_accu_done = '1' then
                        s_state <= SHIFT;
                    else 
                        s_state <= WAIT_ADD;
                    end if;
                                        
                when SHIFT => 
                    out_shift_en <= '1';
                    s_state <= WAIT_SHIFT;
                    
                when WAIT_SHIFT =>
                    --out_shift_en <= '1';
                    if in_shift_done = '1' then
                        s_state <= CHECK;
                    else 
                        s_state <= WAIT_SHIFT;
                    end if;
                
                when FINISH => 
                    out_done <= '1';
            end case;
        end if;
    end process;
end Behavioral;