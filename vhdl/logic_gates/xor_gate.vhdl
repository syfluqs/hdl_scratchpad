-- xor_gate.vhdl.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity xor_gate is
    port (A,B: in std_logic; O: out std_logic);
end xor_gate;

architecture behav of xor_gate is
constant propagation_delay: time := 1 ns;
begin
    O <= transport A xor B after propagation_delay;
end behav;



architecture structural of xor_gate is 
component and_gate is 
    port (A,B: in std_logic; O: out std_logic);
end component;

component or_gate is
    port (A,B: in std_logic; O: out std_logic);
end component;

component not_gate is
    port (A: in std_logic; O : out std_logic);
end component;

signal A_bar: std_logic;
signal B_bar: std_logic;
signal A_bar_B: std_logic;
signal B_bar_A: std_logic;

begin
X1: not_gate port map (A=>A, O=>A_bar);
X2: not_gate port map (A=>B, O=>B_bar);
X3: and_gate port map (A=>A_bar, B=>B, O=>A_bar_B);
X4: and_gate port map (A=>A, B=>B_bar, O=>B_bar_A);
X5: or_gate port map (A=>A_bar_B, B=>B_bar_A, O=>O);
end structural;

