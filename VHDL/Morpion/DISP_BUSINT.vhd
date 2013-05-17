----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:26 04/17/2013 
-- Design Name: 
-- Module Name:    DISP_BUSINT - Behavioral 
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

entity DISP_BUSINT is
	Port (Clk				: in  STD_LOGIC;
			CE						: in  STD_LOGIC;
			Reset					: in  STD_LOGIC;
			AddrBus				: in  STD_LOGIC_VECTOR (5 DOWNTO 0);
			DataBus_fromCPU	: in  STD_LOGIC_VECTOR (7 DOWNTO 0);
			Enable_Img			: in  STD_LOGIC;
			RW						: in	STD_LOGIC;
			Player_Out			: out	STD_LOGIC_VECTOR (7 DOWNTO 0);
			OK_Out				: out STD_LOGIC_VECTOR (7 DOWNTO 0);
			Pos_Out				: out STD_LOGIC_VECTOR (7 DOWNTO 0);
			OldPos_Out			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
			OK_Load				: out STD_LOGIC;
			Pos_Load				: out STD_LOGIC;
			Player_Load			: out STD_LOGIC);
end DISP_BUSINT;

architecture Behavioral of DISP_BUSINT is

	component DISP_BUSINT_Decode
			Port(		Data_In			: in  STD_LOGIC_VECTOR(5 downto 0);
						Enable_Disp		: in  STD_LOGIC;
						RW					: in STD_LOGIC;
						POS_Load			: out STD_LOGIC;
						OK_Load			: out STD_LOGIC;
						PLAYER_Load		: out STD_LOGIC);
	end component;
	
	component REG8bits
			Port (	H			: in	STD_LOGIC;							-- Horloge
						RST		: in	STD_LOGIC;							-- Reset asynchrone du composant
						CE			: in  STD_LOGIC;							-- Clock Enable, actication du composant
						Load		: in  STD_LOGIC;							-- Chargement de la valeur d'entrée
						Data_In	: in	STD_LOGIC_VECTOR(7 downto 0);	-- Valeur d'entrée
						Data_Out	: out	STD_LOGIC_VECTOR(7 downto 0));-- Valeur de sortie
	end component;
	
		signal s_Pos_Load		: STD_LOGIC;
		signal s_OK_Load		: STD_LOGIC;
		signal s_J_Load		: STD_LOGIC;
		signal s_Pos_val		: STD_LOGIC_VECTOR(7 downto 0);

begin

	Player_Load	<= s_J_Load;
	Pos_Load		<= s_Pos_Load;
	OK_Load		<= s_OK_Load;
	Pos_Out		<= s_Pos_val;
	
	REG_J: REG8bits port map (
		Clk,
		Reset,
		CE,
		s_J_Load,
		DataBus_fromCPU (7 downto 0),
		Player_Out (7 downto 0));
		
	REG_OK: REG8bits port map (
		Clk,
		Reset,
		CE,
		s_OK_Load,
		DataBus_fromCPU (7 downto 0),
		OK_Out (7 downto 0));
		
	REG_Pos: REG8bits port map (
		Clk,
		Reset,
		CE,
		s_Pos_Load,
		DataBus_fromCPU (7 downto 0),
		s_Pos_val);
		
	REG_OldPos: REG8bits port map (
		Clk,
		Reset,
		CE,
		s_Pos_Load,
		s_Pos_val,
		OldPos_Out (7 downto 0));
		
	Decode: DISP_BUSINT_Decode port map (
		AddrBus (5 downto 0),
		Enable_Img,
		RW,
		s_Pos_Load,
		s_OK_Load,
		s_J_Load);
		

end Behavioral;

