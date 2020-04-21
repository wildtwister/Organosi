--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:31:25 04/21/2020
-- Design Name:   
-- Module Name:   /home/beast/workspace/OrganosiProject/reg_test.vhd
-- Project Name:  OrganosiProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SingleRegister
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
 
ENTITY reg_test IS
END reg_test;
 
ARCHITECTURE behavior OF reg_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SingleRegister
    PORT(
         WE : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         Dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal WE : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SingleRegister PORT MAP (
          WE => WE,
          RST => RST,
          CLK => CLK,
          Datain => Datain,
          Dataout => Dataout
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
		RST <= '1';
		WE <= '0';
      wait for 100 ns;	
		RST <= '0';
		
		Datain <= x"00000010";
		wait for 50 ns;
		
		Datain <= x"00000001";
		wait for 50 ns;
		
		WE <= '1';
		Datain <= x"00000010";
		wait for 50 ns;
		
		Datain <= x"00000001";
		wait for 50 ns;
		
		WE <= '0';
		Datain <= x"00000010";
		wait for 50 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
