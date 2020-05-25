--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:30:54 05/25/2020
-- Design Name:   
-- Module Name:   E:/Users/dlytis/Documents/organosi2/organosi2/PROC_MC_TEST.vhd
-- Project Name:  organosi2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROCESSOR_MC
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
 
ENTITY PROC_MC_TEST IS
END PROC_MC_TEST;
 
ARCHITECTURE behavior OF PROC_MC_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROCESSOR_MC
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         FetchAddress : OUT  std_logic_vector(10 downto 0);
         FetchedInstruction : IN  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(10 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal FetchedInstruction : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal FetchAddress : std_logic_vector(10 downto 0);
   signal MM_Addr : std_logic_vector(10 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROCESSOR_MC PORT MAP (
          RST => RST,
          CLK => CLK,
          FetchAddress => FetchAddress,
          FetchedInstruction => FetchedInstruction,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
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
		RST <='1';
		FetchedInstruction <= "00000000000000000000000000000000";
		MM_RdData<= "00000000000000000000000000000000";
      wait for 100 ns;	
		RST <='0';
		FetchedInstruction <= "11000000000001010000000000001000";
		MM_RdData<= "00000000000000000000000000000011";	
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
