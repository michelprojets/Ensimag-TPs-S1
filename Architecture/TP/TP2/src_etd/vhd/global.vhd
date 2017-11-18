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
    port map (  clk     => clk,          
                s       => lfsr_gen,     
                reset   => reset);      

    auto_1: auto
    port map (  clk     => clk,        
                e       => lfsr_gen,     
                s       => s,        
                reset   => reset);     

end structural;

