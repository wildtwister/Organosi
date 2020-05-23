----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:56:36 05/23/2020 
-- Design Name: 
-- Module Name:    Forward - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Forward is
	port( PC_LdEn	: in STD_LOGIC;
			rs 		: in STD_LOGIC_VECTOR (4 downto 0);
			rt			: in STD_LOGIC_VECTOR (4 downto 0);
			rd_pipe2	: in STD_LOGIC_VECTOR (4 downto 0);
			En_pipe2	: in STD_LOGIC;
			rd_pipe3	: in STD_LOGIC_VECTOR (4 downto 0);
			En_pipe3	: in STD_LOGIC;
			A_sel		: out STD_LOGIC_VECTOR (1 downto 0);
			B_sel		: out STD_LOGIC_VECTOR (1 downto 0)
			);
end Forward;

architecture Behavioral of Forward is

begin

process(rs,rt,En_pipe2,En_pipe3)
begin
	if((rs = rd_pipe2 OR rt = rd_pipe2) AND En_pipe2 = '1' AND PC_LdEn = '1') then
		if(rs = rd_pipe2) then
			A_sel <= "01";
		else
			A_sel <= "00";
		end if;
		if(rt = rd_pipe2) then
			B_sel <= "01";
		else
			B_sel <= "00";
		end if;
	elsif((rs = rd_pipe3 OR rt = rd_pipe3) AND En_pipe3 = '1' AND PC_LdEn = '1') then
		if(rs = rd_pipe3) then
			A_sel <= "10";
		else
			A_sel <= "00";
		end if;
		if(rt = rd_pipe3) then
			B_sel <= "10";
		else
			B_sel <= "00";
		end if;
	else
		A_sel <= "00";
		B_sel <= "00";
	end if;
end process;

end Behavioral;

