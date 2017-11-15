library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity auto is
    port ( clk:     in  std_logic;
           reset:   in  std_logic;
           e:       in  std_logic;
           s:       out std_logic);
end auto;

architecture structural of auto is
    component bascule_D is
      port (  clk:    in  std_logic;
              d:      in  std_logic;
              q:      out std_logic;
              reset:  in  std_logic);
    end component;
    
    signal q2, q1, q0: std_logic;
    signal d2, d1, d0: std_logic;

begin

    FD2: bascule_D
    port map (  clk     => clk,         -- Connexion du port ``clk'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``clk'' (entrée du composant lfsr). 
                d       => d2,          -- Connexion du port ``d'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``d2''
                q       => q2,           -- Connexion du port ``q'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``q2''
                
                reset   => reset);      -- Connexion du port ``reset'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``reset'' (entrée du composant lfsr).
                                        --
    FD1: bascule_D
    port map (  clk     => clk,         -- Connexion du port ``clk'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``clk'' (entrée du composant lfsr).
                d       => d1,          -- Connexion du port ``d'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``d1'' 
                q       => q1,          -- Connexion du port ``q'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``q1''
                reset   => reset);      -- Connexion du port ``reset'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``reset'' (entrée du composant lfsr).
                                        --

    FD0: bascule_D
    port map (  clk     => clk,         -- Connexion du port ``clk'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``clk'' (entrée du composant lfsr).
                d       => q0,          -- Connexion du port ``d'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``q0'' 
                q       => q0,          -- Connexion du port ``q'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``q0''
                reset   => reset);      -- Connexion du port ``reset'' du
                                        -- composant ``bascule_D'' au signal
                                        -- ``reset'' (entrée du composant lfsr).

    s  <= q2;
    d0 <= (e and ((not q0) or (not q1)));
    d1 <= ((q1 and (not q0)) or ((not e) and (q2 or q0)));
    d2 <= (q1 and q0 and e);

end structural;
