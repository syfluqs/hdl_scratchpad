library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity test_can_crc is
end test_can_crc; 

architecture arch of test_can_crc is
component can_crc is
    port (stage_stream_out : out std_logic_vector(data_length+id_length+8-1 downto 0);
          stage_data_in : in std_logic_vector(data_length-1 downto 0);
          stage_id_in : in std_logic_vector(id_length-1 downto 0);
          receive_bar: in std_logic;
          stage_transmit_ready: out std_logic);
end component;

signal sso  : std_logic_vector(data_length+id_length+8-1 downto 0);
signal sii: std_logic_vector(id_length-1 downto 0);
signal sdi : std_logic_vector(data_length-1 downto 0);
signal r_bar : std_logic:='1';
signal str : std_logic:='1';

begin 

test_subject: can_crc
port map (
stage_stream_out => sso,
stage_data_in => sdi,
stage_id_in => sii,
stage_transmit_ready => str,
receive_bar => r_bar
);

stim_proc: process begin
    wait for 10 ns;
    sdi <= "11001100"; sii <= "10101111000";
    report "pulling r_bar down";
    r_bar <= '0';
    wait for 20 ns;
    r_bar <= '1';
    wait for 40 ns;
    wait until rising_edge(str);
    sdi <= "11111111"; sii <= "10101010101";
    r_bar <= '0';
    wait for 20 ns;
    r_bar <= '1';
report "can_master testbench finished";
wait;
end process;
end;
