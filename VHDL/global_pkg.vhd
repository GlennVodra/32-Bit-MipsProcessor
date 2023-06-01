-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Package Name : globals
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : Constants used in top and test bench level
-- Xilinx does not like generics in the top level of a design
-- ----------------------------------------------------

library ieee;
use ieee . std_logic_1164 .all;
package globals is
constant N : INTEGER := 32;
constant M : INTEGER := 5;
end;