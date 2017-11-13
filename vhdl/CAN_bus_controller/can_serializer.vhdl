-- can_serializer.vhdl
-- author: roy
-- created: 2017-11-08
-- description : Serialize id+data+crc

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity can_serializer is
    port (stage_stream_in: in std_logic_vector(data_length+id_length+8+2-1 downto 0); 
          stage_serial_out: out std_logic;
          transmit_bar: in std_logic;
          stream_indicator: out std_logic);
    -- stage_stream_in : id+data+crc vector
    -- stage_serial_out : serialized output
    -- transmit_bar : '1' to '0' cahnge prompts can_serializer to read data on 
    --                 stage_stream_in
    -- stream_indicator : '1' to '0' change indicates the start of stream, '0' to
    --                    '1' change indicates end of stream
end can_serializer;

architecture can_serializer_arch of can_serializer is
begin 
    process
        constant stream_length: integer := data_length+id_length+8+2;
        variable stream_bit_counter: integer := stream_length-1;
        variable in_str: std_logic_vector(stream_length-1 downto 0);
    begin
        stream_indicator <= '1';
        wait until falling_edge(transmit_bar);
            in_str := stage_stream_in;
            stream_indicator <= '0';
            while (stream_bit_counter >= 0) loop
                stage_serial_out <= in_str(stream_bit_counter) after can_serializer_prop_delay;
                wait for can_serializer_pulse_width;
                stream_bit_counter := stream_bit_counter-1;
            end loop;
            stage_serial_out <= can_phy_recessive_bit;
            stream_indicator <= '1';
            stream_bit_counter := stream_length-1;
            in_str := (others => '0');
    end process;
end can_serializer_arch;