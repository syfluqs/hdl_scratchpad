-- half_adder.vhdl
-- author: roy
-- created: 2017-09-12

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (A,B: in std_logic;
        S,C: out std_logic);
end half_adder;

architecture struc of half_adder is

component xor_gate is 
    port (A,B: in std_logic; O: out std_logic);
end component;
component and_gate is
    port (A,B: in std_logic; O: out std_logic);
end component;

for X1: xor_gate use entity work.xor_gate(behav);

begin
    X1: xor_gate port map(A,B,S);
    A1: and_gate port map(A,B,C);
end struc;