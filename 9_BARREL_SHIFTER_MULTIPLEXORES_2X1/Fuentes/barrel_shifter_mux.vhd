library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter_mux is
    port (
        a_i   : in  std_logic_vector(7 downto 0);
        des_i : in  std_logic_vector(2 downto 0);
        s_o   : out std_logic_vector(7 downto 0)
    );
end entity barrel_shifter_mux;

architecture estructural of barrel_shifter_mux is
    signal etapa1 : std_logic_vector(7 downto 0);
    signal etapa2 : std_logic_vector(7 downto 0);
begin
    -- Ocho multiplexores 2:1: desplazar 0 o 1 posicion.
    etapa1 <= a_i when des_i(0) = '0' else '0' & a_i(7 downto 1);

    -- Ocho multiplexores 2:1: desplazar 0 o 2 posiciones.
    etapa2 <= etapa1 when des_i(1) = '0' else "00" & etapa1(7 downto 2);

    -- Ocho multiplexores 2:1: desplazar 0 o 4 posiciones.
    s_o <= etapa2 when des_i(2) = '0' else "0000" & etapa2(7 downto 4);
end architecture estructural;
