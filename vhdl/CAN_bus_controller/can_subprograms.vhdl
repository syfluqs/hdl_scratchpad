-- can_subprograms.vhdl
-- author: roy
-- created: 2017-11-13
-- description : Globally shared subprograms

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

package can_subprograms is
    
    --crc type
    subtype crc_t is std_logic_vector(7 downto 0);

    -- calc_crc
    function calc_crc(constant in_stream: in std_logic_vector(data_length-1 downto 0)) 
    return crc_t;

    -- utility functions
    function to_string ( a: std_logic_vector) return string;
    
end can_subprograms;

package body can_subprograms is
    function calc_crc(constant in_stream: in std_logic_vector(data_length-1 downto 0)) 
    return crc_t is
        variable count: integer:=0;
        variable crc_temp: std_logic_vector(7 downto 0):=(others => '0');
    begin 
        while count < data_length+7 loop
            if (count < data_length) then
                crc_temp(0) := in_stream(count) xor crc_temp(7);
            else 
                crc_temp(0) := '0' xor crc_temp(7);
            end if;
            crc_temp(1) := crc_temp(0) xor crc_temp(7);
            crc_temp(2) := crc_temp(1) xor crc_temp(7);
            crc_temp(7 downto 3) := crc_temp(6 downto 2);
            count := count + 1;
        end loop;
        return crc_temp;
    end;


    function to_string ( a: std_logic_vector) return string is
    variable b : string (1 to a'length) := (others => NUL);
    variable stri : integer := 1; 
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
        stri := stri+1;
        end loop;
    return b;
    end function;
end can_subprograms; 