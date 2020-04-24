----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:26:06 04/16/2020 
-- Design Name: 
-- Module Name:    InstrDecoder - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  RST: in STD_LOGIC);
end DECSTAGE;

architecture Behavioral of DECSTAGE is

signal reg1, reg2, read_reg2, wr_reg: STD_LOGIC_VECTOR(4 downto 0);
signal sig_Immed: STD_LOGIC_VECTOR(15 downto 0);
signal wr_data_sig, extended_immed: STD_LOGIC_VECTOR(31 downto 0);


component RegisterFile is
 Port(Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adw : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  RST: in STD_LOGIC);
end component;

begin

	reg1 <= Instr( 25 downto 21 );
	reg2 <= Instr( 15 downto 11);
	wr_reg <= Instr( 20 downto 16 );
	sig_Immed <= Instr( 15 downto 0);
	
	--Immed <= (others => '0'); -- pos ftiachnoume to Immed, OEO?
	
	process(RF_WrData_sel, ALU_out, MEM_out, RF_B_sel, reg2, wr_reg)
	begin
		if RF_WrData_sel = '0' then
			wr_data_sig <= ALU_out;
		elsif RF_WrData_sel = '1' then
			wr_data_sig <= MEM_out;
		else
			wr_data_sig <= x"00000000";
		end if;
						
		if RF_B_sel = '0' then 
			read_reg2 <= reg2;
		elsif RF_B_sel = '1' then
			read_reg2 <= wr_reg;
		else
			read_reg2 <= "00000";
		end if;
	end process;
											
	r_file : RegisterFile port map (reg1, read_reg2, wr_reg, RF_A, RF_B, wr_data_sig, RF_WrEn, Clk, RST);
	
	ImmedExtProcess: process(ImmExt, sig_Immed)
	begin 
		
		-- ImmExt(0) is for Sign Extention/ Zero Filling, ImmExt(1) is for Shifting
		case ImmExt is
			when "00" => -- Sign Extend, No Shifting
				extended_immed(31 downto 16) <= (others => sig_Immed(15));
				extended_immed(15 downto 0) <= sig_Immed;
			when "01" => -- Zero Filling, No Shifting
				extended_immed(31 downto 16) <= (others => '0');
				extended_immed(15 downto 0) <= sig_Immed;
			when "10" => -- Sign Extend, Shifting
				extended_immed(31 downto 18) <= (others => sig_Immed(15));
				extended_immed(17 downto 2) <= sig_Immed;
				extended_immed(1 downto 0) <= "00";
			when "11" => -- Zero Filling, Shifting
				extended_immed(31 downto 16) <= sig_Immed;
				extended_immed(15 downto 0) <= (others => '0');
			when others =>
				extended_immed <= x"00000000";
		end case;
		
	end process;
	Immed <= extended_immed;
	

end Behavioral;

