library ieee;
use ieee.std_logic_1164.all;

entity adder_tb is
end adder_tb; 

architecture behavior of adder_tb is
component adder is 
port (
     A,B: in std_logic_vector(3 downto 0); Cin: in std_logic;
     Sum: out std_logic_vector(3 downto 0); Cout: out std_logic);   
end component;

signal input_A : std_logic_vector(3 downto 0);
signal input_B : std_logic_vector(3 downto 0);
signal Cin: std_logic_vector(0 downto 0);
signal output : std_logic_vector(3 downto 0);
signal Cout : std_logic_vector(0 downto 0);

begin test_subject: adder 
port map (
A => input_A,
B => input_B,
Cin => Cin(0),
Sum => output(3 downto 0),
Cout => Cout(0));

stim_proc: process begin
	input_A <= 4d"1"; input_B <= 4d"0"; Cin <= "0"; wait for 10 ns;
    input_A <= 4d"5"; input_B <= 4d"2"; Cin <= "1"; wait for 10 ns;
    input_A <= 4d"3"; input_B <= 4d"2"; Cin <= "0"; wait for 10 ns;
report "adder testbench finished";
wait;
end process;
end;
