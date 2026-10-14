

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity sum1b is
    Port (
        a_i : in STD_LOGIC;
        b_i : in STD_LOGIC;
        ci_i : in STD_LOGIC;
        s_o : out STD_LOGIC;
        co_o : out STD_LOGIC
        );
end sum1b;

architecture sum1b_arq of sum1b is
         -- Parte declarativa
begin
     -- Parte descriptiva
    s_o  <= a_i xor b_i xor ci_i;
    co_o <= (a_i and b_i) or (a_i and ci_i) or (b_i and ci_i);

end sum1b_arq;
