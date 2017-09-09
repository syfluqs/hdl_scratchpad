-- or_gate.vhdl.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity or_gate is
    port(A,B: in std_logic; O: out std_logic);
end or_gate;

architecture arch of or_gate is
constant propagation_delay: time := 1 ns;
begin 
    O <= transport A or B after propagation_delay;
end arch;