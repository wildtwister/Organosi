----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:24:42 05/03/2020 
-- Design Name: 
-- Module Name:    Top_MC - Behavioral 
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

entity Top_MC is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end Top_MC;

architecture Behavioral of Top_MC is

component MainMemory is
    Port ( CLK : in  STD_LOGIC;
           inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
           data_we : in  STD_LOGIC;
           data_din : in  STD_LOGIC_VECTOR (31 downto 0);
           data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           data_dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PROCESSOR_MC is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  FetchAddress: out STD_LOGIC_VECTOR(10 downto 0);
			  FetchedInstruction: in STD_LOGIC_VECTOR(31 downto 0);			  
			  MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal nextInstruction, mem_data_out, mem_write_data: STD_LOGIC_VECTOR (31 downto 0);
signal fetch_address, data_address: STD_LOGIC_VECTOR(10 downto 0);
signal mem_write_en: STD_LOGIC;

begin

my_memory: MainMemory Port Map (CLK, fetch_address, nextInstruction, mem_write_en, mem_write_data, data_address, mem_data_out);
processor: PROCESSOR_MC Port Map (RST, CLK,  fetch_address, nextInstruction, data_address, mem_write_en, mem_write_data, mem_data_out);

end Behavioral;

