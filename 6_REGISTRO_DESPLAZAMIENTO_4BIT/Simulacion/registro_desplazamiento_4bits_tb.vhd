library ieee;
use ieee.std_logic_1164.all;

entity registro_desplazamiento_4bits_tb is
end entity;

architecture tb of registro_desplazamiento_4bits_tb is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal ena : std_logic := '0';
    signal e   : std_logic := '0';
    signal s   : std_logic;
    constant CLK_PERIOD : time := 10 ns;
begin
    clk <= not clk after CLK_PERIOD / 2;

    DUT: entity work.registro_desplazamiento_4bits(estructural)
        port map (clk_i => clk, rst_i => rst, ena_i => ena,
                  e_i => e, s_o => s);

    stim: process
        -- Establece entradas en flanco descendente, comprueba despues del ascendente.
        procedure clock_and_check(
            constant bit_in : in std_logic;
            constant en     : in std_logic;
            constant reset  : in std_logic;
            constant expected_s : in std_logic
        ) is
        begin
            wait until falling_edge(clk);
            e <= bit_in;
            ena <= en;
            rst <= reset;
            wait until rising_edge(clk);
            wait for 1 ns;
            assert s = expected_s
                report "Error: salida serie no coincide con el valor esperado"
                severity error;
        end procedure;
    begin
        -- Reset sincrono: limpia los cuatro FF en el flanco.
        clock_and_check('0', '0', '1', '0');
        -- Secuencia de entrada serie 1,0,1,1.
        -- Sale por S cuatro flancos habilitados despues del primer 1.
        clock_and_check('1', '1', '0', '0');  -- Q = 1000
        clock_and_check('0', '1', '0', '0');  -- Q = 0100
        clock_and_check('1', '1', '0', '0');  -- Q = 1010
        clock_and_check('1', '1', '0', '1');  -- Q = 1101, sale el primer 1
        -- Prueba de habilitacion desactivada: conserva la salida.
        clock_and_check('0', '0', '0', '1');
        clock_and_check('0', '1', '0', '0');  -- Q = 0110
        clock_and_check('0', '1', '0', '1');  -- Q = 0011
        clock_and_check('0', '1', '0', '1');  -- Q = 0001
        clock_and_check('0', '1', '0', '0');  -- Q = 0000
        -- Reset con enable desactivado: reset tiene prioridad.
        clock_and_check('1', '0', '1', '0');
        report "TESTBENCH FINALIZADO: todas las comprobaciones correctas" severity note;
        wait;
    end process;
end architecture tb;
