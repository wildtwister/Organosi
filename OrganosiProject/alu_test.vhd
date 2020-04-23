--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:56:49 03/31/2020
-- Design Name:   
-- Module Name:   /home/beast/workspace/OrganosiProject/alu_test.vhd
-- Project Name:  OrganosiProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY alu_test IS
END alu_test;
 
ARCHITECTURE behavior OF alu_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		A <= "00000000000000000000000000000001";
		B <= "00000000000000000000000000000000";
		Op <= "0000"; --ADD

      -- insert stimulus here 

      wait for 100 ns;
		
		A <= "10000000000000000000000000001001";
		B <= "10000000000000000000000000100000";
		Op <= "0000"; --ADD
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000100000";
		B <= "00000000000000000000000000001001";
		Op <= "0001"; --SUB
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000100000";
		Op <= "0001"; --SUB
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000100000";
		Op <= "0010"; --AND
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000101111";
		Op <= "0010"; --AND
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000100000";
		Op <= "0011"; --OR
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000101111";
		Op <= "0011"; --OR
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000100000";
		Op <= "0100"; --NOT A
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000100000";
		Op <= "0101"; -- NAND
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000101111";
		Op <= "0101"; -- NAND
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000100000";
		Op <= "0110"; --NOR
		
		wait for 100 ns;
		
		A <= "00000000000000000000000000001001";
		B <= "00000000000000000000000000101111";
		Op <= "0110"; --NOR
		
		--Shifting Testing
		
		A <= x"80000001";
		Op <= "1000"; --SL MSB
		

   end process;

END;
