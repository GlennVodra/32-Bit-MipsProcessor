-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Design Name : xorN
-- Module Name : xorN - dataflow
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : 32 bit XORs
-- ----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity xorN is
GENERIC (N : INTEGER:= 32); --bit width
PORT (
    A, B : IN std_logic_vector (N -1 downto 0);
    Y : OUT std_logic_vector (N -1 downto 0)
);
    end xorN ;

architecture dataflow of xorN is
begin
    Y <= A XOR B;
end dataflow;