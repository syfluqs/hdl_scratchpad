-- D-flipflop.vhdl
-- author: roy
-- created: 2017-09-09

library ieee;
use ieee.std_logic_1164.all;


entity d_flipflop is
    port (CLK, D: in std_logic; Q, Q_bar : out std_logic);
end d_flipflop;

architecture behav of d_flipflop is
    constant propagation_delay: time := 1 ns;
begin 
    process(clk) 
    begin
            q <= d after propagation_delay;
            q_bar <= not q;
    end process;
end behav;

architecture using_if of d_flipflop is
begin
    process(clk) begin
        if (clk='1') then
            if d='0' then
                q<='0';
                q_bar<='1';
            elsif d='1' then
                q<='1';
                q_bar<='0';
            end if;
        end if;
    end process;
end using_if;