----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:26 04/24/2020 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
    Port ( EX_ALU_Bin_sel : out  STD_LOGIC;
           EX_ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           EX_ALU_zero : in  STD_LOGIC;
			  Instruction : in STD_LOGIC_VECTOR (31 downto 0);
			  DEC_Instr : out  STD_LOGIC_VECTOR (31 downto 0);
           DEC_RF_WrEn : out  STD_LOGIC;
           DEC_RF_WrData_sel : out  STD_LOGIC;
           DEC_RF_B_sel : out  STD_LOGIC;
           DEC_ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
           IF_PC_sel : out  STD_LOGIC;
           IF_PC_LdEn : out  STD_LOGIC;
			  MEM_ByteOp : out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC;
           RST : in STD_LOGIC;
			  CLK : in STD_LOGIC);
end CONTROL;

architecture Behavioral of CONTROL is
signal func, opcode : STD_LOGIC_VECTOR (5 downto 0);
begin

	process(Instruction, CLK, RST, EX_ALU_zero)
	begin
		If rising_edge(CLK) then
			opcode <= Instruction(31 downto 26);
			func<= Instruction(5 downto 0);
			case opcode is
				when "100000" => --ALU Functions DONE
					EX_ALU_func <= func(3 downto 0);
					EX_ALU_Bin_sel <= '0';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
				when "111000" => --li DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '1';
					IF_PC_sel <= '1';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
				when "111001" => --lui DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '0';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "11";
				when "110000" => --addi DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '0';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
				when "110010" => --nandi 
					EX_ALU_func <= "0011";
					EX_ALU_Bin_sel <= '0';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "01";
				when "110011" => --ori
					EX_ALU_func <= "0101";
					EX_ALU_Bin_sel <= '0';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "01";
				when "111111" => --b DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '0';
					IF_PC_sel <= '1';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '0';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "10";
				when "000000" => -- beq DONE
					EX_ALU_func <= "0001";
					EX_ALU_Bin_sel <= '0';
					if (EX_ALU_zero = '0') then
						IF_PC_sel <= '0';
					elsif (EX_ALU_zero = '1') then
						IF_PC_sel <= '1';
					else
						IF_PC_sel <= '0';
					end if;
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '0';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "10";
				when "000001" => --bne DONE
					EX_ALU_func <= "0001";
					EX_ALU_Bin_sel <= '0';
					if (EX_ALU_zero = '0') then
						IF_PC_sel <= '1';
					elsif (EX_ALU_zero = '1') then
						IF_PC_sel <= '0';
					else
						IF_PC_sel <= '0';
					end if;
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '0';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "10";
				when "000011" => -- lb DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '1';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '1';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
				when "000111" => -- sb DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '1';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '1';
					MEM_WrEn <= '1';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '0';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
				when "001111" => -- lw DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '1';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '1';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
				when "011111" => -- sw DONE
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '1';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '1';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '1';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '0';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
				when others => 
					EX_ALU_func <= "0000";
					EX_ALU_Bin_sel <= '0';
					IF_PC_sel <= '0';
					IF_PC_LdEn <= '0';
					MEM_ByteOp <= '0';
					MEM_WrEn <= '0';
					DEC_Instr <= Instruction;
					DEC_RF_WrEn <= '0';
					DEC_RF_WrData_sel <= '0';
					DEC_RF_B_sel <= '0';
					DEC_ImmExt <= "00";
			end case;
		end if;
		
	end process;

end Behavioral;

