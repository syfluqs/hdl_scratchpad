-- can_config.vhdl
-- author: roy
-- created: 2017-11-07
-- description : Globally shared configuration

package can_config is
    
    -- can_master config
    constant data_length: integer := 8;
    constant id_length: integer := 11;
    constant can_master_prop_delay: time := 0 ns;
    -- Description
    -- data_length : Length of data stream in bits
    -- id_length : length of id
    -- can_master_prop_delay : propagation delay for latching of signals onto ports

    -- can_crc config
    constant can_crc_prop_delay: time := 0 ns;
    constant can_crc_calc_delay: time := 0 ns;
    -- Description
    -- can_crc_prop_delay : Propagation Delay for latching CRC value
    -- can_crc_calc_delay : Delay for calculating CRC value

    -- can_serializer config
    constant can_serializer_pulse_width: time := 10 ns;
    constant can_serializer_prop_delay: time := 0 ns;
    -- Description
    -- can_serializer_pulse_width : Pulse width time for each data bit
end can_config;
