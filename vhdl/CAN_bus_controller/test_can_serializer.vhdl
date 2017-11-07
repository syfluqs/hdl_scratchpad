library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity test_can_serializer is
end test_can_serializer; 

architecture arch of test_can_serializer is
component can_serializer is
    port (stage_stream_in: in std_logic_vector(data_length+id_length+8-1 downto 0); 
          stage_serial_out: out std_logic;
          transmit_bar: in std_logic;
          stream_indicator: out std_logic);
end component;

signal ssi  : std_logic_vector(data_length+id_length+8-1 downto 0);
signal sso: std_logic;
signal t_bar : std_logic:='1';
signal str_ind : std_logic:='1';

begin 

test_subject: can_serializer
port map (
stage_stream_in => ssi,
stage_serial_out => sso,
transmit_bar => t_bar,
stream_indicator => str_ind
);

stim_proc: process begin
    wait for 10 ns;
    ssi <= "111100110001010101011111100";
    report "pulling t_bar down";
    t_bar <= '0';
    wait for 20 ns;
    t_bar <= '1';
    wait until rising_edge(str_ind);
    wait for 40 ns;
    ssi <= "111100110001010101011111Z00";
    report "pulling t_bar down again";
    t_bar <= '0';
    wait for 20 ns;
    t_bar <= '1';
report "can_master testbench finished";
wait;
end process;
end;
