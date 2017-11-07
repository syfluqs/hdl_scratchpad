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

architecture structural of full_adder is
    component half_adder is 
        port (A,B: in std_logic; S,C: out std_logic);
    end component;
    signal s1,c1,c2: std_logic;
    begin 
        ha1: half_adder port map(a,b,s1,c1);
        ha2: half_adder port map(s1,c,s,c2);
        co <= c1 or c2;
    end structural;