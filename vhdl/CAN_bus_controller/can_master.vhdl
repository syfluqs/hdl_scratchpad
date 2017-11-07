-- can_master.vhdl
-- author: roy
-- created: 2017-11-07
-- description : CAN Master + encapsulator for ID (11-bit) and data (8-bit)

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;

entity can_master is
    generic (id : std_logic_vector(id_length-1 downto 0));
    port (tx_data_in: in std_logic_vector(data_length-1 downto 0); 
          rx_data_out: out std_logic_vector(data_length-1 downto 0);
          stage_id_out: out std_logic_vector(id_length-1 downto 0);
          stage_data_out : out std_logic_vector(data_length-1 downto 0);
          stage_data_in : in std_logic_vector(data_length-1 downto 0);
          transmit_bar: in std_logic;
          receive_bar: in std_logic;
          stage_transmit_ready: out std_logic);
    -- id             : 11-bit id for CAN master
    -- tx_data_in     : data vector input to be transmitted in CAN bus
    -- rx_data_out    : data vector output for received data
    -- transmit_bar   : '1' to '0' change latches id and data to stage_id_out 
    --                  and  stage_data_out 
    -- receive_bar    : '1' to '0' change latches stage_data_in to rx_data_out 
    -- stage_data_out : 
    -- stage_id_out   : output ports for this stage connecting to next stage
    -- stage_data_in  : input port for this stage coming from a stage below
    -- stage_transmit_ready : '1' to '0' change indicates the stage data outputs 
    --                        are fully latched
end can_master;

architecture arch_can_master of can_master is
    begin
    process (transmit_bar) begin
        if transmit_bar'event and transmit_bar='0' then
            -- high to low change
            stage_data_out <= tx_data_in after can_master_prop_delay;
            stage_id_out <= id after can_master_prop_delay;
            wait for can_master_prop_delay;
            stage_transmit_ready <= '0';
        elsif transmit_bar'event and transmit_bar='1' then
            -- low to high change
            stage_data_out <= (others => 'Z') after can_master_prop_delay;
            stage_id_out <= (others => 'Z') after can_master_prop_delay;
            stage_transmit_ready <= '1';
        end if;
    end process;

    process (receive_bar) begin
        if receive_bar'event and receive_bar='0' then
            -- high to low change
            rx_data_out <= stage_data_in after can_master_prop_delay;
        elsif receive_bar'event and receive_bar='1' then
            -- low to high change
            rx_data_out <= (others => 'Z') after can_master_prop_delay;
        end if;
    end process;
end arch_can_master;