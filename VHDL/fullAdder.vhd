----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.06.2025 20:30:01
-- Design Name: 
-- Module Name: fullAdder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fullAdder is
  Port (
    in_a    : in std_logic;
    in_b    : in std_logic;
    in_c    : in std_logic;
    out_f   : out std_logic;
    out_c   : out std_logic 
  );
end fullAdder;

architecture rtl of fullAdder is

begin
    out_f <= in_a xor in_b xor in_c;
    out_c <= (in_a and in_b) or ((in_a xor in_b) and in_c);
end architecture;
