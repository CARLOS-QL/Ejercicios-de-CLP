library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_tb is
end entity mux_2x1_tb;

architecture tb of mux_2x1_tb is
    signal a_i   : std_logic := '0';
    signal b_i   : std_logic := '0';
    signal sel_i : std_logic := '0';
    signal sal_o : std_logic;
begin
    DUT: entity work.mux_2x1(rtl)
        port map (
            a_i   => a_i,
            b_i   => b_i,
            sel_i => sel_i,
            sal_o => sal_o
        );

    stimulus: process
    begin
        -- Selector 0: la salida debe ser A
        a_i <= '0'; b_i <= '1'; sel_i <= '0';
        wait for 20 ns;
        assert sal_o = '0' report "Error: sel=0 debe seleccionar A=0" severity error;

        a_i <= '1'; b_i <= '0'; sel_i <= '0';
        wait for 20 ns;
        assert sal_o = '1' report "Error: sel=0 debe seleccionar A=1" severity error;

        -- Selector 1: la salida debe ser B
        a_i <= '0'; b_i <= '1'; sel_i <= '1';
        wait for 20 ns;
        assert sal_o = '1' report "Error: sel=1 debe seleccionar B=1" severity error;

        a_i <= '1'; b_i <= '0'; sel_i <= '1';
        wait for 20 ns;
        assert sal_o = '0' report "Error: sel=1 debe seleccionar B=0" severity error;

        report "Prueba del multiplexor 2x1 finalizada correctamente" severity note;
        wait;
    end process;
end architecture tb;
