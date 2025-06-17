library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_processor is
  Port ( 
    in_a            : in std_logic_vector(2 downto 0);
    in_b            : in std_logic_vector(2 downto 0);
    in_c            : in std_logic;
    out_f           : out std_logic_vector(5 downto 0);
    out_c           : out std_logic;
    in_clk          : in std_logic;
    in_resetProc    : in std_logic;
    in_shift_en     : in std_logic;
    in_add_en       : in std_logic;
    in_clear_acc    : in std_logic;
    out_lsb         : out std_logic;
    out_cnt_done    : out std_logic;
    out_accu_done   : out std_logic;
    out_shift_done  : out std_logic
  );
end data_processor;

architecture Behavioral of data_processor is

    component proc_adder is
        port(
            in_a    : in std_logic_vector(2 downto 0);
            in_b    : in std_logic_vector(2 downto 0);
            in_c    : in std_logic;
            in_shift_done : in std_logic;
            out_y   : out std_logic_vector(2 downto 0);
            out_c   : out std_logic
        );
    end component;
    
    component proc_counter is
        port (
            in_en       : in std_logic;
            in_clk      : in std_logic;
            in_reset    : in std_logic;
            out_cnt_done: out std_logic;
            out_q       : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component proc_reg is 
        port (
            in_load     : in std_logic;
            in_clk      : in std_logic;
            in_reset    : in std_logic;
            in_d        : in std_logic_vector(2 downto 0);
            out_q       : out std_logic_vector(2 downto 0)
        );
    end component;
    
    component proc_accu is
        port(
            in_en       : in std_logic;
            in_clk      : in std_logic;
            in_reset    : in std_logic;
            in_d        : in std_logic_vector(2 downto 0);
            out_q       : out std_logic_vector(2 downto 0);
            out_accu_done : out std_logic
        );
    end component;
    
    component proc_shifter is
        port(
            in_clk   : in std_logic;
            in_reset : in std_logic;
            in_msb   : in std_logic;
            in_rec   : in std_logic;
            in_load  : in std_logic;
            in_shift : in std_logic;
            in_d1    : in std_logic_vector(2 downto 0);
            in_d2    : in std_logic_vector(2 downto 0);
            out_q    : out std_logic_vector(5 downto 0);
            out_q0   : out std_logic; 
            out_shift_done : out std_logic
        );
    end component;
    
    -- Internal signals
    signal s_multiplicand   : std_logic_vector(2 downto 0);
    signal s_accumulator    : std_logic_vector(2 downto 0);
    signal s_adder_out      : std_logic_vector(2 downto 0);
    signal s_adder_carry    : std_logic;
    signal s_count          : std_logic_vector(3 downto 0);
    signal s_cnt_done       : std_logic;
    signal s_acc_reset      : std_logic;
    signal s_product        : std_logic_vector(5 downto 0);
    signal s_lsb            : std_logic;
    signal s_accu_done      : std_logic;
    signal s_shift_done     : std_logic;
    signal s_carry_reg      : std_logic;
    
begin

    process(in_clk, in_resetProc)
    begin
        if in_resetProc = '1' then
            s_carry_reg <= '0';
        elsif rising_edge(in_clk) then
            if in_add_en = '1' then
                s_carry_reg <= s_adder_carry;  
            elsif in_shift_en = '1' then
                s_carry_reg <= '0';  
            end if;
        end if;
    end process;
    
    -- Reset control for accumulator
    s_acc_reset <= in_resetProc or in_clear_acc;
    
    -- Counter for iterations
    counter : proc_counter
        port map(
            in_en => in_shift_en,
            in_clk => in_clk,
            in_reset => in_resetProc,
            out_cnt_done => s_cnt_done,
            out_q => s_count
        );
    
    -- Multiplicand register (stores A)
    multiplicand_reg : proc_reg
        port map(
            in_load => in_clear_acc,
            in_clk => in_clk,
            in_reset => in_resetProc,
            in_d => in_a,
            out_q => s_multiplicand
        );
    
    shifter : proc_shifter
        port map(
            in_clk => in_clk,
            in_reset => in_resetProc,
            in_msb => s_carry_reg,
            in_rec => s_accu_done,
            in_load => in_clear_acc,
            in_shift => in_shift_en,
            in_d1 => s_accumulator,
            in_d2 => in_b,
            out_q => s_product,
            out_q0 => s_lsb,
            out_shift_done => s_shift_done
        );
    
    -- 3-bit adder
    adder : proc_adder
        port map(
            in_a => s_multiplicand,
            in_b => s_product(5 downto 3),
            in_c => '0',
            in_shift_done => s_shift_done,
            out_y => s_adder_out,
            out_c => s_adder_carry
        );
    
    -- Accumulator
    accumulator : proc_accu
        port map(
            in_en => in_add_en,
            in_clk => in_clk,
            in_reset => s_acc_reset,
            in_d => s_adder_out,
            out_q => s_accumulator,
            out_accu_done => s_accu_done
        );
        
    -- Output assignments
    out_shift_done <= s_shift_done;
    out_accu_done <= s_accu_done;
    out_lsb <= s_lsb;
    out_f <= s_product;
    out_c <= s_adder_carry;
    out_cnt_done <= s_cnt_done;
    
end Behavioral;