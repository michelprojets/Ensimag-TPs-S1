library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity global is
    port ( clk:     in  std_logic;
           reset:   in  std_logic;
--           lfsr_o:  out std_logic;
           s:       out std_logic
            );
end global;

architecture structural of global is
    component auto is
        port ( clk:     in  std_logic;
               reset:   in  std_logic;
               e:       in  std_logic;
               s:       out std_logic);
    end component;

    component lfsr is
        port ( clk:     in  std_logic;
               reset:   in  std_logic;
               s:       out std_logic);
    end component;

    signal lfsr_gen: std_logic;

    

begin
    
--    lfsr_o <= lfsr_gen;

    lfsr_1: lfsr
    port map (  clk     => clk,         -- Connexion du port ``clk'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``clk'' (entrée du composant lfsr). 
                s       => lfsr_gen,      -- Connexion du port ``q'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``q3''
                reset   => reset);      -- Connexion du port ``reset'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``reset'' (entrée du composant lfsr).
                                        --

    auto_1: auto
    port map (  clk     => clk,         -- Connexion du port ``clk'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``clk'' (entrée du composant lfsr).
                e       => lfsr_gen,      -- Connexion du port ``d'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``d2'' 
                s       => s,          -- Connexion du port ``q'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``q2''
                reset   => reset);      -- Connexion du port ``reset'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``reset'' (entrée du composant lfsr).
                                        --



end structural;

