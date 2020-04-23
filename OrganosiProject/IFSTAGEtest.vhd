--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:47:44 04/22/2020
-- Design Name:   
-- Module Name:   C:/Users/dlytis/Desktop/organosi1o/organosi1o/IFSTAGEtest.vhd
-- Project Name:  organosi1o
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY IFSTAGEtest IS
END IFSTAGEtest;
 
ARCHITECTURE behavior OF IFSTAGEtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);

   -- Clock period definitions
  -- constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          PC => PC
        );

   -- Clock process definitions
  -- Clk_process :process
  -- begin
	--	Clk <= '0';
	--	wait for Clk_period/2;
	--	Clk <= '1';
	--	wait for Clk_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
		Reset <= '1';
		PC_sel <='0';
		PC_Immed <="00000000000000000000000000000001";
		PC_LdEn <= '0';
		wait for 100 ns;
		Reset <= '0';
		PC_sel <='0';
		PC_Immed <="00000000000000000000000000000001";
		PC_LdEn <= '1';
		wait for 100 ns;
		Reset <= '0';
		PC_sel <='1';
		PC_Immed <="00000000000000000000000000000001";
		PC_LdEn <= '1';
      -- insert stimulus here
		
      -- insert stimulus here
      wait;
   end process;

END;
