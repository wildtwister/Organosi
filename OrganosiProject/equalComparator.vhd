-- 12-bit equal comparator 
--
-- created by Kyprianos Papadimitriou, March 19, 2018
-- School of ECE, TU Crete, for the course Advanced Logic Design

library ieee;  
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity equalComparator12bit is
port(	in1			: in integer range 0 to 4095; 		
		in2			: in integer range 0 to 4095; 
		equalFlag	: out std_logic
		);
end equalComparator12bit;

architecture behavioral of equalComparator12bit is 
begin
	equalFlag 	<= 	'1' when (in1 = in2) else '0';	-- equalFlag is active high signal
end behavioral;



