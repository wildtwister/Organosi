-- Description:
-- 5 flip-flops implemented differently.
-- The first 4 flip-flops are implemented using: rising_edge(CLK). 
-- The 5th flip-flop is implemented using: wait until CLK'EVENT AND CLK = '1'. 
-- The latter design style is not recommended.
--
-- 1st flip-flop: has Synchronous Reset; it has an output Q
-- flipflop2: has Synchronous Reset; it has 2 outputs Q and Qbar
-- flipflop3: has Synchronous Reset and Enable signal; it has an output Q
-- flipflop4: has Asynchronous Reset; it has an output Q
-- flipflop5: has Synchronous Reset; it has an output Q
--
-- created by Kyprianos Papadimitriou, March 19, 2018
-- School of ECE, TU Crete, for the course Advanced Logic Design


library IEEE;
use IEEE.std_logic_1164.all;

entity D_flip_flop is

port ( 
        CLK 	: in STD_LOGIC;
        RST 	: in STD_LOGIC;
		D 		: in STD_LOGIC;
		enable 	: in STD_LOGIC;
        Q 		: out STD_LOGIC;
        Q2		: out STD_LOGIC;
        Q2bar	: out STD_LOGIC;
  		Q3		: out STD_LOGIC;
        Q4		: out STD_LOGIC;
        Q5		: out STD_LOGIC
        );
end D_flip_flop;

architecture behavioral of D_flip_flop is

begin		-- begin architecture


-- flip-flop with Q
-- if rising_edge(CLK) + Synchronous RST
process_flip_flop: process (CLK)
begin
	if rising_edge(CLK) then
		if RST='1' then			Q <= '0';					-- reset is "active high"
    	else					Q <= D;
    	end if;
end if;    
end process process_flip_flop;   


-- flip-flop with Q and Qbar
-- if rising_edge(CLK) + Synchronous RST
process_flip_flop2: process (CLK)
begin
	if rising_edge(CLK) then
		if RST='1' then			Q2 <= '0'; 	Q2bar <= '1';	-- reset is "active high"
    	else					Q2 <= D;	Q2bar <= not D;
    	end if;
end if;    
end process process_flip_flop2;


-- flip-flop with Q 
-- if rising_edge(CLK) + Synchronous RST + Enable
process_flip_flop3: process (CLK)
begin
	if rising_edge(CLK) then
		if RST='1' then			Q3 <= '0';					-- reset is "active high"
		elsif enable='1' then	Q3 <= D; 					-- if enable='1' then Q3 <= D
    	end if;												-- if enable='0' then Q3 holds its value
	end if;    
end process process_flip_flop3;


-- flip-flop with Q output
-- this is Ok, but prefer the Synchronous RST
-- if rising_edge(CLK) + Asynchronous RST
process_flip_flop4: process (CLK, RST)
begin
	if (RST='1') then			Q4 <= '0';					-- reset is "active high"
	elsif rising_edge(CLK) then Q4 <= D;
	end if;
end process process_flip_flop4;


-- flip-flop with Q 
-- this is not that nice design
-- wait until CLK'event + Synchronous RST
process_flip_flopBad: process
begin
	wait until CLK'EVENT AND CLK = '1';
		if(RST='1') then		Q5 <= '0';					-- reset is "active high"
		else 					Q5 <= D;
		end if;
end process process_flip_flopBad;


end behavioral;	-- end architecture

