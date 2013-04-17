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
	Port (ADD		: in  STD_LOGIC_VECTOR (5 downto 0);
			DATA_IN	: in  STD_LOGIC_VECTOR (7 downto 0);
			R_W		: in  STD_LOGIC;
			ENABLE	: in  STD_LOGIC;
			clk		: in  STD_LOGIC;
			Ce			: in  STD_LOGIC;
			DATA_OUT	: out STD_LOGIC_VECTOR (7 downto 0));
end RAM_56;

architecture Behavioral of RAM_56 is

type tab56 is array (integer range 0 to 55) of STD_LOGIC_VECTOR(7 downto 0);
signal memoire : tab56 := (
	0 => x"2B",
	1 => x"78",
	2 => x"6D",
	3 => x"C5",
	4 => x"C0",
	5 => x"2C",
	6 => x"6B",
	7 => x"D4",
	8 => x"6B",
	9 => x"DC",
	10 => x"CB",
	11 => x"2B",
	12 => x"70",
	13 => x"BB",
	14 => x"2B",
	15 => x"71",
	16 => x"B9",
	17 => x"2C",
	18 => x"B1",
	19 => x"C0",
	20 => x"2B",
	21 => x"70",
	22 => x"6D",
	23 => x"B0",
	24 => x"6E",
	25 => x"E7",
	26 => x"B0",
	27 => x"E7",
	28 => x"6D",
	29 => x"2B",
	30 => x"70",
	31 => x"6B",
	32 => x"C0",
	33 => x"B0",
	34 => x"6D",
	35 => x"E7",
	36 => x"6F",
	37 => x"B0",
	38 => x"E7",
	39 => x"2B",
	40 => x"70",
	41 => x"BA",
	42 => x"C0",
	43 => x"FF",
	44 => x"00",
	45 => x"01",
	46 => x"F7",
	47 => x"08",
	48 => x"00",
	49 => x"00",
	others => x"00");

begin

	process (clk)
	begin
			
		if (clk'event AND clk = '0') then
			if (CE = '1') then
				if (Enable = '1') then
				
					-- lecture
					if (R_W = '0') then
						Data_Out <= memoire(to_integer(unsigned(ADD)));
					
					-- écriture
					elsif (R_W = '1') then
						memoire(to_integer(unsigned(ADD))) <= Data_In;
						
					end if;
				end if;
			end if;
		end if;
		
	end process;


end Behavioral;

