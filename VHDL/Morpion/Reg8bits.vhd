----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:14:02 02/14/2013 
-- Design Name: 
-- Module Name:    Reg8bits - Behavioral 
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

entity Reg8bits is
	Port (	H			: in	STD_LOGIC;							-- Horloge
				RST		: in	STD_LOGIC;							-- Reset asynchrone du composant
				CE			: in  STD_LOGIC;							-- Clock Enable, actication du composant
				Load		: in  STD_LOGIC;							-- Chargement de la valeur d'entrée
				Data_In	: in	STD_LOGIC_VECTOR(7 downto 0);	-- Valeur d'entrée
				Data_Out	: out	STD_LOGIC_VECTOR(7 downto 0));-- Valeur de sortie
end Reg8bits;

architecture Behavioral of Reg8bits is

begin

	process (H,RST)
	begin
		
		if (RST = '1') then
			Data_Out <= "00000000";
			
		elsif (H'event AND H = '1') then
			if (CE = '1') then	
				if (Load = '1') then
					Data_Out <= Data_In;
					
				end if;
				
			end if;
			
		end if;
		
	end process;

end Behavioral;

