----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:43 05/22/2020 
-- Design Name: 
-- Module Name:    STALL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hazard is
			Port(	Clk : in STD_LOGIC;
						Reset	: in  STD_LOGIC;
						newInstruction: in STD_LOGIC_VECTOR (31 downto 0);
						p_DECEX: in STD_LOGIC_VECTOR (31 downto 0);
						IF_PC_LdEn : out STD_LOGIC;
						r_PC_En : out  STD_LOGIC;
						p_DECEX_En : out  STD_LOGIC;
						r_Immed_En : out  STD_LOGIC;
						r_RF_A_En  : out  STD_LOGIC;
						r_RF_B_En  : out  STD_LOGIC;											
						r_MEM_OUT_WE  : out  STD_LOGIC;		
						r_ALU_OUT_WE  : out  STD_LOGIC;		
						r_MEM_DataIn_WE  : out  STD_LOGIC);
end Hazard;

architecture Behavioral of Hazard is
	type state is (Stall, DoNothing);
	signal current_state,next_state: state;
	signal newRs, newRt, prevRt : STD_LOGIC_VECTOR (4 downto 0);
	signal prevMemRead : STD_LOGIC;

begin
	newRs <= newInstruction(25 downto 21);
	newRt <= newInstruction(15 downto 11); 
	prevRt <= newInstruction(15 downto 11);
	prevMemRead <= p_DECEX(17);
	
	process (current_state)
	begin
		case current_state is
			when Stall =>
					IF_PC_LdEn <= '0';
					r_PC_En <= '0';
					p_DECEX_En <= '0';
					r_Immed_En <= '0';
					r_RF_A_En <= '0';
					r_RF_B_En <= '0';
					r_MEM_OUT_WE  <= '1';		
					r_ALU_OUT_WE  <= '1';		
					r_MEM_DataIn_WE <= '1';		
					next_state <= DoNothing;
			when DoNothing =>
					IF_PC_LdEn <= '1';
					r_PC_En <= '1';
					p_DECEX_En <= '1';
					r_Immed_En <= '1';
					r_RF_A_En <= '1';
					r_RF_B_En <= '1';
					r_MEM_OUT_WE  <= '1';		
					r_ALU_OUT_WE  <= '1';		
					r_MEM_DataIn_WE <= '1';		
					next_state <= DoNothing;
			when others =>
					IF_PC_LdEn <= '1';
					r_PC_En <= '1';
					p_DECEX_En <= '1';
					r_Immed_En <= '1';
					r_RF_A_En <= '1';
					r_RF_B_En <= '1';
					r_MEM_OUT_WE  <= '1';		
					r_ALU_OUT_WE  <= '1';		
					r_MEM_DataIn_WE <= '1';		
					next_state <= DoNothing;
		end case;
	end process;
		
		
	process(Clk, Reset, next_state, newRs, newRt, prevRt, prevMemRead)
	begin
		if Reset = '1' then
			current_state <= DoNothing;
		else
			if rising_edge(Clk) then
				if (prevMemRead = '1') AND ((prevRT = newRs) OR (prevRt = newRt)) then
					next_state <= Stall;
				end if;
				current_state <= next_state;
			end if;
		end if;
	end process;
end Behavioral;

