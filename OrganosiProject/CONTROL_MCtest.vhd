--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:50:10 05/24/2020
-- Design Name:   
-- Module Name:   E:/Users/dlytis/Documents/organosi2/organosi2/CONTROL_MCtest.vhd
-- Project Name:  organosi2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
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
 
ENTITY CONTROL_MCtest IS
END CONTROL_MCtest;
 
ARCHITECTURE behavior OF CONTROL_MCtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         EX_ALU_Bin_sel : OUT  std_logic;
         EX_ALU_func : OUT  std_logic_vector(3 downto 0);
         EX_ALU_zero : IN  std_logic;
         Instruction : IN  std_logic_vector(31 downto 0);
         DEC_Instr : OUT  std_logic_vector(31 downto 0);
         DEC_RF_WrEn : OUT  std_logic;
         DEC_RF_WrData_sel : OUT  std_logic;
         DEC_RF_B_sel : OUT  std_logic;
         DEC_ImmExt : OUT  std_logic_vector(1 downto 0);
         IF_PC_sel : OUT  std_logic;
         IF_PC_LdEn : OUT  std_logic;
         MEM_ByteOp : OUT  std_logic;
         MEM_WrEn : OUT  std_logic;
         r_RF_A_WE : OUT  std_logic;
         r_RF_B_WE : OUT  std_logic;
         r_ALU_OUT_WE : OUT  std_logic;
         r_MEM_OUT_WE : OUT  std_logic;
         r_PC_WE : OUT  std_logic;
         r_Immed_WE : OUT  std_logic;
         r_MEM_DataOut_WE : OUT  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal EX_ALU_zero : std_logic := '0';
   signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal EX_ALU_Bin_sel : std_logic;
   signal EX_ALU_func : std_logic_vector(3 downto 0);
   signal DEC_Instr : std_logic_vector(31 downto 0);
   signal DEC_RF_WrEn : std_logic;
   signal DEC_RF_WrData_sel : std_logic;
   signal DEC_RF_B_sel : std_logic;
   signal DEC_ImmExt : std_logic_vector(1 downto 0);
   signal IF_PC_sel : std_logic;
   signal IF_PC_LdEn : std_logic;
   signal MEM_ByteOp : std_logic;
   signal MEM_WrEn : std_logic;
   signal r_RF_A_WE : std_logic;
   signal r_RF_B_WE : std_logic;
   signal r_ALU_OUT_WE : std_logic;
   signal r_MEM_OUT_WE : std_logic;
   signal r_PC_WE : std_logic;
   signal r_Immed_WE : std_logic;
   signal r_MEM_DataOut_WE : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          EX_ALU_Bin_sel => EX_ALU_Bin_sel,
          EX_ALU_func => EX_ALU_func,
          EX_ALU_zero => EX_ALU_zero,
          Instruction => Instruction,
          DEC_Instr => DEC_Instr,
          DEC_RF_WrEn => DEC_RF_WrEn,
          DEC_RF_WrData_sel => DEC_RF_WrData_sel,
          DEC_RF_B_sel => DEC_RF_B_sel,
          DEC_ImmExt => DEC_ImmExt,
          IF_PC_sel => IF_PC_sel,
          IF_PC_LdEn => IF_PC_LdEn,
          MEM_ByteOp => MEM_ByteOp,
          MEM_WrEn => MEM_WrEn,
          r_RF_A_WE => r_RF_A_WE,
          r_RF_B_WE => r_RF_B_WE,
          r_ALU_OUT_WE => r_ALU_OUT_WE,
          r_MEM_OUT_WE => r_MEM_OUT_WE,
          r_PC_WE => r_PC_WE,
          r_Immed_WE => r_Immed_WE,
          r_MEM_DataOut_WE => r_MEM_DataOut_WE,
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
		EX_ALU_zero <= '0';
		Instruction <= "00000000000000000000000000000000";
		RST <= '1';
      wait for 100 ns;	
		EX_ALU_zero <= '0';
		Instruction <= "00000000000000001110000000000000";
		RST <= '0';
      wait for 100 ns;	
		EX_ALU_zero <= '1';
		Instruction <= "11000000000000001110000000000000";
		RST <= '0';
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
