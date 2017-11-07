-- can_crc.vhdl
-- author: roy
-- created: 2017-11-07
-- description : Calculates and verifies CRC of encapsulated data+id

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity can_crc is
    port (stage_stream_out : out std_logic_vector(data_length+id_length+8-1 downto 0);
          stage_data_in : in std_logic_vector(data_length-1 downto 0);
          stage_id_in : in std_logic_vector(id_length-1 downto 0);
          receive_bar: in std_logic;
          stage_transmit_ready: out std_logic);
    -- stage_stream_out : output of crc stage 
    -- stage_data_in : data input from previous stage
    -- stage_id_in : id input from previous stage
    -- receive_bar : '1' to '0' change prompts can_crc to read data and id
    -- stage_transmit_ready : '1' to '0' change indicates current stage is ready to
    --                         transfer data to next stage, latches signal to stage_stream_out
end can_crc;

architecture arch_can_crc of can_crc is
begin
    process
        variable out_stream: std_logic_vector(data_length+id_length+8-1 downto 0);
        variable crc_temp: std_logic_vector(7 downto 0):=(others => '0');
        variable count: integer:= 0;
    begin
        wait until falling_edge(receive_bar);
            while count < data_length+7 loop
                if (count < data_length) then
                    crc_temp(0) := stage_data_in(count) xor crc_temp(7);
                else 
                    crc_temp(0) := '0' xor crc_temp(7);
                end if;
                crc_temp(1) := crc_temp(0) xor crc_temp(7);
                crc_temp(2) := crc_temp(1) xor crc_temp(7);
                crc_temp(7 downto 3) := crc_temp(6 downto 2);
                count := count + 1;
            end loop;
            wait for can_crc_calc_delay;
            count := 0;
            out_stream(8-1 downto 0) := crc_temp;
            out_stream(8+data_length-1 downto 8) := stage_data_in;
            out_stream(id_length+8+data_length-1 downto 8+data_length) := stage_id_in;
            stage_stream_out <= out_stream after can_crc_prop_delay;
            stage_transmit_ready <= '0' after can_crc_prop_delay;
            report "done";
        wait until rising_edge(receive_bar);
            crc_temp := (others => '0');
            out_stream := (others => '0');
            count := 0;
            stage_stream_out <= (others => 'Z');
            stage_transmit_ready <= '1';
    end process;
end arch_can_crc;