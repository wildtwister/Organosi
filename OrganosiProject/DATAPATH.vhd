----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:55 04/24/2020 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
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
end DATAPATH;

architecture Behavioral of DATAPATH is

component EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end component;

signal ALU_result: STD_LOGIC_VECTOR(31 downto 0);

component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  RST: in STD_LOGIC);
end component;

signal Ext_Immed,RF_A_sig, RF_B_sig : STD_LOGIC_VECTOR (31 downto 0);

component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--signal IF_PC_Addr :   STD_LOGIC_VECTOR (31 downto 0);

component MEMSTAGE is
    Port ( ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal MEM_Dout : STD_LOGIC_VECTOR (31 downto 0);

begin

if_stage: IFSTAGE Port Map(Ext_Immed, IF_PC_sel, IF_PC_LdEn, RST, CLK, IF_PC);
dec_stage:DECSTAGE Port Map (DEC_Instr, DEC_RF_WrEn, ALU_result, MEM_Dout, DEC_RF_WrData_sel, DEC_RF_B_sel, DEC_ImmExt, CLK, Ext_Immed, RF_A_sig, RF_B_sig, RST);
ex_stage:EXSTAGE Port Map (RF_A_sig, RF_B_sig, Ext_Immed, EX_ALU_Bin_sel, EX_ALU_func , ALU_result, EX_ALU_zero);
mem_stage:MEMSTAGE Port Map (MEM_ByteOp,  MEM_WrEn, ALU_result, RF_B_sig, MEM_Dout, MM_Addr, MM_WrEn, MM_WrData, MM_RdData);


end Behavioral;

