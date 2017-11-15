library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bascule_D is
    port (  clk:    in  std_logic;
            d:      in  std_logic;
            q:      out std_logic;
            reset:  in  std_logic);

end bascule_D;

architecture behavioral of bascule_D is
begin
    process (clk,reset) 
    begin
        if reset='1' then
            q <= '0';
        elsif clk'event and clk='1' then
            q <= d;
        end if;
    end process;
end behavioral;
