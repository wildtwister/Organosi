--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:13:37 05/24/2020
-- Design Name:   
-- Module Name:   E:/Users/dlytis/Documents/organosi2/organosi2/DATAPATH_MC_test.vhd
-- Project Name:  organosi2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH_MC
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DATAPATH_MC_test IS
END DATAPATH_MC_test;
 
ARCHITECTURE behavior OF DATAPATH_MC_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH_MC
    PORT(
         r_RF_A_WE : IN  std_logic;
         r_RF_B_WE : IN  std_logic;
         r_ALU_OUT_WE : IN  std_logic;
         r_MEM_OUT_WE : IN  std_logic;
         r_PC_WE : IN  std_logic;
         r_Immed_WE : IN  std_logic;
			r_MEM_DataIn_WE : IN  std_logic;
         r_MEM_DataOut_WE : IN  std_logic;
         EX_ALU_Bin_sel : IN  std_logic;
         EX_ALU_func : IN  std_logic_vector(3 downto 0);
         EX_ALU_zero : OUT  std_logic;
         DEC_Instr : IN  std_logic_vector(31 downto 0);
         DEC_RF_WrEn : IN  std_logic;
         DEC_RF_WrData_sel : IN  std_logic;
         DEC_RF_B_sel : IN  std_logic;
         DEC_ImmExt : IN  std_logic_vector(1 downto 0);
         IF_PC_sel : IN  std_logic;
         IF_PC_LdEn : IN  std_logic;
         IF_PC : OUT  std_logic_vector(31 downto 0);
         MEM_ByteOp : IN  std_logic;
         MEM_WrEn : IN  std_logic;
         MM_Addr : OUT  std_logic_vector(10 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
                                              

   --Inputs
   signal r_RF_A_WE : std_logic := '0';
   signal r_RF_B_WE : std_logic := '0';
   signal r_ALU_OUT_WE : std_logic := '0';
   signal r_MEM_OUT_WE : std_logic := '0';
   signal r_PC_WE : std_logic := '0';
   signal r_Immed_WE : std_logic := '0';
	signal r_MEM_DataIn_WE : std_logic := '0';
   signal r_MEM_DataOut_WE : std_logic := '0';
   signal EX_ALU_Bin_sel : std_logic := '0';
   signal EX_ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal DEC_Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal DEC_RF_WrEn : std_logic := '0';
   signal DEC_RF_WrData_sel : std_logic := '0';
   signal DEC_RF_B_sel : std_logic := '0';
   signal DEC_ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal IF_PC_sel : std_logic := '0';
   signal IF_PC_LdEn : std_logic := '0';
   signal MEM_ByteOp : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal EX_ALU_zero : std_logic;
   signal IF_PC : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(10 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH_MC PORT MAP (
          r_RF_A_WE => r_RF_A_WE,
          r_RF_B_WE => r_RF_B_WE,
          r_ALU_OUT_WE => r_ALU_OUT_WE,
          r_MEM_OUT_WE => r_MEM_OUT_WE,
          r_PC_WE => r_PC_WE,
          r_Immed_WE => r_Immed_WE,
			 r_MEM_DataIn_WE => r_MEM_DataIn_WE,
          r_MEM_DataOut_WE => r_MEM_DataOut_WE,
          EX_ALU_Bin_sel => EX_ALU_Bin_sel,
          EX_ALU_func => EX_ALU_func,
          EX_ALU_zero => EX_ALU_zero,
          DEC_Instr => DEC_Instr,
          DEC_RF_WrEn => DEC_RF_WrEn,
          DEC_RF_WrData_sel => DEC_RF_WrData_sel,
          DEC_RF_B_sel => DEC_RF_B_sel,
          DEC_ImmExt => DEC_ImmExt,
          IF_PC_sel => IF_PC_sel,
          IF_PC_LdEn => IF_PC_LdEn,
          IF_PC => IF_PC,
          MEM_ByteOp => MEM_ByteOp,
          MEM_WrEn => MEM_WrEn,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData,
          RST => RST,
          CLK => CLK
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.

			r_RF_A_WE <='0';
			r_RF_B_WE <='0';
			r_ALU_OUT_WE <= '0';
			r_MEM_OUT_WE <='0';
			r_PC_WE <='0';
			r_Immed_WE <='0';
			r_MEM_DataOut_WE <='0';
			EX_ALU_Bin_sel <='0';
			EX_ALU_func <="0000";
			DEC_Instr <= "00000000000000000000000000000000";
			DEC_RF_WrEn <= '0';
			DEC_RF_WrData_sel <='0';
			DEC_RF_B_sel <='0';
			DEC_ImmExt <= "00";
			IF_PC_sel <= '0';
			IF_PC_LdEn <='0';
			MEM_ByteOp <='0';
			MEM_WrEn <='0';
			MM_RdData <="00000000000000000000000000000000";
			RST <='1';
		wait for 100 ns;
			r_RF_A_WE <='1';
			r_RF_B_WE <='0';
			r_ALU_OUT_WE <= '0';
			r_MEM_OUT_WE <='1';
			r_PC_WE <='0';
			r_Immed_WE <='1';
			r_MEM_DataOut_WE <='0';
			EX_ALU_Bin_sel <='0';
			EX_ALU_func <="0000";
			DEC_Instr <= "00000000000000000000000011111100";
			DEC_RF_WrEn <= '0';
			DEC_RF_WrData_sel <='0';
			DEC_RF_B_sel <='0';
			DEC_ImmExt <= "11";
			IF_PC_sel <= '0';
			IF_PC_LdEn <='1';
			MEM_ByteOp <='0';
			MEM_WrEn <='1';
			MM_RdData <="00000000000011111100000000000000";
			RST <='0';
		wait for 100 ns;
			r_RF_A_WE <='0';
			r_RF_B_WE <='1';
			r_ALU_OUT_WE <= '0';
			r_MEM_OUT_WE <='1';
			r_PC_WE <='0';
			r_Immed_WE <='1';
			r_MEM_DataOut_WE <='0';
			EX_ALU_Bin_sel <='0';
			EX_ALU_func <="0000";
			DEC_Instr <= "11000000000000000000000011111100";
			DEC_RF_WrEn <= '0';
			DEC_RF_WrData_sel <='0';
			DEC_RF_B_sel <='0';
			DEC_ImmExt <= "01";
			IF_PC_sel <= '0';
			IF_PC_LdEn <='1';
			MEM_ByteOp <='0';
			MEM_WrEn <='1';
			MM_RdData <="00001100000011111100000000000000";
			RST <='0';
		wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
