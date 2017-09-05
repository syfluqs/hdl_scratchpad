library ieee;
use ieee.std_logic_1164.all;

entity rem_mod is
end rem_mod;

architecture rem_mod_arc of rem_mod is    
signal A: integer := 0; 
begin
    p1 : process
    begin
        -- A rem B = A - (A/B)*B
        -- similar to % operator in C
        -- sign of answer is same as that of first operand
        A <= 5 rem (-3);
        wait for 10 ns;
        report "5 rem -3="&integer'image(A);

        -- A mod B = A - B*N
        -- minimise the value of A - B*N
        -- analogous to mod-n counter
        A <= 5 mod (-3);
        wait for 10 ns;
        report "5 mod -3="&integer'image(A);
        wait;
    end process ; -- p1
end rem_mod_arc;