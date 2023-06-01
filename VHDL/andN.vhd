-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Design Name : andN
-- Module Name : andN - dataflow
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : 32 bit AND
-- ----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity andN is
GENERIC (N : INTEGER:= 32); --bit width
PORT (
    A, B : IN std_logic_vector (N -1 downto 0);
    Y : OUT std_logic_vector (N -1 downto 0)
);
    end andN ;

architecture dataflow of andN is
begin
    Y <= A AND B;
end dataflow;