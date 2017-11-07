library ieee;
use ieee.std_logic_1164.all;

entity ram_32x4_tb is
end ram_32x4_tb; 

architecture behavior of ram_32x4_tb is
component ram_32x4 is 
port (
     addr_bus: in std_logic_vector(4 downto 0); clk, rw: in std_logic; data: inout std_logic_vector(3 downto 0));   
end component;

signal input  : std_logic_vector(4 downto 0);
signal output  : std_logic_vector(3 downto 0);
signal rw : std_logic;
signal clk: std_logic:= '0';

begin test_subject: ram_32x4 
port map (
addr_bus => input,
data => output,
rw => rw,
clk => clk
);

stim_proc: process begin
    clk <= '1';rw <= '1'; input <= "00000"; wait for 10 ns;
    clk <= '0'; wait for 10 ns;
    clk <= '1'; rw <= '1'; input <= "11111"; wait for 10 ns;
    clk <= '0'; wait for 10 ns;
report "ram_32x4 testbench finished";
wait;
end process;
end;
