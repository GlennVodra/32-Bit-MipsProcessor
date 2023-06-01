-- -------------------------------------------------
--  Company  : Rochester Institute of Technology (RIT)
--  Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          AddSubN.vhd
--
--  Entity:        AddSubN
--  Architecture:  structural
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Description:   The following is the entity and
--                 structural description of
--                 an addder/subtractor
----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.globals.all;

entity AddSubN is 
    GENERIC (N : INTEGER:= 32); --bit width
    port(
        A, B : in std_logic_vector(N-1 downto 0);
        OP : in std_logic;
        Sum : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture structural of AddSubN is 
    signal Bin : std_logic_vector(N-1 downto 0);
    signal Cout : std_logic_vector(N-1 downto 0);
begin


    Bin_proc: process (A, OP, B) is 
    begin
        if (OP = '1') then
            Bin <= NOT B;
        else
            Bin <= B;
        end if;
    end process;

        
    Adders : for i in 0 to N-1 generate
		First_Adder : if i = 0 generate
			First_Adder_inst : entity work.fadder
				port map(a => A(0), b => Bin(0), cin => OP, sum => Sum(0), Cout => Cout(0));
		end generate First_Adder;
	
		Other_Adders : if i /= 0 generate
			Other_Adder_inst : entity work.fadder
				port map(a => A(i), b => Bin(i), cin => Cout(i-1), sum => Sum(i), Cout => Cout(i));
		end generate Other_Adders;
    end generate Adders;

    
end structural;
