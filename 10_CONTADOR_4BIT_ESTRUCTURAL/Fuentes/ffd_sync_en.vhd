library ieee;
use ieee.std_logic_1164.all;

entity ffd_sync_en is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        ena_i : in  std_logic;
        d_i   : in  std_logic;
        q_o   : out std_logic
    );
end entity ffd_sync_en;

architecture rtl of ffd_sync_en is
    signal q_reg : std_logic := '0';
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                q_reg <= '0';
            elsif ena_i = '1' then
                q_reg <= d_i;
            end if;
        end if;
    end process;
    q_o <= q_reg;
end architecture rtl;
