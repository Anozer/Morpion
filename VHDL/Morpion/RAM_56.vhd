----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
-- Design Name: 
-- Module Name:    RAM_56 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_56 is
	Port (AddrBus				: in  STD_LOGIC_VECTOR (5 downto 0);
			DataBus_fromCPU	: in  STD_LOGIC_VECTOR (7 downto 0);
			RW						: in  STD_LOGIC;
			ENABLE				: in  STD_LOGIC;
			clk					: in  STD_LOGIC;
			Ce						: in  STD_LOGIC;
			DataBus_toCPU		: out STD_LOGIC_VECTOR (7 downto 0));
end RAM_56;

architecture Behavioral of RAM_56 is

type tab56 is array (integer range 0 to 55) of STD_LOGIC_VECTOR(7 downto 0);
signal memoire : tab56 := (
-- INIT
0 => x"2F",		-- NOR ALLONE	(CLR)
1 => x"B4",		-- STA POS
2 => x"B5",		-- STA JOUEUR
3 => x"B9",		-- STA AFF_J
-- START
4 => x"2F",		-- NOR ALLONE	(CLR)
5 => x"78",		-- ADD BP		(LOAD)
6 => x"71",		-- ADD ONE
7 => x"C9",		-- JCC BPDETECT
8 => x"C4",		-- JCC START
-- BPDETECT
9 => x"30",		-- NOR ZERO	
10 => x"6F",	-- ADD ALLONE
11 => x"D8",	-- JCC BT_NEXT
12 => x"6F",	-- ADD ALLONE
13 => x"E0",	-- JCC BT_PREV
14 => x"CF",	-- JCC BT_OK
-- BT_OK
15 => x"2F",	-- NOR ALLONE	(CLR)
16 => x"74",	-- ADD POS		(LOAD)
17 => x"BB",	-- STA AFF_OK
18 => x"2F",	-- NOR ALLONE	(CLR)
19 => x"75",	-- ADD JOUEUR	(LOAD)
20 => x"30",	-- NOR ZERO
21 => x"B5",	-- STA JOUEUR
22 => x"B9",	-- STA AFF_J
23 => x"C4",	-- JCC START
-- BT_NEXT
24 => x"2F",	-- NOR ALLONE	(CLR)
25 => x"74",	-- ADD POS		(LOAD)
26 => x"71",	-- ADD ONE
27 => x"B4",	-- STA POS
28 => x"72",	-- ADD VAL_247
29 => x"EB",	-- JCC SENDPOS
30 => x"B4",	-- STA POS
31 => x"EB",	-- JCC SENDPOS
-- BT_PREC
32 => x"29",	-- NOR ALLONE
33 => x"74",	-- ADD POS		
34 => x"6F",	-- ADD ONE		
35 => x"70",	-- ADD ZERO	
36 => x"B4",	-- STA POS		
37 => x"71",	-- ADD ONE		
38 => x"EB",	-- JCC SENDPO
39 => x"73",	-- ADD VAL_8
40 => x"B4",	-- STA POS	
41 => x"EB",	-- JCC SEND POS
42 => x"C4",	-- JCC START / Bourage pour pas avoir à tout réécrire ...
-- SENDPOS
43 => x"2F",	-- NOR ALLONE	(CLR)
44 => x"74",	-- ADD POS		(LOAD)
45 => x"BA",	-- STA AFF_POS
46 => x"C4",	-- JCC START
-- VARIABLES
47 => x"FF",	-- ALLONE
48 => x"00",	-- ZERO
49 => x"01",	-- ONE
50 => x"F7",	-- VAL_247
51 => x"08",	-- VAL_8
52 => x"00",	-- POS
53 => x"00",	-- JOUEUR
	others => x"00");
begin

	process (clk)
	begin
			
		if (clk'event AND clk = '0') then
			if (CE = '1') then
				if (Enable = '1') then
				
					-- lecture
					if (RW = '0') then
						DataBus_toCPU <= memoire(to_integer(unsigned(AddrBus)));
					
					-- écriture
					elsif (RW = '1') then
						memoire(to_integer(unsigned(AddrBus))) <= DataBus_fromCPU;
						
					end if;
				end if;
			end if;
		end if;
		
	end process;


end Behavioral;

