--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:58:08 04/21/2020
-- Design Name:   
-- Module Name:   /home/beast/workspace/OrganosiProject/mem_module_test.vhd
-- Project Name:  OrganosiProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MainMemory
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
 
ENTITY mem_module_test IS
END mem_module_test;
 
ARCHITECTURE behavior OF mem_module_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MainMemory
    PORT(
         CLK : IN  std_logic;
         inst_addr : IN  std_logic_vector(10 downto 0);
         inst_dout : OUT  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         data_din : IN  std_logic_vector(31 downto 0);
         data_addr : IN  std_logic_vector(10 downto 0);
         data_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal inst_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_we : std_logic := '0';
   signal data_din : std_logic_vector(31 downto 0) := (others => '0');
   signal data_addr : std_logic_vector(10 downto 0) := (others => '0');

 	--Outputs
   signal inst_dout : std_logic_vector(31 downto 0);
   signal data_dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MainMemory PORT MAP (
          CLK => CLK,
          inst_addr => inst_addr,
          inst_dout => inst_dout,
          data_we => data_we,
          data_din => data_din,
          data_addr => data_addr,
          data_dout => data_dout
        );

   -- Clock process definitions
   --CLK_process :process
   --begin
		--CLK <= '0';
		--wait for CLK_period/2;
		--CLK <= '1';
		--wait for CLK_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		data_we <= '1';
		data_addr <= "01000000001";
		data_din <= "00010001110100101001001100101001";
		
		wait for 100 ns;
		data_addr <= "01000000010";
		data_din <= "00000001110100101001001100111101";
		
		wait for 100 ns;
		data_addr <= "01000000011";
		data_din <= "00010001110100101001001000000000";
	
		wait for 100 ns;	
		data_we <= '0';
		data_addr <= "00000000001";
		
		
		wait for 100 ns;
		data_addr <= "00000000010";
		
		
		wait for 100 ns;
		data_addr <= "00000000011";		
		
		wait for 100 ns;	
		data_we <= '0';
		data_addr <= "01000000001";
		
		
		wait for 100 ns;
		data_addr <= "01000000010";
		
		
		wait for 100 ns;
		data_addr <= "01000000011";		
		
      -- insert stimulus here 

      wait;
   end process;

END;
