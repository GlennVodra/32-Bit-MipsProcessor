-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Design Name : sraN
-- Module Name : sraN - behavioral
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : N-bit arithmatic right shift (SRA) unit
-- ----------------------------------------------------

library IEEE ;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity sraN is
    GENERIC ( N : INTEGER := 32; --bit width
              M : INTEGER := 5); --shift bits
    PORT (
        A : IN std_logic_vector (N -1 downto 0);
        SHIFT_AMT : IN std_logic_vector (M-1 downto 0);
        Y : OUT std_logic_vector (N -1 downto 0)
) ;
end sraN;
architecture behavioral of sraN is
-- create array of vectors to hold each of n shifters
    type shifty_array is array (N-1 downto 0) of std_logic_vector (N-1 downto 0);
signal sraN : shifty_array;
begin
    generateSRA : for i in 0 to N-1 generate
        sraN (i) (N-1-i downto 0) <= A (N-1 downto i);
        right_fill : if i > 0 generate
            sraN(i)(N-1 downto N-i) <= (others => A(N-1));
    end generate right_fill;
end generate generateSRA;

Y <= sraN(to_integer(unsigned(SHIFT_AMT)));
end behavioral;