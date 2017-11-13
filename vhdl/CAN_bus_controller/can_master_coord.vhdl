-- can_master_coord.vhdl
-- author: roy
-- created: 2017-10-24
-- description : coordinates the can bus masters, acts like a testbench

library ieee;
use ieee.std_logic_1164.all;
use work.can_config.all;
use ieee.numeric_std.all;

entity can_master_coord is
end can_master_coord;

architecture can_master_coord_tb of can_master_coord is
    component can_master is
        generic (id : std_logic_vector(id_length-1 downto 0));
        port (tx_data_in: in std_logic_vector(data_length-1 downto 0); 
              rx_data_out: out std_logic_vector(data_length-1 downto 0);
              transmit_bar: in std_logic;
              receive_bar: out std_logic;
              stage_transmit_ready: out std_logic);
    end component;

    signal tdi : std_logic_vector(data_length-1 downto 0);
    signal rdo : std_logic_vector(data_length-1 downto 0);
    signal t_bar : std_logic := '1';
    signal r_bar : std_logic;
    signal str : std_logic;

    begin

        can_master0 : can_master 
        generic map (id => "11110001010")
        port map (
            tx_data_in => tdi,
            rx_data_out => rdo,
            transmit_bar => t_bar,
            receive_bar => r_bar,
            stage_transmit_ready => str);

        process begin
            tdi <= "11111111";
            wait for 10 ns;
            t_bar <= '0';
            wait for 5 ns;
            t_bar <= '1';
            wait;
        end process;
    end can_master_coord_tb;