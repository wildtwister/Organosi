--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:01:47 04/22/2020
-- Design Name:   
-- Module Name:   /home/beast/workspace/OrganosiProject/dec_stage_test.vhd
-- Project Name:  OrganosiProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY dec_stage_test IS
END dec_stage_test;
 
ARCHITECTURE behavior OF dec_stage_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0);
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B,
          RST => RST
        );

  
   -- Stimulus process
   stim_proc: process
   begin		
	
      RST <= '1';-- hold reset state for 100 ns.
		ALU_out <=x"88888888";
		MEM_out <=x"FFFFFFF1";
      wait for 100 ns;	
		RST <= '0';
		RF_WrEn <= '1';
		
		RF_B_sel <= '0';
		RF_WrData_sel<= '0';
		Instr <= x"00211000";
		
		wait for 100 ns;
		RF_WrEn <= '0';
		wait for 100 ns;
		RF_WrEn <= '1';
		RF_WrData_sel<= '1';
		Instr <= x"00221000";
		wait for 100 ns;
		RF_WrEn <= '0';
		Instr <= "00000000001000000000000000000000";
		wait for 100 ns;
		Instr <= "00000000010000000000000000000000";
		wait for 100 ns;
		Instr <= "00000000011000000000000000000000";
      wait for 100 ns;
		
		-- Immed Testing
		
		Instr <= "00000000011000011101111011101010";
		ImmExt <= "00";
		wait for 50 ns;
		ImmExt <= "01";
		wait for 50 ns;
		ImmExt <= "10";
		wait for 50 ns;
		ImmExt <= "11";
		wait for 50 ns;
   end process;

END;
