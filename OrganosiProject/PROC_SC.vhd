----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:01:16 04/24/2020 
-- Design Name: 
-- Module Name:    PROC_SC - Behavioral 
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

entity PROCESSOR_MC is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  FetchAddress: out STD_LOGIC_VECTOR(10 downto 0);
			  FetchedInstruction: in STD_LOGIC_VECTOR(31 downto 0);
			  MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end PROCESSOR_MC;
architecture Behavioral of PROCESSOR_MC is

component DATAPATH_MC is
 Port ( r_RF_A_WE : in  STD_LOGIC;
		     r_RF_B_WE : in  STD_LOGIC;
			  r_ALU_OUT_WE : in  STD_LOGIC;
		     r_MEM_OUT_WE : in  STD_LOGIC;
			  r_PC_WE : in  STD_LOGIC;
			  r_Immed_WE : in  STD_LOGIC;
			  r_MEM_DataIn_WE : in  STD_LOGIC;
			  r_MEM_DataOut_WE : in  STD_LOGIC;
			  EX_ALU_Bin_sel : in  STD_LOGIC;
           EX_ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           EX_ALU_zero : out  STD_LOGIC;
			  DEC_Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           DEC_RF_WrEn : in  STD_LOGIC;
           DEC_RF_WrData_sel : in  STD_LOGIC;
           DEC_RF_B_sel : in  STD_LOGIC;
           DEC_ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           IF_PC_sel : in  STD_LOGIC;
           IF_PC_LdEn : in  STD_LOGIC;
           IF_PC : out  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_ByteOp : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC);
end component;

signal ALU_zero, s_MM_WrEn: STD_LOGIC;
signal s_MM_WrData, PC : STD_LOGIC_VECTOR(31 downto 0);
signal s_MM_Addr : STD_LOGIC_VECTOR(10 downto 0);

component CONTROL is
    Port ( 
			  r_RF_A_WE : out  STD_LOGIC;
		     r_RF_B_WE : out  STD_LOGIC;
			  r_ALU_OUT_WE : out  STD_LOGIC;
		     r_MEM_OUT_WE : out  STD_LOGIC;
			  r_PC_WE : out  STD_LOGIC;
			  r_Immed_WE : out  STD_LOGIC;
			  r_MEM_DataIn_WE : out  STD_LOGIC;
			  r_MEM_DataOut_WE : out  STD_LOGIC;
			  EX_ALU_Bin_sel : out  STD_LOGIC;
           EX_ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           EX_ALU_zero : in  STD_LOGIC;
			  Instruction : in STD_LOGIC_VECTOR (31 downto 0);
			  DEC_Instr : out  STD_LOGIC_VECTOR (31 downto 0);
           DEC_RF_WrEn : out  STD_LOGIC;
           DEC_RF_WrData_sel : out  STD_LOGIC;
           DEC_RF_B_sel : out  STD_LOGIC;
           DEC_ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
           IF_PC_sel : out  STD_LOGIC;
           IF_PC_LdEn : out  STD_LOGIC;
			  MEM_ByteOp : out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC;
           RST : in STD_LOGIC;
			  CLK : in STD_LOGIC);
end component;

signal  r_RF_A_WE , r_RF_B_WE, r_ALU_OUT_WE, r_MEM_OUT_WE , r_PC_WE, r_Immed_WE, r_MEM_DataIn_WE, r_MEM_DataOut_WE ,ALU_Bin_sel, RF_WrEn, RF_WrData_sel, RF_B_sel, PC_sel, PC_LdEn, ByteOp, MEM_WrEn: STD_LOGIC;
signal Instruction: STD_LOGIC_VECTOR (31 downto 0);
signal ALU_func: STD_LOGIC_VECTOR (3 downto 0);
signal ImmExt : STD_LOGIC_VECTOR (1 downto 0);

begin

my_datapath: DATAPATH_MC Port Map (
			r_RF_A_WE , 
			r_RF_B_WE, 
			r_ALU_OUT_WE, 
			r_MEM_OUT_WE , 
			r_PC_WE, 
			r_Immed_WE, 
			r_MEM_DataIn_WE,
			r_MEM_DataOut_WE,
			ALU_Bin_sel,
			ALU_func, 
			ALU_zero, 
			Instruction, 
			RF_WrEn, 
			RF_WrData_sel, 
			RF_B_sel, 
			ImmExt, 
			PC_sel, 
			PC_LdEn, 
			PC, 
			ByteOp, 
			MEM_WrEn, 
			s_MM_Addr, 
			s_MM_WrEn, 
			s_MM_WrData, 
			MM_RdData, 
			RST, 
			CLK);
			
my_control: CONTROL Port Map ( 
			r_RF_A_WE , 
			r_RF_B_WE, 
			r_ALU_OUT_WE, 
			r_MEM_OUT_WE , 
			r_PC_WE, 
			r_Immed_WE, 
			r_MEM_DataIn_WE, 
			r_MEM_DataOut_WE, 
			ALU_Bin_sel, 
			ALU_func, 
			ALU_zero, 
			FetchedInstruction, 
			Instruction, 
			RF_WrEn, 
			RF_WrData_sel, 
			RF_B_sel, 
			ImmExt, 
			PC_sel, 
			PC_LdEn, 
			ByteOp, 
			MEM_WrEn, 
			RST, 
			CLK);
			
MM_Addr <= s_MM_Addr;
MM_WrEn <= s_MM_WrEn;
MM_WrData <= s_MM_WrData;
FetchAddress <= PC(12 downto 2);

end Behavioral;

