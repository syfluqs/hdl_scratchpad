-- input is 4-bit binary number
-- output is 1 if input is a primary number or 1

library ieee;
use ieee.std_logic_1164.all;

entity prime is
    port(B0, B1, B2, B3: in std_logic; is_prime : out std_logic);
end prime;

architecture arch of prime is
    signal vec: std_logic_vector(3 downto 0);
    begin
        process begin
            wait on B1;
            vec <= (B0,B1,B2,B3);
            case vec is
            when x"1" | x"2" | x"3" | x"5" | x"7" | x"b" | x"d" => is_prime <= '1';
            when others => is_prime <= '0';
        end case;
    end process;
end arch;