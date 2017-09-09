-- not_gate.vhdl.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity not_gate is
    port (A: in std_logic; O: out std_logic);
end not_gate;

architecture arch of not_gate is 
constant propagation_delay : time := 1 ns;
begin 
    O <= transport not A after propagation_delay;
end arch;