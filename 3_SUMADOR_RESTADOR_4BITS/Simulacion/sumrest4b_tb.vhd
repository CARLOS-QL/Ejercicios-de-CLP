library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaracion de entidad
entity sumrest4b_tb is
end;

architecture sumrest4b_tb_arq of sumrest4b_tb is

    -- Parte declarativa
    signal a_tb  : std_logic_vector(3 downto 0) := "0000";
    signal b_tb  : std_logic_vector(3 downto 0) := "0000";
    signal sr_tb : std_logic := '0';
    signal s_tb  : std_logic_vector(3 downto 0);
    signal co_tb : std_logic;

    -- Declaracion del componente
    component sumrest4b is
        port (
            a_i  : in std_logic_vector(3 downto 0);
            b_i  : in std_logic_vector(3 downto 0);
            sr_i : in std_logic;
            s_o  : out std_logic_vector(3 downto 0);
            co_o : out std_logic
        );
    end component;

begin
    -- Parte descriptiva

    -- Casos: 0+0, 5+3, 15+1, 7-3, 3-7, 15-1, 4+4, 4-4
    a_tb <= "0101" after 100 ns,
            "1111" after 200 ns,
            "0111" after 300 ns,
            "0011" after 400 ns,
            "1111" after 500 ns,
            "0100" after 600 ns;

    b_tb <= "0011" after 100 ns,
            "0001" after 200 ns,
            "0011" after 300 ns,
            "0111" after 400 ns,
            "0001" after 500 ns,
            "0100" after 600 ns;

    sr_tb <= '1' after 300 ns,
             '0' after 600 ns,
             '1' after 700 ns;

    -- Instancia del sumador/restador
    DUT: sumrest4b
        port map (
            a_i  => a_tb,
            b_i  => b_tb,
            sr_i => sr_tb,
            s_o  => s_tb,
            co_o => co_tb
        );

end;
