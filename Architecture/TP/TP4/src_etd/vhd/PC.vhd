library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
        port ( clk:    in  std_logic;
               reset:  in  std_logic;
               start: in  std_logic;
               inf  :  in std_logic;
               egal :  in  std_logic;
               getA:   out  std_logic;
               getB:   out  std_logic;
               subBA:  out  std_logic;
               ldA:    out  std_logic;
               ldB:    out  std_logic;
               done  : out  std_logic
       );
end PC;

architecture mixte of PC is
-- Déclaration des composants BDC et BDS
-- Aller voir ce qu'ils font dans le fichier .vhd correspondant.
   component BDC
      port ( C   : in    std_logic; 
             CLR : in    std_logic; 
             D   : in    std_logic; 
             Q   : out   std_logic
				 );
   end component;
   component BDS
      port ( C   : in    std_logic; 
             D   : in    std_logic; 
             S   : in    std_logic; 
             Q   : out   std_logic
				 );
   end component;


   signal dwait,  dinit, dtest, dAB, dBA, dfin  : std_logic;
   signal qwait, qinit, qtest, qAB, qBA, qfin  : std_logic;

begin
  WAITT: BDS
  port map ( C    =>   clk,
             D    =>   dwait, 
             S    =>   reset, 
             Q    =>   qwait);

  INIT: BDC
  port map ( C    =>   clk, 
             CLR  =>   reset, 
             D    =>   dinit,
             Q    =>   qinit );
  TEST: BDC
  port map ( C    =>   clk, 
             CLR  =>   reset, 
             D    =>   dtest,
             Q    =>   qtest );

  AB: BDC
  port map ( C    =>   clk, 
             CLR  =>   reset, 
             D    =>   dAB,
             Q    =>   qAB );

  BA: BDC
  port map ( C    =>   clk, 
             CLR  =>   reset, 
             D    =>   dBA,
             Q    =>   qBA );

  FIN : BDC
  port map ( C    =>   clk, 
             CLR  =>   reset, 
             D    =>   dfin,
             Q    =>   qfin );

  dwait <= (qwait and (not start)) or qfin;
  dinit <= qwait and start;
  dtest <= qinit or qAB or qBA;
  dAB <= qtest and (not egal) and (not inf);
  dBA <= qtest and (not egal) and inf;
  dfin <= qtest and egal;
  getA <= qinit;
  getB <= qinit;
  subBA <= qBA;
  ldA <= qinit or qAB;
  ldB <= qinit or qBA;
  done <= qfin;
     
end mixte;
