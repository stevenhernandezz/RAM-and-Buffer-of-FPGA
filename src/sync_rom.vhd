library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sync_rom is
     port(clk : in std_logic;
     addr_r : in std_logic_vector(7 downto 0);
     data : out std_logic_vector(3 downto 0)
     );
end sync_rom;

architecture arch of sync_rom is
     constant ADDR_WIDTH : integer:=8;
     constant DATA_WIDTH : integer:=4;
     type rom_type is array (0 to 2**ADDR_WIDTH-1)
         of std_logic_vector(DATA_WIDTH-1 downto 0);
 
-- ROM definition
 constant HEX2LED_LOOK_UP_TABLE: rom_type:=( 
    -- 2^8-by-4
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1110" ,
    "1111" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "0001" ,
    "0000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1110" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0001" ,
    "0000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0010" ,
    "0001" ,
    "0000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0011" ,
    "0010" ,
    "0001" ,
    "0000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0100" ,
    "0011" ,
    "0010" ,
    "0001" ,
    "0000" ,
    "1001" ,
    "1010" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0101" ,
    "0100" ,
    "0011" ,
    "0010" ,
    "0001" ,
    "0000" ,
    "1001" ,
    "0111" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0110" ,
    "0101" ,
    "0100" ,
    "0011" ,
    "0010" ,
    "0001" ,
    "0000" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "0111" ,
    "0000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1110" ,
    "1111" ,
    "1001" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "0110" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1110" ,
    "1111" ,
    "1000" ,
    "1010" ,
    "1001" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "0101" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1110" ,
    "1111" ,
    "1000" ,
    "1001" ,
    "1011" ,
    "1010" ,
    "1001" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "0100" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1110" ,
    "1111" ,
    "1000" ,
    "1001" ,
    "1010" ,
    "1100" ,
    "1011" ,
    "1010" ,
    "1001" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "0011" ,
    "1100" ,
    "1101" ,
    "1110" ,
    "1111" ,
    "1000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1101" ,
    "1100" ,
    "1011" ,
    "1010" ,
    "1001" ,
    "0000" ,
    "0001" ,
    "0010" ,
    "1101" ,
    "1110" ,
    "1111" ,
    "1000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1110" ,
    "1101" ,
    "1100" ,
    "1011" ,
    "1010" ,
    "1001" ,
    "0000" ,
    "0001" ,
    "1110" ,
    "1111" ,
    "1000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1111" ,
    "1110" ,
    "1101" ,
    "1100" ,
    "1011" ,
    "1010" ,
    "1001" ,
    "0000" ,
    "1111" ,
    "1000" ,
    "1001" ,
    "1010" ,
    "1011" ,
    "1100" ,
    "1101" ,
    "1110"
     );
 signal rom : rom_type := HEX2LED_LOOK_UP_TABLE ;

begin
 process(clk)
     begin
     if (clk'event and clk = '1') then
     data <= rom(to_integer(unsigned(addr_r)));
     end if;
 end process;
end arch;

