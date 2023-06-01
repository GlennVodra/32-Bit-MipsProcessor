-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--
-- Create Date : 1/31/23
-- Design Name : fadder
-- Module Name : fadder - dataflow
-- Project Name : ALU32
-- Target Devices : Basys3
--
-- Description : 1 bit fadder
-- ----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity fadder is port (
	a, b, cin : in std_logic;
	sum, cout : out std_logic
	);
end entity;

architecture dataflow of fadder is begin
	sum <= a xor b xor cin;
	cout <= (a and b) or (cin and a) or (cin and b);
end dataflow;