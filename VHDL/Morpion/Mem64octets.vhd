----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:15:40 02/14/2013 
-- Design Name: 
-- Module Name:    RAM_SP_64_8 - Behavioral 
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_SP_64_8 is
				
	Port (ADD		: in  STD_LOGIC_VECTOR (5 downto 0);
			DATA_IN	: in  STD_LOGIC_VECTOR (7 downto 0);
			R_W		: in  STD_LOGIC;
			ENABLE	: in  STD_LOGIC;
			clk		: in  STD_LOGIC;
			Ce			: in  STD_LOGIC;
			DATA_OUT	: out STD_LOGIC_VECTOR (7 downto 0));
				
end RAM_SP_64_8;

architecture Behavioral of RAM_SP_64_8 is

type tab64 is array (integer range 0 to 63) of STD_LOGIC_VECTOR(7 downto 0);
signal memoire : tab64 := (X"08",
									X"47",
									X"86",
									X"C4",
									X"C4",
									X"00",
									X"00",
									X"7E",
									X"FE",
									others => X"00");
									
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

