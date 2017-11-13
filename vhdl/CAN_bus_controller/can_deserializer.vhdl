-- can_deserializer.vhdl
-- author: roy
-- created: 2017-11-10
-- description : Deserialize stream

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity can_deserializer is
    port (stage_data_out: out std_logic_vector(data_length+id_length+8+2-1 downto 0); 
          stage_serial_in: in std_logic;
          data_latched: out std_logic);
end can_deserializer;

architecture can_deserializer_arch of can_deserializer is
begin 
    process
        constant stream_length: integer := data_length+id_length+8+2;
        variable stream_bit_counter: integer := 0;
        variable in_bit: std_logic;
    begin
        data_latched <= '1';
        wait until falling_edge(stage_serial_in);
        wait for can_serializer_pulse_width/2;
            in_bit := stage_serial_in;
            while (stream_bit_counter < stream_length) loop
                stage_data_out(stream_bit_counter) <= in_bit after can_deserializer_prop_delay;
                wait for can_serializer_pulse_width;
                stream_bit_counter := stream_bit_counter+1;
            end loop;
            data_latched <= '0';
            stream_bit_counter := 0;
            wait for can_serializer_pulse_width/4;
            data_latched <= '1';
    end process;
end can_deserializer_arch;