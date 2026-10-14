library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_4bits_estructural_tb is
end entity;

architecture tb of contador_4bits_estructural_tb is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal ena : std_logic := '0';
    signal q   : std_logic_vector(3 downto 0);
begin
    DUT: entity work.contador_4bits_estructural(estructural)
        port map (clk_i => clk, rst_i => rst, ena_i => ena, q_o => q);

    clk <= not clk after 5 ns; -- 100 MHz, periodo de 10 ns

    stimulus: process
        procedure paso(constant esperada : natural) is
        begin
            wait until rising_edge(clk);
            wait for 1 ns; -- permitir actualizacion de señales
            assert q = std_logic_vector(to_unsigned(esperada, 4))
                report "Fallo: esperado=" & integer'image(esperada) &
                       " obtenido=" & integer'image(to_integer(unsigned(q)))
                severity error;
        end procedure;
    begin
        -- Reset SINCRONICO, con prioridad sobre la habilitacion.
        rst <= '1'; ena <= '1';
        paso(0);
        rst <= '0';

        -- Cuenta de 0 hasta 15 y vuelve a 0 (overflow).
        for i in 1 to 15 loop
            paso(i);
        end loop;
        paso(0);

        -- Deshabilitado: mantiene el valor aunque llegue el reloj.
        ena <= '0';
        paso(0);
        paso(0);

        -- Reanuda la cuenta.
        ena <= '1';
        paso(1);
        paso(2);

        -- Reset con ena=0: prioridad del reset.
        ena <= '0'; rst <= '1';
        wait for 2 ns;
        assert q = "0010" report "El reset no deberia actuar antes del flanco" severity error;
        paso(0);
        rst <= '0';

        report "TESTBENCH APROBADO: contador de 4 bits" severity note;
        wait;
    end process;
end architecture tb;
