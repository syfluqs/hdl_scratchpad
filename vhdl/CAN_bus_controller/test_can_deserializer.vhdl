library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity can_des is 
end entity;

architecture can_des_of of can_des is
    component can_deserializer is
        port (stage_data_out: out std_logic_vector(data_length+id_length+8+2-1 downto 0); 
              stage_serial_in: in std_logic;
              data_latched: out std_logic);
    end component;
        signal sdo : std_logic_vector(data_length+id_length+8+2-1 downto 0);
        signal ssi : std_logic;
        signal dl : std_logic;
        constant d : std_logic_vector(data_length+id_length+8+2-1 downto 0):= "01011110111010011100010111011";
        begin 
            can_ds0 : can_deserializer port map
            ( stage_data_out => sdo,
              stage_serial_in => ssi,
              data_latched => dl);

            process begin
                ssi <= '1';
                wait for 5 ns;
                for i in 0 to 28 loop
                    ssi <= d(i);
                    wait for 5 ns;
                end loop;
                wait;
            end process;
        end can_des_of;