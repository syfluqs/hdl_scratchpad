library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity test_can_wire is
end entity;

architecture arch_test_can_wire of test_can_wire is

component can_wire is
    generic (no_of_masters: integer:=1);
    port (can_hi: in std_logic;
          can_lo: in std_logic);
end component;

signal ch : std_logic;
signal cl : std_logic;

begin 
    test_subject : can_wire
    generic map (no_of_masters => 1)
    port map (can_hi => ch, can_lo => cl);

    process begin
        wait for 10 ns;
        ch <= '0';
        cl <= '1';
        wait for 10 ns;
        cl <= '1';
        ch <= '1';
        wait for 10 ns;
        ch <='0';
        wait for 20 ns;
        wait for 5 ns;
        cl <= '0';
        wait for 40 ns;
        ch <= '0';
        cl <= '1';
        wait for 10 ns;
        cl <= '1';
        ch <= '1';
        wait for 10 ns;
        ch <='0';
        wait for 20 ns;
        ch <= 'Z';
        wait for 5 ns;
        cl <= '0';
        wait for 40 ns;
        cl <= 'Z';
        report "testbench completed";
        wait;
    end process;
end arch_test_can_wire;