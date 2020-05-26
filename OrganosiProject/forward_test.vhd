--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:19:02 05/26/2020
-- Design Name:   
-- Module Name:   /home/beast/workspace/Organosi/OrganosiProject/forward_test.vhd
-- Project Name:  OrganosiProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Forward
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
 
ENTITY forward_test IS
END forward_test;
 
ARCHITECTURE behavior OF forward_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Forward
    PORT(
         p_DECEX : IN  std_logic_vector(31 downto 0);
         p_EXMEM : IN  std_logic_vector(31 downto 0);
         p_MEMWB : IN  std_logic_vector(31 downto 0);
         A_sel : OUT  std_logic_vector(1 downto 0);
         B_sel : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal p_DECEX : std_logic_vector(31 downto 0) := (others => '0');
   signal p_EXMEM : std_logic_vector(31 downto 0) := (others => '0');
   signal p_MEMWB : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal A_sel : std_logic_vector(1 downto 0);
   signal B_sel : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Forward PORT MAP (
          p_DECEX => p_DECEX,
          p_EXMEM => p_EXMEM,
          p_MEMWB => p_MEMWB,
          A_sel => A_sel,
          B_sel => B_sel
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		p_DECEX <= (others => '0');
		p_EXMEM <= (others => '0');
		p_MEMWB <= (others => '0');
		
		wait for 100 ns;	
		p_DECEX <= (others => '0');
		p_EXMEM <= x"000800C0";
		p_MEMWB <= x"00080000";
		
		wait for 100 ns;	
		p_DECEX <= x"00001800";
		p_EXMEM <= x"000800C0";
		p_MEMWB <= x"00080000";
		
		wait for 100 ns;	
		p_DECEX <= x"00001800";
		p_EXMEM <= x"00080000";
		p_MEMWB <= x"000800C0";

      -- insert stimulus here 

      wait;
   end process;

END;
