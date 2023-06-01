-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Design Name : orN
-- Module Name : orN - dataflow
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : 32 bit OR
-- ----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity orN is
GENERIC (N : INTEGER:= 32); --bit width
PORT (
    A, B : IN std_logic_vector (N -1 downto 0);
    Y : OUT std_logic_vector (N -1 downto 0)
);
    end orN ;

architecture dataflow of orN is
begin
    Y <= A OR B;
end dataflow;