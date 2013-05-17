----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:32 04/15/2013 
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
--	--
0 => x"2F",
1 => x"B4",
2 => x"B5",
3 => x"B9",
4 => x"2F",
5 => x"78",
6 => x"71",
7 => x"C9",
8 => x"C4",
9 => x"30",
10 => x"6F",
11 => x"D8",
12 => x"6F",
13 => x"E0",
14 => x"CF",
15 => x"2F",
16 => x"74",
17 => x"BB",
18 => x"2F",
19 => x"75",
20 => x"30",
21 => x"B5",
22 => x"B9",
23 => x"C4",
24 => x"2F",
25 => x"74",
26 => x"71",
27 => x"B4",
28 => x"72",
29 => x"EB",
30 => x"B4",
31 => x"EB",
32 => x"71",
33 => x"2F",
34 => x"74",
35 => x"6F",
36 => x"C4",
37 => x"B4",
38 => x"71",
39 => x"EB",
40 => x"73",
41 => x"B4",
42 => x"EB",
43 => x"2F",
44 => x"74",
45 => x"BA",
46 => x"C4",
47 => x"FF",
48 => x"00",
49 => x"01",
50 => x"F7",
51 => x"08",
52 => x"00",
53 => x"00",
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

