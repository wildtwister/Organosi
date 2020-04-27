--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:40:11 04/22/2020
-- Design Name:   
-- Module Name:   C:/Users/dlytis/Desktop/organosi1o/organosi1o/MEMESTAGETest.vhd
-- Project Name:  organosi1o
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMESTAGETest IS
END MEMESTAGETest;
 
ARCHITECTURE behavior OF MEMESTAGETest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
    -- Clock period definitions
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );


   -- Stimulus process
   stim_proc: process
   begin		
		ByteOp <= '0';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <="00000000000000000000000000000000";
		MEM_DataIn <= "00000000000001000000000001100000";
		MM_RdData <= "00000001000000000100000000000001";
		wait for 200 ns;
		
		ByteOp <= '1';
		MEM_WrEn <= '1';
		ALU_MEM_Addr <= "00000000000000000000000000000000";
		MEM_DataIn <="11000000000000000000000000000011"; 
		MM_RdData <="00110000000000000000000110000111"; 
		wait for 200 ns;	
		
		ByteOp <= '1';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= "00100000000000000000000000000010";
		MEM_DataIn <="11000000000011000000000000000011"; 
		MM_RdData <="00110000000000000000000110000111"; 
		wait for 200 ns;	
		
		ByteOp <= '0';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= "00100000000000000000000000000001";
		MEM_DataIn <="11000100000011000000000000000011"; 
		MM_RdData <="00110000000000000000000110011111"; 
		wait for 200 ns;
		wait;
		end process;

	END;
