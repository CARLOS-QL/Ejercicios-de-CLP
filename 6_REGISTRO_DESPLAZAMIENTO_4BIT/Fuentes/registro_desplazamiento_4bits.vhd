library ieee;
use ieee.std_logic_1164.all;

-- Registro SISO de 4 bits con desplazamiento hacia la derecha.
-- Usa cuatro instancias del FFD del ejercicio anterior.
entity registro_desplazamiento_4bits is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        ena_i : in  std_logic;
        e_i   : in  std_logic;  -- Entrada serie
        s_o   : out std_logic   -- Salida serie
    );
end entity registro_desplazamiento_4bits;

architecture estructural of registro_desplazamiento_4bits is
    signal q : std_logic_vector(3 downto 0);
begin
    -- Desplazamiento: q(3) <= E; q(2) <= q(3);
    --                 q(1) <= q(2); q(0) <= q(1).
    FF3: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => ena_i,
                  d_i => e_i, q_o => q(3));

    FF2: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => ena_i,
                  d_i => q(3), q_o => q(2));

    FF1: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => ena_i,
                  d_i => q(2), q_o => q(1));

    FF0: entity work.ffd_sync_en(rtl)
        port map (clk_i => clk_i, rst_i => rst_i, ena_i => ena_i,
                  d_i => q(1), q_o => q(0));

    s_o <= q(0);
end architecture estructural;
