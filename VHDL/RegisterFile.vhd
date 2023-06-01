-------------------------------------------------
--  File:          RegisterFile.vhd
--
--  Entity:        RegisterFile
--  Architecture:  oh_behave
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Modified:
--  VHDL'08
--  Description:   The following is the entity and
--                 architectural description of
--                 Register File
-------------------------------------------------

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is 
    generic(
        BIT_DEPTH : integer := 32;
        LOG_PORT_DEPTH : integer := 5
    );
    port(
	addr1, addr2 : in std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
	addr3 : in std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
	wd : in std_logic_vector(BIT_DEPTH-1 downto 0);
	clk, we : in std_logic;
	RD1, RD2 : out std_logic_vector(BIT_DEPTH-1 downto 0)
	);
end entity RegisterFile;

architecture oh_behave of RegisterFile is

	type mem_type is array (0 to (2**LOG_PORT_DEPTH-1)) of std_logic_vector(BIT_DEPTH-1 downto 0);

	signal regDat : mem_type := (others => (others => '0'));

begin 
	reg : process (clk) is begin
		if(falling_edge(clk)) then 
			if(we = '1'  AND (to_integer(unsigned(addr3)) /= 0)) then
				regDat(to_integer(unsigned(addr3))) <= wd;
			end if;
		end if;
	end process reg;
	
	RD1 <= regDat(to_integer(unsigned(addr1)));
    RD2 <= regDat(to_integer(unsigned(addr2)));
end	oh_behave;	
