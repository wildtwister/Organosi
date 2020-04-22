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
begin

process(AddrIn)
begin
	case AddrIn  is
		when "00000" => AddrOut <= "00000000000000000000000000000001";
		when "00001" => AddrOut <= "00000000000000000000000000000010";
		when "00010" => AddrOut <= "00000000000000000000000000000100";
		when "00011" => AddrOut <= "00000000000000000000000000001000";
		when "00100" => AddrOut <= "00000000000000000000000000010000";
		when "00101" => AddrOut <= "00000000000000000000000000100000";
		when "00110" => AddrOut <= "00000000000000000000000001000000";
		when "00111" => AddrOut <= "00000000000000000000000010000000";
		when "01000" => AddrOut <= "00000000000000000000000100000000";
		when "01001" => AddrOut <= "00000000000000000000001000000000";
		when "01010" => AddrOut <= "00000000000000000000010000000000";
		when "01011" => AddrOut <= "00000000000000000000100000000000";
		when "01100" => AddrOut <= "00000000000000000001000000000000";
		when "01101" => AddrOut <= "00000000000000000010000000000000";
		when "01110" => AddrOut <= "00000000000000000100000000000000";
		when "01111" => AddrOut <= "00000000000000001000000000000000";
		when "10000" => AddrOut <= "00000000000000010000000000000000";
		when "10001" => AddrOut <= "00000000000000100000000000000000";
		when "10010" => AddrOut <= "00000000000001000000000000000000";
		when "10011" => AddrOut <= "00000000000010000000000000000000";
		when "10100" => AddrOut <= "00000000000100000000000000000000";
		when "10101" => AddrOut <= "00000000001000000000000000000000";
		when "10110" => AddrOut <= "00000000010000000000000000000000";
		when "10111" => AddrOut <= "00000000100000000000000000000000";
		when "11000" => AddrOut <= "00000001000000000000000000000000";
		when "11001" => AddrOut <= "00000010000000000000000000000000";
		when "11010" => AddrOut <= "00000100000000000000000000000000";
		when "11011" => AddrOut <= "00001000000000000000000000000000";
		when "11100" => AddrOut <= "00010000000000000000000000000000";
		when "11101" => AddrOut <= "00100000000000000000000000000000";
		when "11110" => AddrOut <= "01000000000000000000000000000000";
		when "11111" => AddrOut <= "10000000000000000000000000000000";
		when others =>  AddrOut <= "00000000000000000000000000000000";
	end case;
end process;
end Behavioral;

