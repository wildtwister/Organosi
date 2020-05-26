----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:09:10 05/26/2020 
-- Design Name: 
-- Module Name:    ClockedSingleRegister - Behavioral 
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

entity ClockedSingleRegister is
    Port ( WE : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end ClockedSingleRegister;

architecture Behavioral of ClockedSingleRegister is
signal data : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin

clock_process: process(WE, RST, Datain)
begin
	if RST = '1' then 
			data <=  (others => '0');
		else
		if rising_edge(CLK) then
			if WE = '1' then
				data <= Datain;
			else
				data <= data;
			end if;
		end if;
	end if;
end process clock_process;

Dataout <= data;

end Behavioral;

