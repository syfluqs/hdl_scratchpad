library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;
use ieee.numeric_std.all;

entity can_eq_tb is
end can_eq_tb;

architecture arch_eq_tb of can_eq_tb is
    component can_wire is
        generic (no_of_masters: integer:=1);
        port (can_hi: in std_logic;
              can_lo: in std_logic;
              can_hi_analog: out std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution));
              can_lo_analog: out std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution))
              );
    end component;

    component can_equalizer is 
        port (can_hi_analog: in std_logic_vector(can_wire_analog_resolution-1 downto 0);
              can_lo_analog: in std_logic_vector(can_wire_analog_resolution-1 downto 0);
              can_hi_analog_eq: out std_logic;
              can_lo_analog_eq: out std_logic
              );
    end component;

    signal ch : std_logic;
    signal cl : std_logic;
    signal cha : std_logic_vector(can_wire_analog_resolution-1 downto 0);
    signal cla : std_logic_vector(can_wire_analog_resolution-1 downto 0);
    signal ch_eq : std_logic;
    signal cl_eq : std_logic;

    begin

        test_subject_eq : can_equalizer port map (
            can_hi_analog => cha,
            can_lo_analog => cla,
            can_hi_analog_eq => ch_eq,
            can_lo_analog_eq => cl_eq
            );

        test_subject_wire : can_wire 
        generic map (no_of_masters => 1)
        port map (
            can_hi => ch,
            can_lo => cl,
            can_hi_analog => cha,
            can_lo_analog => cla
            );

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
    end arch_eq_tb;