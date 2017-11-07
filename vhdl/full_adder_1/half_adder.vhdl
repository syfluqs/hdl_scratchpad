-- half_adder.vhdl
-- author: roy
-- created: 2017-09-12

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (A,B: in std_logic;
     S,C: out std_logic);
end half_adder;

architecture behav of half_adder is
begin
S <= A xor B;
C <= A and B;
end behav;