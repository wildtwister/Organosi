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
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
			 
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is
signal Alu_Adress:STD_LOGIC_VECTOR(10 downto 0);
signal Bit_control:STD_LOGIC_VECTOR(3 downto 0);
signal DatatoWrite: STD_LOGIC_VECTOR(31 downto 0);
signal DatatoRead:STD_LOGIC_VECTOR(31 downto 0);
signal Memread : STD_LOGIC_VECTOR(31 downto 0);


begin
DatatoWrite <= MEM_DataIn;
DatatoRead<=MM_RdData;
Alu_Adress<=ALU_MEM_Addr(12 downto 2);
Bit_control<=ALU_MEM_Addr(1 downto 0);
memstage:Process(ByteOp,Alu_Adress,Bit_control,DatatoRead,DatatoWrite)
begin
	if (ByteOp='0')then
		MM_Addr<= Alu_Adress;
		if(Mem_WrEn='1')then
			MM_WrEn <=Mem_WrEn;
			MM_WrData <=DatatoWrite;
		elsif(Mem_WrEn='0')then
			MM_WrEn <=Mem_WrEn;
			DatatoRead <= DatatoWrite;
		else 
		DatatoRead <=x"0000000";
		end if;
	elsif(ByteOp='1')then
		MM_Addr<=Alu_Adress;
				if (Bit_control = "00") then
					if(Mem_WrEn='1')then
						MM_WrEn <=Mem_WrEn;
						MM_WrData <=  MEM_DataIn (31 downto 8)&DatatoWrite(7 downto 0);
					elsif(Mem_WrEn='0')then
						MM_WrEn <=Mem_WrEn;
						DatatoRead <= x"0000000"&DatatoWrite(7 downto 0);
					else
						DatatoRead<=x"0000000";
					end if;
				elsif (Bit_control = "01") then
					if(Mem_WrEn='1')then
						MM_WrEn <=Mem_WrEn;
						MM_WrData <=  MEM_DataIn (31 downto 16)&DatatoWrite(15 downto 8)&MEM_DataIn (7 downto 0);
					elsif(Mem_WrEn='0')then
						MM_WrEn <=Mem_WrEn;
						DatatoRead <= x"0000000"&DatatoWrite(15 downto 8);
					else
						DatatoRead<=x"0000000";
					end if;
				elsif (Bit_control = "10") then
					if(Mem_WrEn='1')then
						MM_WrEn <=Mem_WrEn;
						MM_WrData <=  MEM_DataIn (31 downto 23)&DatatoWrite(23 downto 16)&MEM_DataIn (15 downto 0);
					elsif(Mem_WrEn='0')then
						MM_WrEn <=Mem_WrEn;
						DatatoRead <= x"0000000"&DatatoWrite(23 downto 16);
					else
						DatatoRead <=x"0000000";
					end if;
				elsif (Bit_control = "11" ) then
					if(Mem_WrEn='1')then
						MM_WrEn <=Mem_WrEn;
						MM_WrData <= DatatoWrite(31 downto 23) &DatatoWrite(31 downto 24);
					elsif(Mem_WrEn='0')then
						MM_WrEn <=Mem_WrEn;
						DatatoRead <= x"0000000"&DatatoWrite(31 downto 24);
					else
						DatatoRead <=x"0000000";
					end if;
				else 
					MM_WrData<=x"0000000";
				end if;
	else 
		MM_Addr<="00000000000";
	end if;		
end Process memstage;
MEM_DataOut<=DatatoRead;
end Behavioral;

