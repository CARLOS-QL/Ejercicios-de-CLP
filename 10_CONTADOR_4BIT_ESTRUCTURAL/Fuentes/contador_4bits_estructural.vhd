library ieee;
use ieee.std_logic_1164.all;

entity contador_4bits_estructural is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        ena_i : in  std_logic;
        q_o   : out std_logic_vector(3 downto 0)
    );
end entity contador_4bits_estructural;

architecture estructural of contador_4bits_estructural is
    signal q : std_logic_vector(3 downto 0);
    signal d : std_logic_vector(3 downto 0);
begin
    -- Logica combinacional de proximo estado para contar +1 con ena_i=1.
    -- Usamos el FFD del ejercicio 5 con habilitacion permanente.
    d(0) <= q(0) xor ena_i;
    d(1) <= q(1) xor (ena_i and q(0));
    d(2) <= q(2) xor (ena_i and q(0) and q(1));
    d(3) <= q(3) xor (ena_i and q(0) and q(1) and q(2));

    FF0: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => '1', d_i => d(0), q_o => q(0));
    FF1: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => '1', d_i => d(1), q_o => q(1));
    FF2: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => '1', d_i => d(2), q_o => q(2));
    FF3: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => '1', d_i => d(3), q_o => q(3));

    q_o <= q;
end architecture estructural;
