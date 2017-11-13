-- can_wire_model.vhdl
-- author: roy
-- created: 2017-11-08
-- description : Capacitive media model to emulate 

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;
use ieee.numeric_std.all;

entity can_wire is
    generic (no_of_masters: integer:=1);
    port (can_hi: in std_logic;
          can_lo: in std_logic;
          can_hi_analog: out std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution));
          can_lo_analog: out std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution))
          );
    -- Description
    -- can_hi, can_lo : can_hi '1' and can_lo '0' represents dominant bit
    --                  by default, and can_hi '0' and can_lo '1' represents
    --                  recesive bit by default
end can_wire;

architecture arch_can_wire of can_wire is 
begin 
    process 
        variable can_hi_analog_prev: std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution));
        variable can_hi_sampled: std_logic;
        constant max: std_logic_vector(can_wire_analog_resolution-1 downto 0) := (others => '1');
        constant max_multiplier: real := (real(can_wire_analog_max_val)/real(to_integer(unsigned(max))))*real(to_integer(unsigned(max))-can_wire_analog_min_val);
    begin 
        can_hi_sampled := can_hi;
        if (can_hi_sampled = '1') then
            can_hi_analog <= std_logic_vector(to_unsigned(can_wire_analog_min_val+integer(real(can_wire_hi_a*real(to_integer(unsigned(can_hi_analog_prev))-can_wire_analog_min_val)) + max_multiplier*(1.0-can_wire_hi_a)*can_wire_hi_k),can_wire_analog_resolution));
        elsif (can_hi_sampled = '0') then
            can_hi_analog <= std_logic_vector(to_unsigned(can_wire_analog_min_val+integer(can_wire_hi_a*real(to_integer(unsigned(can_hi_analog_prev))-can_wire_analog_min_val)),can_wire_analog_resolution));
        elsif (can_hi_sampled = 'Z') then
            wait;
        end if;
        can_hi_analog_prev := can_hi_analog;

        wait for can_wire_sampling_period;
    end process;

    process 
        variable can_lo_analog_prev: std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution));
        variable can_lo_sampled: std_logic;
        constant max: std_logic_vector(can_wire_analog_resolution-1 downto 0) := (others => '1');
        constant max_multiplier: real := (real(can_wire_analog_max_val)/real(to_integer(unsigned(max))))*real(to_integer(unsigned(max))-can_wire_analog_min_val);
    begin 
        can_lo_sampled := can_lo;
        if (can_lo_sampled = '1') then
            can_lo_analog <= std_logic_vector(to_unsigned(can_wire_analog_min_val+integer(real(can_wire_lo_a*real(to_integer(unsigned(can_lo_analog_prev))-can_wire_analog_min_val)) + max_multiplier*(1.0-can_wire_lo_a)*can_wire_lo_k),can_wire_analog_resolution));
        elsif (can_lo_sampled = '0') then
            can_lo_analog <= std_logic_vector(to_unsigned(can_wire_analog_min_val+integer(can_wire_lo_a*real(to_integer(unsigned(can_lo_analog_prev))-can_wire_analog_min_val)),can_wire_analog_resolution));
        elsif (can_lo_sampled = 'Z') then
            wait;
        end if;
        can_lo_analog_prev := can_lo_analog;

        wait for can_wire_sampling_period;
    end process;

end arch_can_wire;