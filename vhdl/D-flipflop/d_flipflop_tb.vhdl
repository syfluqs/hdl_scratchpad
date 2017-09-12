library ieee;
use ieee.std_logic_1164.all;

entity d_flipflop_tb is
end d_flipflop_tb; 

architecture behavior of d_flipflop_tb is
component d_flipflop is
port (
    D, CLK: in std_logic; Q, Q_bar : out std_logic);
end component;

for test_subject: d_flipflop use entity work.d_flipflop(using_if);

signal input  : std_logic_vector(1 downto 0);
signal output  : std_logic_vector(1 downto 0);

begin test_subject: d_flipflop 
port map (
CLK => input(0),
D => input(1),
Q => output(0),
Q_bar => output(1));

stim_proc: process begin
	input <= "00"; wait for 10 ns;
	input <= "01"; wait for 10 ns;
    input <= "00"; wait for 10 ns;
    input <= "01"; wait for 10 ns;
	input <= "10"; wait for 10 ns;
	input <= "11"; wait for 10 ns;
    input <= "10"; wait for 10 ns;
    input <= "11"; wait for 10 ns;
report "d_flipflop testbench finished";
wait;
end process;
end;
