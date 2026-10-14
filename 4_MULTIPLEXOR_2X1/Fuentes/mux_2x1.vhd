library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is
    port (
        a_i   : in  std_logic;
        b_i   : in  std_logic;
        sel_i : in  std_logic;
        sal_o : out std_logic
    );
end entity mux_2x1;

architecture rtl of mux_2x1 is
begin
    sal_o <= a_i when sel_i = '0' else b_i;
end architecture rtl;
