-- xor_gate.vhdl.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity xor_gate is
    port (A,B: in std_logic; O: out std_logic);
end xor_gate;

architecture behav of xor_gate is
constant propagation_delay: time := 0.5 ns;
begin
    O <= transport A xor B after propagation_delay;
end behav;