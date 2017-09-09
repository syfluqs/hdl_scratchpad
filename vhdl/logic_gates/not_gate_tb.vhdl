library ieee;
use ieee.std_logic_1164.all;

entity not_gate_tb is
end not_gate_tb; 

architecture behavior of not_gate_tb is
component not_gate is
port (
    A: in std_logic; O: out std_logic);
end component;

signal input  : std_logic_vector(0 downto 0);
signal output  : std_logic_vector(0 downto 0);

begin test_subject: not_gate 
port map (
A => input(0),
O => output(0));

stim_proc: process begin
	input <= "0"; wait for 10 ns;
	input <= "1"; wait for 10 ns;
report "not_gate testbench finished";
wait;
end process;
end;
