-- add_elements_in_arr.vhdl
-- author: roy
-- created: 2017-09-11

library ieee;
use ieee.std_logic_1164.all;


entity array_add is
end array_add;

architecture arch of array_add is
    type my_arr_t is array (1 to 10) of integer;
    constant my_arr: my_arr_t := (1,2,3,4,5,6,7,8,9,0);
begin 
process
    variable sum: integer := 0;
begin
    for i in 1 to 10 loop
        sum:=sum+my_arr(i);
        exit when sum>100;
    end loop;
    report "sum="&integer'image(sum);
    wait;
end process;
end arch;