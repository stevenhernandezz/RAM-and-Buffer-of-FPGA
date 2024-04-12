library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sync_rom_8_bits_tb is
end sync_rom_8_bits_tb;
 
architecture testbench of sync_rom_8_bits_tb is
    signal clk_tb       : std_logic := '0';
    signal addr_r_tb    : std_logic_vector(7 downto 0) := "00000000";
    signal data_tb      : std_logic_vector(3 downto 0);

    component sync_rom
        port (
            clk     : in  std_logic;
            addr_r  : in  std_logic_vector(7 downto 0);
            data    : out std_logic_vector(3 downto 0)
        );
    end component;

    constant clk_period : time := 10 ns;
    constant wait_time : time := 50 ns;
    
begin
    uut: sync_rom port map (
        clk     => clk_tb,
        addr_r  => addr_r_tb,
        data    => data_tb
    );

    -- Clock
    process
    begin
        while true loop
            clk_tb <= not clk_tb;
            wait for clk_period / 2;
        end loop;
    end process;

   --loop for rom
    process
    begin
        for i in 1 to 100 loop
            wait for wait_time;
            addr_r_tb <= std_logic_vector(to_unsigned(i, 8));
        end loop; 
        wait;           
    end process;

end testbench;