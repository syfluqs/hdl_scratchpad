--$> make import half_adder.vhdl full_adder.vhdl

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        a,b,c : in std_logic; s,co  : out std_logic);
end;

architecture behavioral of full_adder is
begin
    s <= a xor b xor c;
    co <= (a and b) or ((a xor b) and c);
end behavioral; 