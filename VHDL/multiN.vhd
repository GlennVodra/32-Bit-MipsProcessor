-------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          multiN.vhd
--
--  Entity:        multiN
--  Architecture:  STRUCTURAL
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Description:   The following is the entity and
--                 architectural description of
--                 a N bit Multiplier
-------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.globals.all;

entity multiN is 
    GENERIC (N : INTEGER:= 32); --bit width
    port(
        A, B : in std_logic_vector((N/2)-1 downto 0);
        Product : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture structural of multiN is 
	type D2Array is array(0 to (N/2)-1) of std_logic_vector(0 to (N/2)-1);

    signal ResultArray, CarryArray, AndArray : D2Array;  
begin
	
	Generate_AND_ARRAY_ROW : for i in 0 to (N/2)-1 generate
		Generate_AND_ARRAY_COL : for j in 0 to (N/2)-1 generate
				AndArray(i)(j) <= A(j) AND B(i);
		end generate Generate_AND_ARRAY_COL;
	end generate Generate_AND_ARRAY_ROW;
	
	product(0) <= AndArray(0)(0);
    
	Multiplier_ROW : for i in 1 to ((N/2)-1) generate
		Multiplier_COL : for j in 0 to ((N/2)-1) generate
			--Row 1 Column 0
			R1C0 : if((i = 1) and (j = 0)) generate
				R1C0_FAD : entity work.fadder
					port map (A => AndArray(i-1)(j+1), B => AndArray(i)(j), Cin => '0', 
					Sum => Product(i), Cout => CarryArray(i)(j));
				end generate R1C0;
			-- Row 1 Column Center
			R1CC : if((i = 1) and (j > 0) and (j < ((N/2)-1))) generate
				R1CC_FAD : entity work.fadder
					port map (A => AndArray(i-1)(j+1), B => AndArray(i)(j), Cin => CarryArray(i)(j-1), 
					Sum => ResultArray(i)(j), Cout => CarryArray(i)(j));
				end generate R1CC;
			-- Row 1 Column N/2-1
			R1CE : if((i = 1) and (j = (N/2)-1)) generate
				R1CE_FAD : entity work.fadder
					port map (A => '0', B => AndArray(i)(j), Cin => CarryArray(i)(j-1), 
					Sum => ResultArray(i)(j), Cout => CarryArray(i)(j));
				end generate R1CE;
------------------------------------------------			
			-- Row Center Column 0
			RCC0 : if((i > 1) and (i < (N/2)-1) and (j = 0)) generate
				RCC0_FAD : entity work.fadder
					port map (A => ResultArray(i-1)(j+1), B => AndArray(i)(j), Cin => '0', 
					Sum => Product(i), Cout => CarryArray(i)(j));
				end generate RCC0;
			-- Row Center Column Center
			RCCC : if((i > 1) and (i < (N/2)-1) and (j > 0) and (j < (N/2)-1)) generate
				RCCC_FAD : entity work.fadder
					port map (A => ResultArray(i-1)(j+1), B => AndArray(i)(j), Cin => CarryArray(i)(j-1), 
					Sum => ResultArray(i)(j), Cout => CarryArray(i)(j));
				end generate RCCC;
			-- Row Center Column N/2-1
			RCCE : if((i > 1) and (i < (N/2)-1) and (j = (N/2)-1)) generate
				RCCE_FAD : entity work.fadder
					port map (A => CarryArray(i-1)(j), B => AndArray(i)(j), Cin => CarryArray(i)(j-1), 
					Sum => ResultArray(i)(j), Cout => CarryArray(i)(j));
				end generate RCCE;
------------------------------------------------			
			-- Row N/2-1 Column 0
			REC0 : if((i = (N/2)-1) and (j = 0)) generate
				REC0_FAD : entity work.fadder
					port map (A => ResultArray(i-1)(j+1), B => AndArray(i)(j), Cin => '0', 
					Sum => Product(i), Cout => CarryArray(i)(j));
				end generate REC0;
			-- Row N/2-1 Column Center
			RECC : if((i = (N/2)-1) and (j > 0) and (j < (N/2)-1)) generate
				RECC_FAD : entity work.fadder
					port map (A => ResultArray(i-1)(j+1), B => AndArray(i)(j), Cin => CarryArray(i)(j-1), 
					Sum => ResultArray(i)(j), Cout => CarryArray(i)(j));
				end generate RECC;
			-- Row N/2-1 Column N/2-1
			RECE : if((i = (N/2)-1) and (j = (N/2)-1)) generate
				RECE_FAD : entity work.fadder
					port map (A => CarryArray(i-1)(j), B => AndArray(i)(j), Cin => CarryArray(i)(j-1),				
					Sum => Product(n-2), Cout => Product(n-1));
				end generate RECE;
		end generate Multiplier_COL;
    end generate Multiplier_ROW;
	
	-- P_Middle_Assign : process (ResultArray) is begin
		-- Product(N-3 downto N/2) <= ResultArray((N/2)-1)(1 to (N/2)-2);
	-- end process P_Middle_Assign;
	
	middle : for i in 1 to N/2-2 generate
    Product((N/2-1) + i) <= ResultArray((N/2)-1)(i);
end generate middle;
    
end structural;