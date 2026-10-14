library ieee;
use ieee.std_logic_1164.all;

entity registro_4bits_comp is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        ena_i : in  std_logic;
        e_i   : in  std_logic;
        s_o   : out std_logic
    );
end entity;

architecture behavioral of registro_4bits_comp is
    signal q : std_logic_vector(3 downto 0) := "0000";
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                q <= "0000";
            elsif ena_i = '1' then
                q <= e_i & q(3 downto 1);
            end if;
        end if;
    end process;
    s_o <= q(0);
end architecture;
