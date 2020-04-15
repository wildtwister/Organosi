----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:28:02 03/09/2020 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
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

entity RegisterFile is
    Port ( Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adw : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  RST: in STD_LOGIC);
end RegisterFile;

architecture Behavioral of RegisterFile is
type dataOutArray is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal doa : dataOutArray;
signal writeAddr, s_dout_1, s_dout_2: STD_LOGIC_VECTOR (31 downto 0);

component SingleRegister is
    Port ( WE : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Decoder5To32 is
    Port ( AddrIn : in  STD_LOGIC_VECTOR (4 downto 0);
           AddrOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux32_1 is
    Port ( Control : in  STD_LOGIC_VECTOR (4 downto 0);
           Input : in STD_LOGIC_VECTOR (1023 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

begin

decoder: Decoder5To32 port map (Adw, writeAddr);

gen: for i in 0 to 31 generate
		aRegister: SingleRegister port map (writeAddr(i) AND WE, RST, CLK, Din, doa(i));
end generate;

Dout1 <= doa(conv_integer(Adr1));
Dout2 <= doa(conv_integer(Adr2));
 
end Behavioral;

