-- can_phy.vhdl
-- author: roy
-- created: 2017-11-08
-- description : Convert serialised signal to CAN_HI and CAN_LO signals

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity can_phy is
    port (stage_serial_in: in std_logic; 
          can_hi: out std_logic;
          can_lo: out std_logic;
          stream_indicator: in std_logic);
    -- stage_stream_in : id+data+crc vector
    -- can_hi, can_lo : can bus signals
    -- stream_indicator : '1' to '0' change indicates the start of stream, '0' to
    --                    '1' change indicates end of stream
end can_phy;

architecture arch_can_phy of can_phy is
begin
    process (stage_serial_in)
    begin
        if stream_indicator /= '1' then
            if stage_serial_in'event and stage_serial_in = can_phy_dominant_bit then
                can_hi <= '1';
                can_lo <= '0';
            elsif stage_serial_in'event and stage_serial_in = can_phy_recessive_bit then
                can_hi <= '0';
                can_lo <= '1';
            end if;
        end if;
    end process;
end arch_can_phy;