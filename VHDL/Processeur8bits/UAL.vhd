----------------------------------------------------------------------------------
-- Company: 			ENSEIRB-Matmeca
-- Engineer:			Sylvain MARIEL & Thomas MOREAU
-- 
-- Create Date:		19:50:49 02/13/2013 
-- Design Name: 		Unité de traitement
-- Module Name:		UniteTraitement - Behavioral 
-- Project Name: 		Processeur8bits
-- Target Devices:	Spartan 6
-- Tool versions: 
-- Description: 		Processeur 8 bits élémentaire à 4 instructions
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

entity UAL is
	Port (Sel_UAL			: in	STD_LOGIC;							-- 0:NOR, 1:ADD
			Data_In_ACCU	: in	STD_LOGIC_VECTOR(7 downto 0); -- Valeur provenant de l'ACCU
			Data_In_MEM		: in	STD_LOGIC_VECTOR(7 downto 0); -- Valeur provenant du registre data
			Data_Out			: out	STD_LOGIC_VECTOR(7 downto 0); -- Valeur calculée
			Carry_Out		: out STD_LOGIC);							-- Retenue de l'oppération
end UAL;

architecture Behavioral of UAL is

begin

	process(Sel_UAL, Data_In_ACCU, Data_IN_MEM)
	variable A: unsigned(7 downto 0);
	variable B: unsigned(7 downto 0);
	variable S: unsigned(8 downto 0);
	
	begin
		-- NOR
		if (Sel_UAL = '0') then
			Data_Out <= Data_In_ACCU NOR Data_In_MEM;
			Carry_Out <= '0';
			
		-- ADD	
		elsif (Sel_UAL = '1') then
		
			A				:= unsigned(Data_In_ACCU);
			B				:= unsigned(Data_In_MEM);
			S				:= resize(A,9) + resize(B,9);
			Data_Out		<= std_logic_vector(S(7 downto 0));
			Carry_Out	<= std_logic(S(8));
			
		end if;
		
	end process;

end Behavioral;

