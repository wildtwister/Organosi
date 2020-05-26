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
	port(	p_DECEX	: in STD_LOGIC_VECTOR (31 downto 0);
				p_EXMEM	: in STD_LOGIC_VECTOR (31 downto 0);
				p_MEMWB : in STD_LOGIC_VECTOR (31 downto 0);
				A_sel		: out STD_LOGIC_VECTOR (1 downto 0);
				B_sel		: out STD_LOGIC_VECTOR (1 downto 0)
			);
end Forward;

architecture Behavioral of Forward is
signal s_DEC_Rs, s_DEC_Rt, s_EX_Rd, s_MEM_Rd: STD_LOGIC_VECTOR (4 downto 0);
signal s_EX_WrReg, s_MEM_WrReg : STD_LOGIC;
begin

s_EX_WrReg <= p_EXMEM(16);
s_MEM_WrReg <= p_MEMWB(16);
s_DEC_Rs <= p_DECEX( 14 downto 10 );
s_DEC_Rt <= p_DECEX( 4 downto 0 );
s_EX_Rd <= p_EXMEM( 9 downto 5 );
s_MEM_Rd <= p_MEMWB( 9 downto 5 );
process( s_DEC_Rs, s_DEC_Rt, s_EX_Rd, s_MEM_Rd,s_EX_WrReg, s_MEM_WrReg)
begin

	-- Forward A
	if((s_EX_WrReg = '1') AND (s_EX_Rd /= "00000") AND (s_DEC_Rs = s_EX_Rd)) then
		A_sel <= "10";
	elsif((s_MEM_WrReg = '1') AND (s_MEM_Rd /= "00000") AND (s_DEC_Rs = s_MEM_Rd)) then
		A_sel <= "01";
	else
		A_sel <= "00";
	end if;
	
	-- Forward B
	if((s_EX_WrReg = '1') AND (s_EX_Rd /= "00000") AND (s_DEC_Rt = s_EX_Rd)) then
		B_sel <= "10";
	elsif((s_MEM_WrReg = '1') AND (s_MEM_Rd /= "00000") AND (s_DEC_Rt = s_MEM_Rd)) then
		B_sel <= "01";
	else
		B_sel <= "00";
	end if;
end process;

end Behavioral;

