library ieee;
use ieee.std_logic_1164.all;

entity registro_4bits_comp_tb is
end entity;

architecture tb of registro_4bits_comp_tb is
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal ena_i : std_logic := '0';
    signal e_i   : std_logic := '0';
    signal s_o   : std_logic;
    signal fin   : boolean := false;
begin
    dut: entity work.registro_4bits_comp(behavioral)
        port map(clk_i => clk_i, rst_i => rst_i,
                 ena_i => ena_i, e_i => e_i, s_o => s_o);

    clk_gen: process
    begin
        while not fin loop
            clk_i <= '0'; wait for 5 ns;
            clk_i <= '1'; wait for 5 ns;
        end loop;
        wait;
    end process;

    stimulus: process
        procedure cargar_bit(constant dato : in std_logic;
                            constant esperado : in std_logic) is
        begin
            wait until falling_edge(clk_i);
            e_i <= dato;
            wait until rising_edge(clk_i);
            wait for 1 ns;
            assert s_o = esperado
                report "Error: salida serie incorrecta" severity error;
        end procedure;
    begin
        -- Reset sincrono: no actua hasta el flanco ascendente.
        rst_i <= '1'; ena_i <= '1'; e_i <= '1';
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert s_o = '0' report "Error de reset" severity error;
        rst_i <= '0';

        -- Entrada serie 1,0,1,1 -> q: 1000,0100,1010,1101.
        cargar_bit('1','0');
        cargar_bit('0','0');
        cargar_bit('1','0');
        cargar_bit('1','1');

        -- Con enable a 0, el registro mantiene el dato.
        wait until falling_edge(clk_i);
        ena_i <= '0'; e_i <= '0';
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert s_o = '1' report "Error: no conserva valor con ena=0" severity error;

        -- La salida serie sigue desplazando los valores previos.
        ena_i <= '1';
        cargar_bit('0','0');
        cargar_bit('0','1');
        cargar_bit('0','0');
        cargar_bit('0','1');

        -- Reset tiene prioridad aun con enable activo.
        wait until falling_edge(clk_i);
        rst_i <= '1'; e_i <= '1';
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert s_o = '0' report "Error: prioridad del reset" severity error;
        report "FIN: todas las comprobaciones del testbench pasaron" severity note;
        fin <= true;
        wait;
    end process;
end architecture;
