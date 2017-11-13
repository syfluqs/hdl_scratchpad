-- can_wire_model.vhdl
-- author: roy
-- created: 2017-11-08
-- description : Capacitive media model to emulate 

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;
use ieee.numeric_std.all;

entity can_equalizer is
    port (can_hi_analog: in std_logic_vector(can_wire_analog_resolution-1 downto 0);
          can_lo_analog: in std_logic_vector(can_wire_analog_resolution-1 downto 0);
          --can_hi_analog_eqed: out std_logic_vector(can_wire_analog_resolution-1 downto 0);
          --can_lo_analog_eqed: out std_logic_vector(can_wire_analog_resolution-1 downto 0)
          can_eq_out : out std_logic
          );
    -- Description
    -- can_hi_analog, can_lo_analog : can wire signals
    -- can_hi_analog_eqed, can_lo_analog_eqed : equalised analog signals
end can_equalizer;

architecture arch_can_equalizer of can_equalizer is 
    signal can_hi_analog_eq: std_logic;
    signal can_lo_analog_eq: std_logic;
begin 
    process (can_hi_analog)
        constant max: std_logic_vector(can_wire_analog_resolution-1 downto 0) := (others => '1');
        constant max_multiplier: real := (real(can_wire_analog_max_val)/real(to_integer(unsigned(max))))*real(to_integer(unsigned(max))-can_wire_analog_min_val);
        variable can_hi_analog_prev: std_logic_vector(can_wire_analog_resolution-1 downto 0) := (others => '0');
        variable temp: std_logic_vector(can_wire_analog_resolution-1 downto 0) := (others => '0');
        variable can_hi_analog_eqed: std_logic_vector(can_wire_analog_resolution-1 downto 0);
    begin 
        --temp := std_logic_vector(to_unsigned(integer(real(to_integer(unsigned(can_hi_analog))-can_wire_analog_min_val)*multiplier),can_wire_analog_resolution));
        --can_hi_analog_eqed <= std_logic_vector(to_unsigned(integer(real(to_integer(unsigned(temp)))-(can_equalizer_hi_a*real(to_integer(unsigned(can_hi_analog_prev))))/((1.0-can_equalizer_hi_a)*can_equalizer_hi_k)),can_wire_analog_resolution));
        can_hi_analog_eqed := std_logic_vector(to_unsigned(integer((real(to_integer(unsigned(can_hi_analog)))-can_equalizer_hi_a*real(to_integer(unsigned(can_hi_analog))))/real((1.0-can_equalizer_hi_a)*can_equalizer_hi_k*max_multiplier)),can_wire_analog_resolution));
        can_hi_analog_prev := temp;
        can_hi_analog_eq <= can_hi_analog_eqed(0);
    end process;

    process (can_lo_analog)
        constant max: std_logic_vector(can_wire_analog_resolution-1 downto 0) := (others => '1');
        constant max_multiplier: real := (real(can_wire_analog_max_val)/real(to_integer(unsigned(max))))*real(to_integer(unsigned(max))-can_wire_analog_min_val);
        variable can_lo_analog_eqed: std_logic_vector(can_wire_analog_resolution-1 downto 0);
    begin 
        can_lo_analog_eqed := std_logic_vector(to_unsigned(integer((real(to_integer(unsigned(can_lo_analog)))-can_equalizer_lo_a*real(to_integer(unsigned(can_lo_analog))))/real((1.0-can_equalizer_lo_a)*can_equalizer_lo_k*max_multiplier)),can_wire_analog_resolution));
        can_lo_analog_eq <= can_lo_analog_eqed(0);
    end process;

    can_eq_out <= '1' when (can_hi_analog="0000000001" and can_lo_analog="0000000000") else
                  '0' when (can_hi_analog="0000000000" and can_lo_analog="0000000001") else
                  '1';

end arch_can_equalizer;