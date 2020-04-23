----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:30:00 04/17/2020 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
component SingleRegister is
    Port ( WE : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal adder1: STD_LOGIC_VECTOR(31 downto 0);
signal adder2 : STD_LOGIC_VECTOR(31 downto 0);
signal PC_sig : STD_LOGIC_VECTOR(31 downto 0);
signal mux_sig : STD_LOGIC_VECTOR(31 downto 0);


begin
		adder1 <= PC_sig+4 ;
		adder2 <= adder1+PC_Immed;
		
		with PC_sel select
				mux_sig <= adder1 when '0',
				adder2 when '1',
				(others => '0') when others;
				
		IFSingleRegister:SingleRegister Port Map(PC_LdEn,Reset,Clk,mux_sig,PC_sig);
		
		PC <= PC_sig;
end Behavioral;

