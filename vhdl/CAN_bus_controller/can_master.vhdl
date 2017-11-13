-- can_master.vhdl
-- author: roy
-- created: 2017-11-07
-- description : CAN Master + encapsulator for ID (11-bit) and data (8-bit)

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;
use ieee.numeric_std.all;

entity can_master is
    generic (id : std_logic_vector(id_length-1 downto 0));
    port (tx_data_in: in std_logic_vector(data_length-1 downto 0); 
          rx_data_out: out std_logic_vector(data_length-1 downto 0);
          transmit_bar: in std_logic;
          receive_bar: out std_logic;
          stage_transmit_ready: out std_logic);
    -- id             : 11-bit id for CAN master
    -- tx_data_in     : data vector input to be transmitted in CAN bus
    -- rx_data_out    : data vector output for received data
    -- transmit_bar   : '1' to '0' change latches id and data to stage_id_out 
    --                  and  stage_data_out 
    -- receive_bar    : '1' to '0' change latches stage_data_in to rx_data_out 
    -- stage_data_out : 
    -- stage_id_out   : output ports for this stage connecting to next stage    
    -- stage_transmit_ready : '1' to '0' change indicates the stage data outputs 
    --                        are fully latched
end can_master;

architecture arch_can_master of can_master is

    component can_crc is
        port (stage_stream_out : out std_logic_vector(data_length+id_length+8+2-1 downto 0);
              stage_data_in : in std_logic_vector(data_length-1 downto 0);
              stage_id_in : in std_logic_vector(id_length-1 downto 0);
              receive_bar: in std_logic;
              stage_transmit_ready: out std_logic);
    end component;

    component can_serializer is 
        port (stage_stream_in: in std_logic_vector(data_length+id_length+8+2-1 downto 0); 
              stage_serial_out: out std_logic;
              transmit_bar: in std_logic;
              stream_indicator: out std_logic);
    end component;

    component can_phy is
        port (stage_serial_in: in std_logic; 
              can_hi: out std_logic;
              can_lo: out std_logic;
              stream_indicator: in std_logic);
    end component;

    component can_wire is
        generic (no_of_masters: integer:=1);
        port (can_hi: in std_logic;
              can_lo: in std_logic;
              can_hi_analog: out std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution));
              can_lo_analog: out std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution))
              );
    end component;

    component can_equalizer is
        port (can_hi_analog: in std_logic_vector(can_wire_analog_resolution-1 downto 0);
              can_lo_analog: in std_logic_vector(can_wire_analog_resolution-1 downto 0);
              can_eq_out : out std_logic
              );
    end component;

    component can_deserializer is
        port (stage_data_out: out std_logic_vector(data_length+id_length+8+2-1 downto 0); 
              stage_serial_in: in std_logic;
              data_latched: out std_logic);
    end component;

    component can_receiver is
        generic (id : std_logic_vector(id_length-1 downto 0));
        port (stage_data_in: in std_logic_vector(data_length+id_length+8+2-1 downto 0); 
              data_latched: in std_logic;
              stage_data_out: out std_logic_vector(data_length-1 downto 0):=(others => 'Z'));
    end component;

    signal crc_str_out : std_logic_vector(data_length+id_length+8+2-1 downto 0);
    signal crc_data_in : std_logic_vector(data_length-1 downto 0);
    signal crc_id_in : std_logic_vector(id_length-1 downto 0);
    signal crc_rx : std_logic;
    signal crc_str : std_logic;

    signal serializer_sso : std_logic;
    signal serializer_str_ind : std_logic;

    signal phy_can_hi : std_logic;
    signal phy_can_lo : std_logic;

    signal wire_analog_hi : std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution));
    signal wire_analog_lo : std_logic_vector(can_wire_analog_resolution-1 downto 0) := std_logic_vector(to_unsigned(can_wire_analog_min_val,can_wire_analog_resolution));

    signal equalizer_out : std_logic;

    signal deserializer_data_out : std_logic_vector(data_length+id_length+8+2-1 downto 0); 
    signal deserializer_dl : std_logic;

    signal receiver_data_out: std_logic_vector(data_length-1 downto 0):=(others => 'Z');

    begin

    crc0 : can_crc port map(
        stage_data_in => crc_data_in,
        stage_id_in => crc_id_in,
        stage_stream_out => crc_str_out,
        receive_bar => crc_rx,
        stage_transmit_ready => crc_str
        );

    ser0 : can_serializer port map (
        stage_stream_in => crc_str_out,
        stage_serial_out => serializer_sso,
        transmit_bar => crc_str,
        stream_indicator => serializer_str_ind
        );

    phy0 : can_phy port map(
        stage_serial_in => serializer_sso,
        can_hi => phy_can_hi,
        can_lo => phy_can_lo,
        stream_indicator => serializer_str_ind
        );

    wire0 : can_wire port map (
        can_hi => phy_can_hi,
        can_lo => phy_can_lo,
        can_hi_analog => wire_analog_hi,
        can_lo_analog => wire_analog_lo
        );

    equ0 : can_equalizer port map (
        can_hi_analog => wire_analog_hi,
        can_lo_analog => wire_analog_lo,
        can_eq_out => equalizer_out
        );

    des0 : can_deserializer port map (
        stage_data_out => deserializer_data_out,
        stage_serial_in => equalizer_out,
        data_latched => deserializer_dl
        );

    rec0 : can_receiver 
        generic map (id => id)
        port map (
        stage_data_in => deserializer_data_out,
        data_latched => deserializer_dl,
        stage_data_out => receiver_data_out
        );

    process (transmit_bar) begin
        if transmit_bar'event and transmit_bar='0' then
            -- high to low change
            crc_data_in <= tx_data_in after can_master_prop_delay;
            crc_id_in <= id after can_master_prop_delay;
            --wait for can_master_prop_delay;
            stage_transmit_ready <= '0';
        elsif transmit_bar'event and transmit_bar='1' then
            -- low to high change
            crc_data_in <= (others => 'Z') after can_master_prop_delay;
            crc_id_in <= (others => 'Z') after can_master_prop_delay;
            stage_transmit_ready <= '1';
        end if;
    end process;

    --process (receive_bar) begin
    --    if receive_bar'event and receive_bar='0' then
    --        -- high to low change
    --        rx_data_out <= stage_data_in after can_master_prop_delay;
    --    elsif receive_bar'event and receive_bar='1' then
    --        -- low to high change
    --        rx_data_out <= (others => 'Z') after can_master_prop_delay;
    --    end if;
    --end process;
end arch_can_master;