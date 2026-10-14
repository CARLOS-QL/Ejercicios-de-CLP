library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter_n_tb is
end entity;

architecture tb of barrel_shifter_n_tb is
    constant N : positive := 8;
    constant M : positive := 3;
    signal a   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal des : std_logic_vector(M-1 downto 0) := (others => '0');
    signal s   : std_logic_vector(N-1 downto 0);
begin
    DUT: entity work.barrel_shifter_n(comportamental)
        generic map (N => N, M => M)
        port map (a_i => a, des_i => des, s_o => s);

    stimulus: process
        variable esperado : std_logic_vector(N-1 downto 0);
    begin
        a <= "11010110";
        for i in 0 to N-1 loop
            des <= std_logic_vector(to_unsigned(i, M));
            wait for 10 ns;
            esperado := std_logic_vector(shift_right(unsigned(a), i));
            assert s = esperado
                report "Error en desplazamiento de " & integer'image(i) & " bits"
                severity error;
        end loop;

        a <= "10000001";
        for i in 0 to N-1 loop
            des <= std_logic_vector(to_unsigned(i, M));
            wait for 10 ns;
            esperado := std_logic_vector(shift_right(unsigned(a), i));
            assert s = esperado
                report "Error en segunda prueba de " & integer'image(i) & " bits"
                severity error;
        end loop;
        report "FIN: Todas las pruebas del barrel shifter finalizaron sin errores." severity note;
        wait;
    end process;
end architecture tb;
