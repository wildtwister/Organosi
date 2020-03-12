----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:36:02 03/10/2020 
-- Design Name: 
-- Module Name:    Decoder5To32 - Behavioral 
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

entity Decoder5To32 is
    Port ( AddrIn : in  STD_LOGIC_VECTOR (4 downto 0);
           AddrOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder5To32;

architecture Behavioral of Decoder5To32 is
signal counter: STD_LOGIC_VECTOR (4 downto 0);
signal myControl: STD_LOGIC_VECTOR (1 downto 0) := "00";
signal myOutput : STD_LOGIC_VECTOR(31 downto 0);
signal leftInput: STD_LOGIC;
signal 


component ShiftRegister is
	Port ( SR : in  STD_LOGIC;
           SL : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Control : in  STD_LOGIC_VECTOR (1 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

begin

mySRegister : ShiftRegister port map (
	SR=> '0',
	SL=> leftinput,
	DataIn => "00000000000000000000000000000000",
	CLK => CLK,
	RST => RST,
	Control => myControl,
	DataOut => myOutput
);

clock_process: process (RST, CLK)
begin
	if rising_edge(CLK) then
		if RST='1' then
			counter<= "00000";
		else
			counter <= counter + 1;
			
			
end clock_process;
end Behavioral;

