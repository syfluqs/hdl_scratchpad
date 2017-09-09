-- 4to1_mux.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity mux_4to1 is
    port (A,B,C,D,S0,S1: in std_logic; Y: out std_logic);
end mux_4to1;

architecture basic_if_else of mux_4to1 is
    constant propagation_delay: time := 0.5 ns;
begin 
process (A,B,C,D,S0,S1)
begin
    if (S1='0' and S0='0') then 
        Y <= A after propagation_delay;
    elsif (S1='0' and S0='1') then 
        Y <= B after propagation_delay;
    elsif (S1='1' and S0='0') then 
        Y <= C after propagation_delay;
    elsif (S1='1' and S0='1') then 
        Y <= D after propagation_delay;
    end if;
end process;
end basic_if_else;

architecture case_stmt of mux_4to1 is
    constant propagation_delay: time := 0.5 ns;
begin 
process (A,B,C,D,S0,S1)
    variable select_lines: std_logic_vector (1 downto 0);
begin
    select_lines := S1 & S0;
    case(select_lines) is
        when "00" => Y <= A after propagation_delay;
        when "01" => Y <= B after propagation_delay;
        when "10" => Y <= C after propagation_delay;
        when "11" => Y <= D after propagation_delay;
        when others => Y <= 'U' after propagation_delay;
    end case;
end process;
end case_stmt;
