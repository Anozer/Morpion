----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:34 02/14/2013 
-- Design Name: 
-- Module Name:    Processing_unit - Behavioral 
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

entity Processing_unit is
				
	Port (Data_in		: in  STD_LOGIC_VECTOR (7 downto 0);
			clk			: in  STD_LOGIC;
			Ce				: in  STD_LOGIC;
			reset			: in  STD_LOGIC;
			load_reg1	: in  STD_LOGIC;
			load_accu	: in  STD_LOGIC;
			load_carry	: in  STD_LOGIC;
			init_carry	: in  STD_LOGIC;
			Sel_UAL		: in  STD_LOGIC;
			Data_out		: out  STD_LOGIC_VECTOR (7 downto 0);
			Carry			: out  STD_LOGIC);
end Processing_unit;

architecture Behavioral of Processing_unit is




component UAL
	Port (Sel_UAL			: in	STD_LOGIC;							-- 0:NOR, 1:ADD
			Data_In_ACCU	: in	STD_LOGIC_VECTOR(7 downto 0); -- Valeur provenant de l'ACCU
			Data_In_MEM		: in	STD_LOGIC_VECTOR(7 downto 0); -- Valeur provenant du registre data
			Data_Out			: out	STD_LOGIC_VECTOR(7 downto 0); -- Valeur calculée
			Carry_out		: out STD_LOGIC);							-- Retenue de l'oppération
end component;


component Reg8bits
	Port (H			: in	STD_LOGIC;							-- Horloge
			RST		: in	STD_LOGIC;							-- Reset asynchrone du composant
			CE			: in  STD_LOGIC;							-- Clock Enable, actication du composant
			Load		: in  STD_LOGIC;							-- Chargement de la valeur d'entrée
			Data_In	: in	STD_LOGIC_VECTOR(7 downto 0);	-- Valeur d'entrée
			Data_Out	: out	STD_LOGIC_VECTOR(7 downto 0));-- Valeur de sortie
end component;


component FF1bit
	Port (H			: in	STD_LOGIC;	-- Horloge
			RST		: in	STD_LOGIC;	-- Reset asynchrone du composant
			CE			: in  STD_LOGIC;	-- Clock Enable, actication du composant
			Init		: in	STD_LOGIC;	-- Init, initialisation synchrone
			Load		: in  STD_LOGIC;	-- Chargement de la valeur d'entrée
			Data_In	: in	STD_LOGIC;	-- Valeur d'entrée
			Data_Out	: out	STD_LOGIC);	-- Valeur de sortie
end component;



signal RegData_out	: STD_LOGIC_VECTOR(7 downto 0);
signal UALcarry_out	: STD_LOGIC;
signal UALdata_out	: STD_LOGIC_VECTOR(7 downto 0);
signal RegAccu_out	: STD_LOGIC_VECTOR(7 downto 0);

begin

	Data_out <= RegAccu_out;

	RegData : Reg8bits port map (
		clk,
		reset,
		CE,
		load_reg1,
		Data_in,
		RegData_out);
	
	
	RegAccu : Reg8bits port map (
		clk,
		reset,
		CE,
		load_accu,
		UALdata_out,
		RegAccu_out);
		
		
	FFcarry : FF1bit port map (
		clk,
		reset,
		CE,
		init_carry,
		load_carry,
		UALcarry_out,
		Carry);
		
		
	UT_UAL : UAL port map (
		Sel_UAL,
		RegAccu_out,
		RegData_out,
		UALdata_out,
		UALcarry_out);

end Behavioral;

