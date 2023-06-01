-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Design Name : alu32
-- Module Name : alu32 - structural
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : Full 32 -bit Arithmetic Logic Unit

--      |OPcode|   |       Opperation      |
--      | 1000 |   |Logical OR             |
--      | 1010 |   |Logical AND            |
--      | 1011 |   |Logical XOR            |
--      | 1100 |   |Logical SHIFT LEFT     |
--      | 1101 |   |Logical LOG SHIFT RIGTH|
--      | 1110 |   |Logical ARI SHIFT RIGHT|
-- ----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.globals.all; -- provides N and M to top level
entity alu32 is
    PORT (
        A : IN std_logic_vector (N-1 downto 0);
        B : IN std_logic_vector (N-1 downto 0);
        OP : IN std_logic_vector(3 downto 0);
        Y : OUT std_logic_vector (N-1 downto 0)
    );
end alu32 ;
architecture structural of alu32 is 
    signal OR_result        : std_logic_vector (N-1 downto 0);
    signal AND_result       : std_logic_vector (N-1 downto 0);
    signal XOR_result       : std_logic_vector (N-1 downto 0);
    signal SLL_result       : std_logic_vector (N-1 downto 0);
    signal SRL_result       : std_logic_vector (N-1 downto 0);
    signal SRA_result       : std_logic_vector (N-1 downto 0);
	signal ADD_SUB_RESULT   : std_logic_vector (N-1 downto 0);
	signal MULTI_result     : std_logic_vector (N-1 downto 0);
begin
-- Instantiate the OR
    or_comp : entity work.orN
        generic map (N => N)
        port map (A => A , B => B, Y => OR_result);
-- Instantiate the AND
    and_comp : entity work.andN
        generic map (N => N)
        port map (A => A , B => B, Y => AND_result);
-- Instantiate the XOR
    xor_comp : entity work.xorN
        generic map (N => N)
        port map (A => A , B => B, Y => XOR_result);
-- Instantiate the SLL
    sll_comp : entity work.sllN
        generic map (N => N, M => M)
        port map (A => A , SHIFT_AMT => B (M -1 downto 0), Y => SLL_result);
-- Instantiate the SRL
    srl_comp : entity work.srlN
        generic map (N => N, M => M)
        port map (A => A , SHIFT_AMT => B (M -1 downto 0), Y => SRL_result);
-- Instantiate the SRA
    sra_comp : entity work.sraN
        generic map (N => N, M => M)
        port map (A => A , SHIFT_AMT => B (M -1 downto 0), Y => SRA_result);
-- Instantiate the ADD	
	ADD_SUB_comp : entity work.AddSubN
		generic map (N => N)
		port map (A => A, B => B, OP => OP(0), Sum => ADD_SUB_RESULT);
-- Instantiate the MULTI	
	MULTI_comp : entity work.MultiN
		generic map (N => N)
		port map (A => A((N/2)-1 downto 0), B => B((N/2)-1 downto 0), Product => MULTI_result);
	

-- Use OP to control which operation to show / perform
    WITH OP select
    Y <= OR_result       when "1000",
        AND_result       when "1010",
        XOR_result       when "1011",
        SLL_result       when "1100",
        SRL_result       when "1101",
        SRA_result       when "1110",
--Lab 4 Adder and Multiplier
		ADD_SUB_RESULT   when "0100",
		ADD_SUB_RESULT   when "0101",
		MULTI_result     when "0110",
        (others => '0')  when others;
end structural;
