library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity test_can_phy is
end test_can_phy; 

architecture arch of test_can_phy is
component can_phy is
    port (stage_serial_in: in std_logic; 
          can_hi: out std_logic;
          can_lo: out std_logic;
          stream_indicator: in std_logic);
end component;

signal ssi  : std_logic;
signal ch: std_logic;
signal cl : std_logic;
signal str_ind : std_logic:='1';

begin 

test_subject: can_phy
port map (
stage_serial_in => ssi,
can_hi => ch,
can_lo => cl,
stream_indicator => str_ind
);

stim_proc: process 
    constant str: std_logic_vector := "01111001100010101010111111001";
    variable count: integer := 0;
begin
    --report integer'image(str'right);
    wait for 40 ns;
    str_ind <= '0';
    while (count <= str'right) loop
        report "setting ssi="&std_logic'image(str(count));
        ssi <= str(count);
        count := count+1;
        wait for can_serializer_pulse_width;
    end loop;
    str_ind <= '1';
    wait for 40 ns;
    --ssi <= "01111001100010101010111111001";
    --report "pulling t_bar down";
    --str_ind <= '0';
    --wait for 20 ns;
    --t_bar <= '1';
    --wait until rising_edge(str_ind);
    --wait for 40 ns;
    --ssi <= "111100110001010101011111Z00";
    --report "pulling t_bar down again";
    --t_bar <= '0';
    --wait for 20 ns;
    --t_bar <= '1';
report "can_phy testbench finished";
wait;
end process;
end;
