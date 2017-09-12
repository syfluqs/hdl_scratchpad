-- d_ff_with_async_reset.vhdl
-- author: roy
-- created: 2017-09-11

library ieee;
use ieee.std_logic_1164.all;


entity d_ff is
    port (CLK,D,RESET: in std_logic; Q,Q_bar: out std_logic);
end d_ff;

architecture arch of d_ff is
begin 
    process (CLK,RESET) begin
        if (CLK'event and clk='1') then
            Q <= D;
            Q_bar <= not D;
        end if;
        if (RESET='1') then
            Q <= '0';
            Q_bar <= '1';
        end if;
    end process;
end arch;