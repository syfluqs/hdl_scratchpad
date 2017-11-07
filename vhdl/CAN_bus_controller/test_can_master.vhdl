library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity test_can_master is
end test_can_master; 

architecture arch of test_can_master is
component can_master is
    generic (id : std_logic_vector(id_length-1 downto 0));
    port (tx_data_in: in std_logic_vector(data_length-1 downto 0); 
          rx_data_out: out std_logic_vector(data_length-1 downto 0);
          stage_id_out: out std_logic_vector(id_length-1 downto 0);
          stage_data_out : out std_logic_vector(data_length-1 downto 0);
          stage_data_in : in std_logic_vector(data_length-1 downto 0);
          transmit_bar: in std_logic;
          receive_bar: in std_logic);
end component;

signal data_in  : std_logic_vector(data_length-1 downto 0);
signal data_out  : std_logic_vector(data_length-1 downto 0);
signal sio: std_logic_vector(id_length-1 downto 0);
signal sdo : std_logic_vector(data_length-1 downto 0);
signal sdi : std_logic_vector(data_length-1 downto 0);
signal t_bar : std_logic:='1';
signal r_bar : std_logic:='1';

begin test_subject: can_master
generic map (id => "00000000111")
port map (
tx_data_in => data_in,
rx_data_out => data_out,
stage_data_in => sdi,
stage_data_out => sdo,
stage_id_out => sio,
transmit_bar => t_bar,
receive_bar => r_bar
);

stim_proc: process begin
    wait for 10 ns;
    data_in <= "11001100"; 
    t_bar <= '0';
    wait for 20 ns;
    t_bar <= '1';
    
    sdi <= "10101010";
    r_bar <= '0';
    wait for 20 ns;
    r_bar <= '1';
report "can_master testbench finished";
wait;
end process;
end;
