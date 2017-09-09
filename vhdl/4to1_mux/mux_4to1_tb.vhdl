library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1_tb is
end mux_4to1_tb; 

architecture behavior of mux_4to1_tb is
component mux_4to1 is
port (
    A,B,C,D,S0,S1: in std_logic; Y: out std_logic);
end component;

for test_subject: mux_4to1 use entity work.mux_4to1(case_stmt);

signal input  : std_logic_vector(5 downto 0);
signal output  : std_logic_vector(0 downto 0);

begin test_subject: mux_4to1 
port map (
A => input(0),
B => input(1),
C => input(2),
D => input(3),
S0 => input(4),
S1 => input(5),
Y => output(0));

stim_proc: process begin
	input <= "000000"; wait for 10 ns;
	input <= "000001"; wait for 10 ns;
	input <= "000010"; wait for 10 ns;
	input <= "000011"; wait for 10 ns;
	input <= "000100"; wait for 10 ns;
	input <= "000101"; wait for 10 ns;
	input <= "000110"; wait for 10 ns;
	input <= "000111"; wait for 10 ns;
	input <= "001000"; wait for 10 ns;
	input <= "001001"; wait for 10 ns;
	input <= "001010"; wait for 10 ns;
	input <= "001011"; wait for 10 ns;
	input <= "001100"; wait for 10 ns;
	input <= "001101"; wait for 10 ns;
	input <= "001110"; wait for 10 ns;
	input <= "001111"; wait for 10 ns;
	input <= "010000"; wait for 10 ns;
	input <= "010001"; wait for 10 ns;
	input <= "010010"; wait for 10 ns;
	input <= "010011"; wait for 10 ns;
	input <= "010100"; wait for 10 ns;
	input <= "010101"; wait for 10 ns;
	input <= "010110"; wait for 10 ns;
	input <= "010111"; wait for 10 ns;
	input <= "011000"; wait for 10 ns;
	input <= "011001"; wait for 10 ns;
	input <= "011010"; wait for 10 ns;
	input <= "011011"; wait for 10 ns;
	input <= "011100"; wait for 10 ns;
	input <= "011101"; wait for 10 ns;
	input <= "011110"; wait for 10 ns;
	input <= "011111"; wait for 10 ns;
	input <= "100000"; wait for 10 ns;
	input <= "100001"; wait for 10 ns;
	input <= "100010"; wait for 10 ns;
	input <= "100011"; wait for 10 ns;
	input <= "100100"; wait for 10 ns;
	input <= "100101"; wait for 10 ns;
	input <= "100110"; wait for 10 ns;
	input <= "100111"; wait for 10 ns;
	input <= "101000"; wait for 10 ns;
	input <= "101001"; wait for 10 ns;
	input <= "101010"; wait for 10 ns;
	input <= "101011"; wait for 10 ns;
	input <= "101100"; wait for 10 ns;
	input <= "101101"; wait for 10 ns;
	input <= "101110"; wait for 10 ns;
	input <= "101111"; wait for 10 ns;
	input <= "110000"; wait for 10 ns;
	input <= "110001"; wait for 10 ns;
	input <= "110010"; wait for 10 ns;
	input <= "110011"; wait for 10 ns;
	input <= "110100"; wait for 10 ns;
	input <= "110101"; wait for 10 ns;
	input <= "110110"; wait for 10 ns;
	input <= "110111"; wait for 10 ns;
	input <= "111000"; wait for 10 ns;
	input <= "111001"; wait for 10 ns;
	input <= "111010"; wait for 10 ns;
	input <= "111011"; wait for 10 ns;
	input <= "111100"; wait for 10 ns;
	input <= "111101"; wait for 10 ns;
	input <= "111110"; wait for 10 ns;
	input <= "111111"; wait for 10 ns;
report "mux_4to1 testbench finished";
wait;
end process;
end;
