library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component top
        Port ( 
            in_clk      : in std_logic;
            in_reset    : in std_logic;
            in_start    : in std_logic;
            in_a        : in std_logic_vector(2 downto 0);
            in_b        : in std_logic_vector(2 downto 0);
            out_product : out std_logic_vector(5 downto 0);
            out_done    : out std_logic
        );
    end component;
    
    signal in_clk      : std_logic := '0';
    signal in_reset    : std_logic := '1';
    signal in_start    : std_logic := '0';
    signal in_a        : std_logic_vector(2 downto 0) := (others => '0');
    signal in_b        : std_logic_vector(2 downto 0) := (others => '0');
    signal out_product : std_logic_vector(5 downto 0);
    signal out_done    : std_logic;

    constant clk_period : time := 10 ns;
    
begin
    -- Clock generation
    clk_process : process
    begin
        while true loop
            in_clk <= '0';
            wait for clk_period/2;
            in_clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Instantiate the Unit Under Test (UUT)
    uut: top
        port map (
            in_clk      => in_clk,
            in_reset    => in_reset,
            in_start    => in_start,
            in_a        => in_a,
            in_b        => in_b,
            out_product => out_product,
            out_done    => out_done
        );
 
    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        wait for 20 ns;
        in_reset <= '0';
        wait for 20 ns;
        
        report "Starting Test 1: 3 x 5";
        
        -- Test Case 
        in_a <= "111";  -- 7
        in_b <= "111";  -- 5

        -- Start the multiplication
        wait until rising_edge(in_clk);
        in_start <= '1';
        wait until rising_edge(in_clk);
        in_start <= '0';

        -- Wait for operation to complete (with timeout)
        wait until out_done = '1' for 500 ns;
        
        if out_done = '1' then
            report "Test 1 Result: " & integer'image(to_integer(unsigned(out_product))) & 
                   " (Expected: 15)";
        else
            report "Test 1 TIMEOUT!" severity error;
        end if;

    end process;

end Behavioral;