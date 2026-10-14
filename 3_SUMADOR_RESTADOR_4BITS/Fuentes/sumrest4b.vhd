library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumrest4b is
    Port (
        a_i  : in std_logic_vector(3 downto 0);
        b_i  : in std_logic_vector(3 downto 0);
        sr_i : in std_logic;
        s_o  : out std_logic_vector(3 downto 0);
        co_o : out std_logic
    );
end sumrest4b;

architecture sumrest4b_arq of sumrest4b is

    -- Parte declarativa

    -- Declaracion del componente sumador de 4 bits
    component sum4b is
        Port (
            a_i  : in std_logic_vector(3 downto 0);
            b_i  : in std_logic_vector(3 downto 0);
            ci_i : in std_logic;
            s_o  : out std_logic_vector(3 downto 0);
            co_o : out std_logic
        );
    end component;

    -- Operando B acondicionado para suma o resta
    signal b_aux : std_logic_vector(3 downto 0);

begin
    -- Parte descriptiva

    -- sr_i = 0: B sin cambios (suma)
    -- sr_i = 1: B invertido (resta por complemento a dos)
    b_aux(0) <= b_i(0) xor sr_i;
    b_aux(1) <= b_i(1) xor sr_i;
    b_aux(2) <= b_i(2) xor sr_i;
    b_aux(3) <= b_i(3) xor sr_i;

    -- Sumador estructural de 4 bits
    SUM4: sum4b
        port map (
            a_i  => a_i,
            b_i  => b_aux,
            ci_i => sr_i,
            s_o  => s_o,
            co_o => co_o
        );

end sumrest4b_arq;
