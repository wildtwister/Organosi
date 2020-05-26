----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:55 04242020 
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

entity DATAPATH_PIPELINE is
  Port (EX_ALU_Bin_sel : in  STD_LOGIC;
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
	end DATAPATH_PIPELINE;

architecture Behavioral of DATAPATH_PIPELINE is

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

component SingleRegister is
    Port ( WE : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ClockedSingleRegister is
    Port ( WE : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal r_Immed, r_ALU_OUT, r_MEM_OUT, r_RF_A, r_RF_B, r_MEM_DataIn: STD_LOGIC_VECTOR (31 downto 0);

component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal IF_PC_Addr :   STD_LOGIC_VECTOR (31 downto 0);

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

component Forward is
	port(	p_DECEX	: in STD_LOGIC_VECTOR (31 downto 0);
				p_EXMEM	: in STD_LOGIC_VECTOR (31 downto 0);
				p_MEMWB : in STD_LOGIC_VECTOR (31 downto 0);
				A_sel		: out STD_LOGIC_VECTOR (1 downto 0);
				B_sel		: out STD_LOGIC_VECTOR (1 downto 0)
			);
end component;

signal MEM_Dout : STD_LOGIC_VECTOR (31 downto 0);

component Hazard is
			Port(	Clk : in STD_LOGIC;
						Reset	: in  STD_LOGIC;
						newInstruction: in STD_LOGIC_VECTOR (31 downto 0);
						p_DECEX: in STD_LOGIC_VECTOR (31 downto 0);
						IF_PC_LdEn : out STD_LOGIC;
						r_PC_En : out  STD_LOGIC;
						p_DECEX_En : out  STD_LOGIC;
						r_Immed_En : out  STD_LOGIC;
						r_RF_A_En  : out  STD_LOGIC;
						r_RF_B_En  : out  STD_LOGIC;											
						r_MEM_OUT_WE  : out  STD_LOGIC;		
						r_ALU_OUT_WE  : out  STD_LOGIC;		
						r_MEM_DataIn_WE  : out  STD_LOGIC);
end component;

 signal p_DECEX_En, p_EXMEM_En, p_MEMWB_En: STD_LOGIC;
 signal Control_Content, p_DECEX_Content, p_EXMEM_Content, p_MEMWB_Content : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal r_RF_A_WE, r_RF_B_WE, r_MEM_OUT_WE, r_ALU_OUT_WE, r_PC_WE, r_Immed_WE, r_MEM_DataIn_WE: STD_LOGIC ;
signal s_forward_A_sel, s_forward_B_sel : STD_LOGIC_VECTOR(1 downto 0);
signal s_forward_A, s_forward_B: STD_LOGIC_VECTOR (31 downto 0);
begin

 -- Pipe Registers <-------------------------------  										Control bits      								---------------------------------->
 -- pipe Content:  ALU_func | Alu_bin_select | MEM_ByteOp | MEM_WrEn| DEC_RF_WrEn | DEC_RF_WrData_sel | Rs | Rd | Rt
 --             				  (4 bits)			    (1 bit) 					(1 bit)  			 (1 bit) 			  	(1 bit) 							(1 bit)				   (5 bits each) = total 24bits

	GetControlContent: process(CLK, RST, EX_ALU_Bin_sel, EX_ALU_func, DEC_RF_WrEn, DEC_RF_WrData_sel, DEC_RF_B_sel, DEC_ImmExt, IF_PC_sel, IF_PC_LdEn, MEM_ByteOp, MEM_WrEn)
	begin 
		if RST = '1' then
			Control_Content <= (others => '0');
		else
			if rising_edge(CLK) then
				Control_Content <= (others => '0') & EX_ALU_func & EX_ALU_Bin_sel & MEM_ByteOp & MEM_WrEn & DEC_RF_WrData_sel & DEC_RF_B_sel & DEC_ImmExt & DEC_Instr(25 downto 11);
			end if;
		end if;
	end process;
	
	ForwardAMux: process(r_RF_A, r_MEM_OUT, r_ALU_OUT, s_forward_A_sel)
	begin
		if (s_forward_A_sel = "10") then
			s_forward_A <= r_ALU_OUT;
		elsif (s_forward_A_sel = "01") then
			s_forward_A <= r_MEM_OUT;
		else
			s_forward_A <= r_RF_A;
		end if;	
	end process;
	
	ForwardBMux: process(r_RF_B, r_MEM_OUT, r_ALU_OUT, s_forward_B_sel)
	begin
		if (s_forward_B_sel = "10") then
			s_forward_B <= r_ALU_OUT;
		elsif (s_forward_B_sel = "01") then
			s_forward_B <= r_MEM_OUT;
		else
			s_forward_B <= r_RF_B;
		end if;	
	end process;
	
	RAW_hazard: Hazard Port Map(
						CLK, 
						RST, 
						DEC_Instr, 
						p_DECEX_Content, 
						p_DECEX_En, 
						r_Immed_We,
						r_RF_A_WE,
						r_RF_B_WE,
						r_MEM_OUT_WE,
						r_ALU_OUT_WE,
						r_MEM_DataIn_WE
	);
 -- Registers moving 32bit values from module to module
	RF_A_Reg: ClockedSingleRegister Port Map(r_RF_A_WE, RST, CLK, RF_A_sig, r_RF_A);
	RF_B_Reg: ClockedSingleRegister Port Map(r_RF_B_WE, RST, CLK, RF_B_sig, r_RF_B);
	MEM_OUT_Reg: ClockedSingleRegister Port Map(r_MEM_OUT_WE, RST, CLK, MEM_Dout, r_MEM_OUT);
	ALU_OUT_Reg: ClockedSingleRegister Port Map(r_ALU_OUT_WE, RST, CLK, ALU_result, r_ALU_OUT);
	PC_Reg: ClockedSingleRegister Port Map(r_PC_WE, RST, CLK, IF_PC_Addr, IF_PC);
	Immed_Reg: ClockedSingleRegister Port Map(r_Immed_WE, RST, CLK, Ext_Immed, r_Immed);
	MEM_DataIn_Reg: ClockedSingleRegister Port Map(r_MEM_DataIn_WE, RST, CLK, r_RF_B, r_MEM_DataIn);

 DECEX_Pipe: ClockedSingleRegister Port Map(p_DECEX_En, RST, CLK, Control_content, p_DECEX_Content);
 EXMEM_Pipe: ClockedSingleRegister Port Map(p_EXMEM_En, RST, CLK, p_DECEX_Content, p_EXMEM_Content);
 MEMWB_Pipe: ClockedSingleRegister Port Map(p_MEMWB_En, RST, CLK, p_EXMEM_Content, p_MEMWB_Content);

-- Structural modules
if_stage: IFSTAGE Port Map(
					r_Immed, 
					IF_PC_sel, 
					IF_PC_LdEn, 
					RST, 
					CLK, 
					IF_PC_Addr
	);
dec_stage:DECSTAGE Port Map (
					DEC_Instr, 
					p_MEMWB_Content(16), 
					r_ALU_OUT,  
					r_MEM_OUT, 
					p_MEMWB_Content(15), 
					DEC_RF_B_sel, 
					DEC_ImmExt, 
					CLK, 
					Ext_Immed, 
					RF_A_sig, 
					RF_B_sig,
					RST
	);
ex_stage:EXSTAGE Port Map (
					r_RF_A, 
					r_RF_B, 
					r_Immed, 
					p_DECEX_Content(19), 
					p_DECEX_Content(23 downto 20) , 
					ALU_result, 
					EX_ALU_zero
	);
mem_stage:MEMSTAGE Port Map (
					p_EXMEM_Content(18),  
					p_EXMEM_Content(17), 
					r_ALU_OUT, 
					r_MEM_DataIn, 
					MEM_Dout, 
					MM_Addr, 
					MM_WrEn, 
					MM_WrData, 
					MM_RdData
	);

-- Forward and Stalling
forwrd: Forward Port Map (p_DECEX_Content, p_EXMEM_Content, p_MEMWB_Content, s_forward_A_sel, s_forward_B_sel);
end Behavioral;
