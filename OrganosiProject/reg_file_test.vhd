--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:57:21 04/21/2020
-- Design Name:   
-- Module Name:   /home/beast/workspace/OrganosiProject/reg_file_test.vhd
-- Project Name:  OrganosiProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFile
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
 
ENTITY reg_file_test IS
END reg_file_test;
 
ARCHITECTURE behavior OF reg_file_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         Adr1 : IN  std_logic_vector(4 downto 0);
         Adr2 : IN  std_logic_vector(4 downto 0);
         Adw : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Adr1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Adr2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Adw : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Adr1 => Adr1,
          Adr2 => Adr2,
          Adw => Adw,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WE => WE,
          CLK => CLK,
          RST => RST
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
		CLK <= '0';
      wait for 100 ns;	
		RST <= '0';
	
		WE <= '0';
		Adr1 <= "00001";
		Adr2<= "00010";
				
		wait for 30 ns;	
		WE <= '1' after 5 ns;
		Adw <= "00010";
		Din <= "00001010101101011110100110101010";
		wait for 30 ns;	
		WE <= '0';
		wait for 30 ns;	
		WE <= '1'after 5 ns;
		Adw <= "00001";
		Din <= "00000000001101011110100110101000";
		wait for 30 ns;	
		WE <= '0';
		wait for 30 ns;	
		WE <= '1'after 5 ns;
		Adw <= "00101";
		Din <= "00000000001101011110100110101111";
		wait for 30 ns;	
		WE <= '0';
		wait for 30 ns;	
		WE <= '1'after 5 ns;
		Adw <= "00011";
		Din <= "00000000001111111110100110101000";
		wait for 30 ns;	
		WE <= '0';
		wait for 30 ns;	
		WE <= '1'after 5 ns;
		Adw <= "00111";
		Din <= "11110000001101011110100110101000";
		wait for 30 ns;	
		WE <= '0';
		wait for 30 ns;	
		Adr1 <= "00001";
		Adr2<= "00010";
		wait for 30 ns;	
		Adr1 <= "00101";
		Adr2<= "00111";
		wait for 30 ns;	
		Adr1 <= "00010";
		Adr2<= "00011";
		wait for 30 ns;	
		Adr1 <= "00011";
		Adr2<= "00010";
		wait for 30 ns;	
		Adr1 <= "00101";
		Adr2<= "00001";
		wait for 30 ns;	
		Adr1 <= "00111";
		Adr2<= "00110";


      -- insert stimulus here 

      wait;
   end process;

END;
