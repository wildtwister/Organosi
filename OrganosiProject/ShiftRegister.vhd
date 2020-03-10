----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:11:28 03/10/2020 
-- Design Name: 
-- Module Name:    ShiftRegister - Behavioral 
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

entity ShiftRegister is
    Port ( SR : in  STD_LOGIC;
           SL : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Control : in  STD_LOGIC_VECTOR (1 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end ShiftRegister;

architecture Behavioral of ShiftRegister is
signal qs : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin

control_process: process(Control)
begin
	case Control is
		when "01" =>
			qs(31) <= SR;
			qs(30 downto 0) <= qs(31 downto 1);
		when "10" =>
			qs(0) <= SL;
			qs(31 downto 1) <= qs(30 downto 0);
		when "11" =>
			qs <= DataIn;
		when "00" =>
			qs <= qs;
		when others =>		
			qs <= qs;
	end case;		
end control_process;

change_value_process: process(CLK, RST)
begin
	if rising_edge(CLK) then
		if RST = '1' then
			DataOut <= (others=>'0');
		else
			DataOut <= qs;
	end if;
end change_value_process;

end Behavioral;

