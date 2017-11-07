-- ram_32x4.vhdl
-- author: roy
-- created: 2017-10-31

-- construct a ram of 32x4 binary storage cells, associated for selecting individual words
-- write its vhdl code.

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity ram_32x4 is
    port (addr_bus: in std_logic_vector(4 downto 0); clk, rw: in std_logic; data: inout std_logic_vector(3 downto 0));
end ram_32x4;

architecture arch of ram_32x4 is
    type ram_t is array (0 to 31) of std_logic_vector(3 downto 0);
    subtype ram_addr_t is integer range 0 to 31;
    signal curr_addr: ram_addr_t;
    signal ram_contents: ram_t;
begin
    process (clk) 
    begin
        ram_contents(0) <= "0110";
        ram_contents(1) <= "1101";
        ram_contents(2) <= "0011";
        ram_contents(3) <= "0001";
        curr_addr <= to_integer(unsigned(addr_bus));
        report integer'image(curr_addr);
        if clk'event and clk='1' then
            if rw='0' then
                -- write mode
                if (curr_addr>=32) then
                    data <= "ZZZZ";
                else 
                    ram_contents(curr_addr) <= data;
                end if;
            elsif rw='1' then
                -- read mode
                if (curr_addr>=32) then
                    data <= "ZZZZ";
                else 
                    data <= ram_contents(curr_addr);
                end if;
            end if;
        end if;
    end process;
end arch;