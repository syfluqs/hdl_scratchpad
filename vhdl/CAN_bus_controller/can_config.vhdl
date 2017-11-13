-- can_config.vhdl
-- author: roy
-- created: 2017-11-07
-- description : Globally shared configuration

library ieee;
use ieee.std_logic_1164.all;

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

    -- can_phy config
    constant can_phy_dominant_bit: std_logic := '0';
    constant can_phy_recessive_bit: std_logic := '1';

    -- can_wire config
    constant can_wire_analog_resolution: integer := 10;
    constant can_wire_analog_max_val: integer := 950;
    constant can_wire_analog_min_val: integer := 150;
    constant can_wire_sampling_period: time := 0.25 ns;
    constant can_wire_hi_k: real := 1.0;
    constant can_wire_hi_a: real := 0.5;
    constant can_wire_lo_k: real := 1.0;
    constant can_wire_lo_a: real := 0.5;
    -- Description
    -- can_wire_resolution : resolution of can_wire analog signal representation
    --                       in bits

    -- can_equalizer config
    constant can_equalizer_hi_k: real := 1.0;
    constant can_equalizer_hi_a: real := 0.5;
    constant can_equalizer_lo_k: real := 1.0;
    constant can_equalizer_lo_a: real := 0.5;

    --can_deserializer config
    constant can_deserializer_prop_delay: time := 0 ns;
end can_config;
