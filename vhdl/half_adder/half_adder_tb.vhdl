library ieee;
use ieee.std_logic_1164.all;

entity half_adder_tb is
end half_adder_tb; 

architecture behavior of half_adder_tb is
component half_adder is 
port (
     A,B: in std_logic;S,C: out std_logic         );    
end component;

signal input  : std_logic_vector(1 downto 0);
signal output  : std_logic_vector(1 downto 0);

begin test_subject: half_adder 
port map (
A => input(0),
B => input(1),
S => output(0),
C => output(1));

stim_proc: process begin
	input <= "00"; wait for 10 ns;
	input <= "01"; wait for 10 ns;
	input <= "10"; wait for 10 ns;
	input <= "11"; wait for 10 ns;
report "half_adder testbench finished";
wait;
end process;
end;
