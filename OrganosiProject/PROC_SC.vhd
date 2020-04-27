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

entity PROC_SC is
    Port ( RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Dout : out  STD_LOGIC_VECTOR (31 downto 0);
			  CurAddr : out  STD_LOGIC_VECTOR (10 downto 0));
end PROC_SC;

architecture Behavioral of PROC_SC is

component DATAPATH is
 Port ( EX_ALU_Bin_sel : in  STD_LOGIC;
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

signal ALU_zero, MM_WrEn: STD_LOGIC;
signal MM_WrData, PC : STD_LOGIC_VECTOR (31 downto 0);
signal  MM_Addr : STD_LOGIC_VECTOR (10 downto 0);

component CONTROL is
    Port ( EX_ALU_Bin_sel : out  STD_LOGIC;
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

signal ALU_Bin_sel, RF_WrEn, RF_WrData_sel, RF_B_sel, PC_sel, PC_LdEn, ByteOp, MEM_WrEn: STD_LOGIC;
signal Instruction: STD_LOGIC_VECTOR (31 downto 0);
signal ALU_func: STD_LOGIC_VECTOR (3 downto 0);
signal ImmExt : STD_LOGIC_VECTOR (1 downto 0);

component MainMemory is
    Port ( CLK : in  STD_LOGIC;
           inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
           data_we : in  STD_LOGIC;
           data_din : in  STD_LOGIC_VECTOR (31 downto 0);
           data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           data_dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal nextInstruction, data_out: STD_LOGIC_VECTOR (31 downto 0);


begin

my_datapath: DATAPATH Port Map (ALU_Bin_sel, ALU_func, ALU_zero, Instruction, RF_WrEn, RF_WrData_sel, RF_B_sel, ImmExt, PC_sel, PC_LdEn, PC, ByteOp, MM_WrEn, MM_Addr, MEM_WrEn, MM_WrData, data_out, RST, CLK);
my_control: CONTROL Port Map (ALU_Bin_sel, ALU_func, ALU_zero, nextInstruction, Instruction, RF_WrEn, RF_WrData_sel, RF_B_sel, ImmExt, PC_sel, PC_LdEn, ByteOp, MEM_WrEn, RST, CLK);
my_memory: MainMemory Port Map (CLK, PC(12 downto 2), nextInstruction, MM_WrEn, MM_WrData, MM_Addr, data_out);

Dout <= nextInstruction;
CurAddr <= PC(12 downto 2);

end Behavioral;

