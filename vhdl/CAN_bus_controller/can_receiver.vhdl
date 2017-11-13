-- can_receiver.vhdl
-- author: roy
-- created: 2017-11-10
-- description : Recieive deserialized data, check CRC, drop frame for id mismatch
--               and notify bus controller if everything is correct

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;
use work.can_subprograms.all;

entity can_receiver is
    generic (id : std_logic_vector(id_length-1 downto 0));
    port (stage_data_in: in std_logic_vector(data_length+id_length+8+2-1 downto 0); 
          data_latched: in std_logic;
          stage_data_out: out std_logic_vector(data_length-1 downto 0):=(others => 'Z'));
end can_receiver;

architecture can_receiver_arch of can_receiver is
begin 
    process (data_latched)
        constant stream_length: integer := data_length+id_length+8+2;
        variable rx_data: std_logic_vector(data_length+id_length+8+2-1 downto 0);
        variable crc_temp: crc_t;
    begin
        if falling_edge(data_latched) then
            rx_data := stage_data_in;
            crc_temp := calc_crc(rx_data(data_length+id_length downto 1+id_length));
            -- Validate CRC
            if (crc_temp = rx_data(data_length+id_length+8 downto data_length+id_length+1)) then
                -- check if id received is equa to master id
                if (id = rx_data(data_length+id_length-1 downto data_length)) then
                    -- id match, msg successully received
                    report "can_master id "&to_string(id)&": received data "&to_string(rx_data(data_length downto 1));
                    stage_data_out <= rx_data(data_length downto 1);
                end if;
            else
                report "can_master "&to_string(id)&": CRC fail";
            end if;
        end if;
    end process;
end can_receiver_arch;