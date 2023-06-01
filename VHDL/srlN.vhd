-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Design Name : srlN
-- Module Name : srlN - behavioral
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : N-bit logical right shift (SRL) unit
-- ----------------------------------------------------

library IEEE ;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity srlN is
    GENERIC ( N : INTEGER := 32; --bit width
              M : INTEGER := 5); --shift bits
    PORT (
        A : IN std_logic_vector (N -1 downto 0);
        SHIFT_AMT : IN std_logic_vector (M-1 downto 0);
        Y : OUT std_logic_vector (N -1 downto 0)
) ;
end srlN;
architecture behavioral of srlN is
-- create array of vectors to hold each of n shifters
    type shifty_array is array (N-1 downto 0) of std_logic_vector (N-1 downto 0);
signal srlN : shifty_array;
begin
    generateSRL : for i in 0 to N-1 generate
        srlN (i) (N-1-i downto 0) <= A (N-1 downto i);
        right_fill : if i > 0 generate
            srlN(i)(N-1 downto N-i) <= (others => '0');
    end generate right_fill;
end generate generateSRL;

Y <= srlN(to_integer(unsigned(SHIFT_AMT)));
end behavioral;