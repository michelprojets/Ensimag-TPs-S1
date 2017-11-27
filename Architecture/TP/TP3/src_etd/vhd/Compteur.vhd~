library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Compteur is
    port (cpt : out unsigned(16 downto 0);
    -- Entree max ignorée pour la question 1.1
          max : in unsigned(16 downto 0);
          clk : in std_logic;
          rst : in std_logic);
end Compteur;

architecture mixte of Compteur is
-- A COMPLETER
  signal s1,s2: unsigned(16 downto 0);
-- Ajouter ici les signaux internes nécessaires
-- Declare l'existance de la bascule D
component bascule_d_nbits is
    generic(
      n: positive :=8
    );
    port (d : in unsigned(n-1 downto 0);
          q : out unsigned(n-1 downto 0);
          clk : in std_logic;
          rst : in std_logic);
end component;

begin
   i_cpt : bascule_d_nbits
     generic map (n => 17)
     port map ( clk => clk,
              d => s2,
              q => s1,
              rst => rst);
   s2 <= s1 + 1 when s1 <= max else "0" & x"0000";
   cpt <= s1;
-- A COMPLETER
end mixte;
