-- logic_gates.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity and_gate is
    port (
        A,B: in std_logic;
        O: out std_logic);
end and_gate;

architecture arch of and_gate is
constant propagation_delay: time := 1 ns;
begin
    O <= transport A and B after propagation_delay;
end;