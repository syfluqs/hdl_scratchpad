-- no_of_ones_in_8bit_vector.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity main is
end main;

architecture arch of main is
constant length: integer := 10;
constant vec: bit_vector ((length-1) downto 0) := b"0011001100";
begin 
    process 
    variable count: integer:= 0;
    begin
        lab: for i in 0 to (length-1) loop
            if (vec(i) = '1') then
                count := count+1;
            end if;
        end loop;
        report "count="&integer'image(count);
        wait;
    end process;
end arch;