----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BP_REG8bits is
	Port (	Clk		: in	STD_LOGIC;							-- Horloge
				Rst		: in	STD_LOGIC;							-- Reset asynchrone du composant
				CE			: in  STD_LOGIC;							-- Clock Enable, actication du composant
				Load		: in  STD_LOGIC;							-- Chargement de la valeur d'entrée
				CLR		: in  STD_LOGIC;							-- RAZ de Data_Out
				Data_In	: in	STD_LOGIC_VECTOR(7 downto 0);	-- Valeur d'entrée
				Data_Out	: out	STD_LOGIC_VECTOR(7 downto 0));-- Valeur de sortie
end BP_REG8bits;

architecture Behavioral of BP_REG8bits is

begin

	process (Clk,Rst)
	begin
		
		if (Rst = '1') then
			Data_out <= "00000000";
			
		elsif (Clk'event AND Clk = '1') then
			if (CLR = '1') then
					Data_out <= "00000000";
			elsif (CE = '1') then	
				if (Load = '1') then
					Data_out <= Data_In;
				end if;
			end if;
			
		end if;
		
	end process;

end Behavioral;


