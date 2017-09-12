library ieee;
use ieee.std_logic_1164.all;

entity d_ff_tb is
end d_ff_tb; 

architecture behavior of d_ff_tb is
component d_ff is
port (
    CLK,D,RESET: in std_logic; Q,Q_bar: out std_logic);
end component;

signal input  : std_logic_vector(2 downto 0);
signal output  : std_logic_vector(1 downto 0);

begin test_subject: d_ff 
port map (
CLK => input(0),
D => input(1),
RESET => input(2),
Q => output(0),
Q_bar => output(1));

stim_proc: process begin
	input <= "000"; wait for 10 ns;
	input <= "001"; wait for 10 ns;
	input <= "010"; wait for 10 ns;
	input <= "011"; wait for 10 ns;
	input <= "100"; wait for 10 ns;
	input <= "101"; wait for 10 ns;
	input <= "110"; wait for 10 ns;
	input <= "111"; wait for 10 ns;
report "d_ff testbench finished";
wait;
end process;
end;
