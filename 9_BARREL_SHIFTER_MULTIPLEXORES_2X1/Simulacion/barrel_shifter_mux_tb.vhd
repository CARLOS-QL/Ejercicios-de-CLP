library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter_mux_tb is
end entity;

architecture tb of barrel_shifter_mux_tb is
    signal a_i   : std_logic_vector(7 downto 0) := (others => '0');
    signal des_i : std_logic_vector(2 downto 0) := (others => '0');
    signal s_o   : std_logic_vector(7 downto 0);
begin
    DUT: entity work.barrel_shifter_mux(estructural)
        port map (a_i => a_i, des_i => des_i, s_o => s_o);

    stim: process
        variable esperado : std_logic_vector(7 downto 0);
    begin
        a_i <= "11010110";
        for i in 0 to 7 loop
            des_i <= std_logic_vector(to_unsigned(i, 3));
            esperado := std_logic_vector(shift_right(unsigned("11010110"), i));
            wait for 10 ns;
            assert s_o = esperado
                report "ERROR para entrada 11010110, desplazamiento " & integer'image(i)
                severity error;
        end loop;

        a_i <= "10000001";
        for i in 0 to 7 loop
            des_i <= std_logic_vector(to_unsigned(i, 3));
            esperado := std_logic_vector(shift_right(unsigned("10000001"), i));
            wait for 10 ns;
            assert s_o = esperado
                report "ERROR para entrada 10000001, desplazamiento " & integer'image(i)
                severity error;
        end loop;

        report "FIN: las 16 pruebas del Barrel Shifter finalizaron sin errores" severity note;
        wait;
    end process;
end architecture tb;
