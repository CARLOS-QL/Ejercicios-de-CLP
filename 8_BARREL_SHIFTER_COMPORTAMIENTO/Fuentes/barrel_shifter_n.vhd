library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter_n is
    generic (
        N : positive := 8;
        M : positive := 3
    );
    port (
        a_i   : in  std_logic_vector(N-1 downto 0);
        des_i : in  std_logic_vector(M-1 downto 0);
        s_o   : out std_logic_vector(N-1 downto 0)
    );
end entity barrel_shifter_n;

architecture comportamental of barrel_shifter_n is
begin
    -- Desplazamiento logico a la derecha: se insertan ceros por la izquierda.
    -- Configurar N=2**M (por defecto N=8, M=3).
    s_o <= std_logic_vector(shift_right(unsigned(a_i), to_integer(unsigned(des_i))));
end architecture comportamental;
