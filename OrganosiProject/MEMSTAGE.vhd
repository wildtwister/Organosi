----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:56:00 04/21/2020 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
    Port ( ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
			 
end MEMSTAGE;
architecture behavior of MEMSTAGE is
signal Bit_control :STD_LOGIC_VECTOR (1 downto 0);
signal AluMem11:STD_LOGIC_VECTOR (10 downto 0);
begin
	AluMem11<=ALU_MEM_Addr(12 downto 2);
	MM_WrEn <= MEM_WrEn;
	MM_Addr(10 downto 0)<=AluMem11 + 1024;
	Bit_control <= AluMem11(1 downto 0);
	process(ByteOp)
	begin
		if ByteOp = '0' then
			MM_WrData <= MEM_DataIn;
			MEM_DataOut <= MM_RdData;
		elsif ByteOp = '1' then
			if(Bit_control ="00") then
				MM_WrData <= x"000000" & MEM_DataIn(7 downto 0);
				MEM_DataOut <= x"000000" & MM_RdData(7 downto 0);
			elsif(Bit_control ="01") then
				MM_WrData <= x"000000" & MEM_DataIn(15 downto 8);
				MEM_DataOut <= x"000000" & MM_RdData(15 downto 8);		
			elsif(Bit_control ="10") then
				MM_WrData <= x"000000" & MEM_DataIn(23 downto 16);
				MEM_DataOut <= x"000000" & MM_RdData(23 downto 16);	
			elsif(Bit_control ="11") then
				MM_WrData <= x"000000" & MEM_DataIn(31 downto 24);
				MEM_DataOut <= x"000000" & MM_RdData(31 downto 24);
			else
			MM_WrData <= x"00000000";
			MEM_DataOut <= x"00000000";
			end if;
		else 
			MM_WrData <= x"00000000";
			MEM_DataOut <= x"00000000";
		end if;
	end process;	

end behavior;

