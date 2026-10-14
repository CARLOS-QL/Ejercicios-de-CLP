
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sum4b is
    Port (
        a_i  : in std_logic_vector(3 downto 0);
        b_i  : in std_logic_vector(3 downto 0);
        ci_i : in std_logic;
        s_o  : out std_logic_vector(3 downto 0);
        co_o : out std_logic
    );
end sum4b;

architecture sum4b_arq of sum4b is

    -- Parte declarativa

    -- Declaracion del componente
    component sum1b is
        Port (
            a_i  : in std_logic;
            b_i  : in std_logic;
            ci_i : in std_logic;
            s_o  : out std_logic;
            co_o : out std_logic
        );
    end component;

    -- Senales internas de acarreo
    signal aux : std_logic_vector(4 downto 0);

begin
    -- Parte descriptiva

    aux(0) <= ci_i;
    co_o <= aux(4);

    -- Sumador del bit 0
    sum1b_0: sum1b
        port map (
            a_i  => a_i(0),
            b_i  => b_i(0),
            ci_i => aux(0),
            s_o  => s_o(0),
            co_o => aux(1)
        );

    -- Sumador del bit 1
    sum1b_1: sum1b
        port map (
            a_i  => a_i(1),
            b_i  => b_i(1),
            ci_i => aux(1),
            s_o  => s_o(1),
            co_o => aux(2)
        );

    -- Sumador del bit 2
    sum1b_2: sum1b
        port map (
            a_i  => a_i(2),
            b_i  => b_i(2),
            ci_i => aux(2),
            s_o  => s_o(2),
            co_o => aux(3)
        );

    -- Sumador del bit 3
    sum1b_3: sum1b
        port map (
            a_i  => a_i(3),
            b_i  => b_i(3),
            ci_i => aux(3),
            s_o  => s_o(3),
            co_o => aux(4)
        );

end sum4b_arq;
