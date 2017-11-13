library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity test_can_receiver is
end test_can_receiver; 

architecture arch of test_can_receiver is
component can_receiver is
    generic (id : std_logic_vector(id_length-1 downto 0));
    port (stage_data_in: in std_logic_vector(data_length+id_length+8+2-1 downto 0); 
          data_latched: in std_logic);
end component;

signal sdi  : std_logic_vector(data_length+id_length+8+2-1 downto 0);
signal dl: std_logic;

begin 

test_subject: can_receiver
generic map (id => "10101010001")
port map (
stage_data_in => sdi,
data_latched => dl
);

stim_proc: process begin
    dl <= '1';
    wait for 10 ns;
    sdi <= "01010101000110100101101010011";
    dl <= '0';
    wait for 10 ns;
    dl <= '1';
report " testbench finished";
wait;
end process;
end;
