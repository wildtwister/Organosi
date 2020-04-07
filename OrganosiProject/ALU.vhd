----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:13 03/09/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal result_32: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal result_33: STD_LOGIC_VECTOR(32 downto 0) := (others => '0');
begin

	op_choice: process(A,B,Op)
	begin
		case Op is
			when "0000" => 
				result_32<= A + B after 10 ns;
			when "0001" => 
				result_32<= A - B;
			when "0010" => 
				result_32 <= A AND B;
			when "0011" => 
				result_32 <= A OR B;
			when "0100" => 
				result_32  <= NOT A;
			when "0110" => 
				result_32 <= A NAND B;
			when "1000" => 
			when "1001" => 
			when "1010" => 
			when "1100" => 
			when "1101" => 
			when others =>
		end case;
		
		if (result_32 = x"00") then
			Zero <= '1';
		else
			Zero <= '0';
		end if;
	end process;
	Output <= result_32;
	result_33 <= ('0' & A) + ('0' & B);
	Cout <= result_33(32);
	
end Behavioral;

