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
			  rs : in  STD_LOGIC_VECTOR (4 downto 0);
           rt : in  STD_LOGIC_VECTOR (4 downto 0);
           OpCODE_pipe1ine : in  STD_LOGIC_VECTOR (5 downto 0);
           rd_pipe1ine : in  STD_LOGIC_VECTOR (4 downto 0);
           PC_LdEn : out  STD_LOGIC;
			  MEM_WREn : out  STD_LOGIC);
end Hazard;

architecture Behavioral of Hazard is
type state is (B,C);
signal current_state,next_state: state;

begin
process (clk)
	begin
		if (Reset ='1') then
			current_state <= C;
		elsif (rising_edge(clk)) then
		  current_state <= next_state;
		end if;
	end process;
	
	process(current_state,Op_pipe1,rs,rt)
	begin
		case current_state is
	when A =>
			PC_LdEn <= '0';
			MEM_WREn <= '0';
			next_state <= B;
		when B =>
			PC_LdEn <= '0';
			MEM_WREn <= '0';
			next_state <= C;
		when C =>
			if ( OpCODE_pipe1ine = "001111" AND (rs = rd_pipe1ine OR rt =rd_pipe1ine)) then
				PC_LdEn <= '0';
				MEM_WREn <= '1';
				next_state <= B;
			else
				PC_LdEn <= '1';
				MEM_WREn <= '1';
				next_state <= C;
			end if;
			
		end case;
	end process;

end Behavioral;

