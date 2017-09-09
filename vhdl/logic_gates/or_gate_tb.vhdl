library ieee;
use ieee.std_logic_1164.all;

entity or_gate_tb is
end or_gate_tb; 

architecture behavior of or_gate_tb is
component or_gate is
port (
    A,B: in std_logic; O: out std_logic);
end component;

signal input  : std_logic_vector(1 downto 0);
signal output  : std_logic_vector(0 downto 0);

begin test_subject: or_gate 
port map (
A => input(0),
B => input(1),
O => output(0));

stim_proc: process begin
	input <= "00"; wait for 10 ns;
	input <= "01"; wait for 10 ns;
	input <= "10"; wait for 10 ns;
	input <= "11"; wait for 10 ns;
report "or_gate testbench finished";
wait;
end process;
end;
