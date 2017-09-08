library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb; 

architecture behavior of full_adder_tb is
component full_adder is
port (
        a,b,c : in std_logic; s,co  : out std_logic);
end component;

signal input  : std_logic_vector(2 downto 0);
signal output  : std_logic_vector(1 downto 0);

begin test_subject: full_adder 
port map (
a => input(0),
b => input(1),
c => input(2),
s => output(0),
co => output(1));

stim_proc: process begin
	input <= "000"; wait for 10 ns;
	input <= "001"; wait for 10 ns;
	input <= "010"; wait for 10 ns;
	input <= "011"; wait for 10 ns;
	input <= "100"; wait for 10 ns;
	input <= "101"; wait for 10 ns;
	input <= "110"; wait for 10 ns;
	input <= "111"; wait for 10 ns;
report "full_adder testbench finished";
wait;
end process;
end;
