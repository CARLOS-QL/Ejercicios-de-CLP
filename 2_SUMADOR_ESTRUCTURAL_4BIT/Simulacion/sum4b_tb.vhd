library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity sum4b_tb is
end;

architecture sum4b_tb_arq of sum4b_tb is

    -- Parte declarativa

    signal a_tb: std_logic_vector(3 downto 0) := "0000";
    signal b_tb: std_logic_vector(3 downto 0) := "0000";
    signal ci_tb: std_logic := '0';
    signal s_tb: std_logic_vector(3 downto 0);
    signal co_tb: std_logic;

    -- Declaracion del componente
    component sum4b is
        port(
            a_i: in std_logic_vector(3 downto 0);
            b_i: in std_logic_vector(3 downto 0);
            ci_i: in std_logic;
            s_o: out std_logic_vector(3 downto 0);
            co_o: out std_logic
        );
    end component;

begin

    -- Parte descriptiva

    -- Prueba para A
    a_tb <= "0101" after 100 ns,
            "1111" after 400 ns,
            "0011" after 600 ns;

    -- Prueba para B
    b_tb <= "0011" after 200 ns,
            "0001" after 400 ns,
            "0100" after 600 ns;

    -- Acarreo de entrada
    ci_tb <= '1' after 300 ns,
             '0' after 400 ns,
             '1' after 700 ns;

    -- Instancia del sumador de 4 bits
    DUT: sum4b
        port map(
            a_i  => a_tb,
            b_i  => b_tb,
            ci_i => ci_tb,
            s_o  => s_tb,
            co_o => co_tb
        );

end;

