-------------------------------------------------
-- Company  : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          ControlUnit.vhd
--
--  Entity:        ControlUnit
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Description:   The following is the entity and
--                 architectural description of
--                 Control Unit
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is 
	port(
		Opcode, Funct : in std_logic_vector(5 downto 0);
		RegWrite, MemtoReg, MemWrite, ALUSrc, RegDst : out std_logic;
		ALUControl : out std_logic_vector(3 downto 0)
	);
end ControlUnit;

architecture BEHAVIORAL of ControlUnit is

begin

	driveRegWrite : process (Opcode) is begin
		case Opcode is 
			when "000000" => RegWrite <= '1';
			when "001000" => RegWrite <= '1';
			when "001100" => RegWrite <= '1';
			when "001101" => RegWrite <= '1';
			when "001110" => RegWrite <= '1';
			when "101011" => RegWrite <= '0';
			when "100011" => RegWrite <= '1';
			when others => RegWrite <= '0';
		end case;
	end process;
	
	driveMemtoReg : process (Opcode) is begin
		case Opcode is
			when "100011" => MemtoReg <= '1';
			when others => MemtoReg <= '0';
		end case;
	end process;
	
	
	driveMemWrite : process (Opcode) is begin
		case Opcode is
			when "101011" => MemWrite <= '1';
			when others => MemWrite <= '0';
		end case;
	end process;
	
	driveALUSrc : process (Opcode) is begin
		case Opcode is
			when "001000" => ALUSrc <= '1';
			when "001100" => ALUSrc <= '1';
			when "001101" => ALUSrc <= '1';
			when "001110" => ALUSrc <= '1';
			when "101011" => ALUSrc <= '1';
			when "100011" => ALUSrc <= '1';
			when others => ALUSrc <= '0';
		end case;
	end process;
	
	driveRegDst : process (Opcode) is begin
		case Opcode is
			when "000000" => RegDst <= '1';
			when "100011" => RegDst <= '0';
			when "001000" => RegDst <= '0';
			when "001100" => RegDst <= '0';
			when "001101" => RegDst <= '0';
			when "001110" => RegDst <= '0';
			when others => RegDst <= '0';
		end case;
	end process;
	
	driveALUControl : process (Opcode, Funct) is begin
		case Opcode is
			when "000000" => 
				if (Funct = "100000") then
					ALUControl <= "0100";
				elsif (Funct =  "100100") then
					ALUControl <= "1010";
				elsif (Funct =  "011001") then
					ALUControl <= "0110";
				elsif (Funct =  "100101") then
					ALUControl <= "1000";
				elsif (Funct =  "000000") then
					ALUControl <= "1100";
				elsif (Funct =  "000011") then
					ALUControl <= "1110";
				elsif (Funct =  "000010") then
					ALUControl <= "1101";
				elsif (Funct =  "100010") then
					ALUControl <= "0101";
				elsif (Funct =  "100110") then
					ALUControl <= "1011";
				else
					ALUControl <= "0000";
				end if;
			when "001000" => ALUControl <= "0100";
			when "001100" => ALUControl <= "1010";
			when "001101" => ALUControl <= "1000";
			when "001110" => ALUControl <= "1011";
			when "101011" => ALUControl <= "0100";
			when "100011" => ALUControl <= "0100";
			when others => ALUControl <= "0000";
		end case;
	end process;
	
end BEHAVIORAL;	