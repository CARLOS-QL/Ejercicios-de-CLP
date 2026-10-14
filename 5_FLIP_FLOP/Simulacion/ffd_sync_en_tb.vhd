library ieee;
use ieee.std_logic_1164.all;

entity ffd_sync_en_tb is
end entity ffd_sync_en_tb;

architecture tb of ffd_sync_en_tb is
    constant T_CLK : time := 10 ns;
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal ena_i : std_logic := '0';
    signal d_i   : std_logic := '0';
    signal q_o   : std_logic;
begin
    uut: entity work.ffd_sync_en(rtl)
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => ena_i,
            d_i   => d_i,
            q_o   => q_o
        );

    clk_i <= not clk_i after T_CLK / 2;

    stimulus: process
    begin
        -- El reset es sincrono: antes del flanco la salida no cambia.
        rst_i <= '1';
        ena_i <= '1';
        d_i   <= '1';
        wait for 2 ns;
        assert q_o = '0' report "Reset sincrono: Q cambio antes del flanco" severity error;
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert q_o = '0' report "Fallo: el reset no llevo Q a 0" severity error;

        -- Capturar D=1 con habilitacion activa.
        rst_i <= '0';
        ena_i <= '1';
        d_i   <= '1';
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert q_o = '1' report "Fallo: no captura D=1" severity error;

        -- Mantener Q=1 con enable inactivo aunque D cambie.
        ena_i <= '0';
        d_i   <= '0';
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert q_o = '1' report "Fallo: no retiene Q con ena=0" severity error;

        -- Capturar D=0 con enable activo.
        ena_i <= '1';
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert q_o = '0' report "Fallo: no captura D=0" severity error;

        -- Volver a Q=1.
        d_i <= '1';
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert q_o = '1' report "Fallo al volver a Q=1" severity error;

        -- Reset prioritario, incluso con ena=0.
        rst_i <= '1';
        ena_i <= '0';
        wait for 2 ns;
        assert q_o = '1' report "Fallo: reset debe ser sincrono" severity error;
        wait until rising_edge(clk_i);
        wait for 1 ns;
        assert q_o = '0' report "Fallo: reset sincrono sin prioridad" severity error;

        report "TESTBENCH FINALIZADO: todas las verificaciones pasaron" severity note;
        wait;
    end process;
end architecture tb;
