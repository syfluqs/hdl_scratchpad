library ieee;
use ieee.std_logic_1164.all;

entity prime_tb is
end prime_tb; 

architecture behavior of prime_tb is
component prime is
port (
    B0, B1, B2, B3: in std_logic; is_prime : out std_logic);
end component;

signal input  : std_logic_vector(3 downto 0);
signal output  : std_logic_vector(0 downto 0);

begin test_subject: prime 
port map (
B0 => input(0),
B1 => input(1),
B2 => input(2),
B3 => input(3),
is_prime => output(0));

stim_proc: process begin
	input <= "0000"; wait for 10 ns;
	input <= "0001"; wait for 10 ns;
	input <= "0010"; wait for 10 ns;
	input <= "0011"; wait for 10 ns;
	input <= "0100"; wait for 10 ns;
	input <= "0101"; wait for 10 ns;
	input <= "0110"; wait for 10 ns;
	input <= "0111"; wait for 10 ns;
	input <= "1000"; wait for 10 ns;
	input <= "1001"; wait for 10 ns;
	input <= "1010"; wait for 10 ns;
	input <= "1011"; wait for 10 ns;
	input <= "1100"; wait for 10 ns;
	input <= "1101"; wait for 10 ns;
	input <= "1110"; wait for 10 ns;
	input <= "1111"; wait for 10 ns;
report "prime testbench finished";
wait;
end process;
end;
