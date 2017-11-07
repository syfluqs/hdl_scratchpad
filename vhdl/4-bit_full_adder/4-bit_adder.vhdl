-- 4-bit_full_adder.vhdl
-- author: roy
-- created: 2017-09-26

library ieee;
use ieee.std_logic_1164.all;


entity adder is
    port (A,B: in std_logic_vector(3 downto 0); Cin: in std_logic;
        Sum: out std_logic_vector(3 downto 0); Cout: out std_logic);
end adder;

architecture struc of adder is

    component full_adder is
    port (
            a,b,c : in std_logic; s,co  : out std_logic);
    end component;

    signal C: std_logic_vector(4 downto 0);
begin
    gen: for i in 0 to 3 generate
    begin
        fa : full_adder port map (A(i),B(i),C(i),Sum(i),C(i+1));
    end generate;
    C(0) <= Cin;
    Cout <= C(4);
end struc;