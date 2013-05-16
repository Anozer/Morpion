----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:51:47 04/25/2013 
-- Design Name: 
-- Module Name:    Disp_ImgGen - Behavioral 
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

entity Disp_ImgGen is
	port (Clk				: IN  STD_LOGIC;
			Ce					: IN  STD_LOGIC;
			Reset				: IN  STD_LOGIC;
			Pos_load			: IN  STD_LOGIC;
			Ok_load			: IN  STD_LOGIC;
			OldPos_val		: IN	std_logic_vector(7 downto 0);
			Pos_val			: IN  STD_LOGIC_VECTOR(7 downto 0);
			Ok_val			: IN  STD_LOGIC_VECTOR(7 downto 0);
			Player_val		: IN  STD_LOGIC;
			VRAM_AddrW		: OUT STD_LOGIC_VECTOR(18 downto 0);
			VRAM_DataW		: OUT STD_LOGIC_VECTOR(7 downto 0);
			VRAM_EnableW	: OUT STD_LOGIC);
end Disp_ImgGen;

architecture Behavioral of Disp_ImgGen is

component Disp_ImgGen_GridManager
	Port(	Clk			: IN  STD_LOGIC;
			Rst 			: IN  STD_LOGIC;
         CE 			: IN  STD_LOGIC;
			Ok_Load		: IN  STD_LOGIC;
			Player		: IN  STD_LOGIC;
			OK				: IN  STD_LOGIC_VECTOR(7 downto 0);
			Ok_Load_sync: OUT STD_LOGIC;
			Grid_State	: OUT STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player	: OUT STD_LOGIC_VECTOR(8 downto 0));
end component;

component Disp_ImgGen_ShapeDetermination
	Port(	Clk			: IN  STD_LOGIC;
			Rst 			: IN  STD_LOGIC;
			CE 			: IN  STD_LOGIC;
			Busy			: IN  STD_LOGIC;
			Pos_Load		: IN  STD_LOGIC;
			Ok_Load		: IN  STD_LOGIC;
			Ok				: IN  STD_LOGIC_VECTOR(7 downto 0);
			Pos			: IN  STD_LOGIC_VECTOR(7 downto 0);
			OldPos		: IN  STD_LOGIC_VECTOR(7 downto 0);
			Grid_State	: IN  STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player	: IN  STD_LOGIC_VECTOR(8 downto 0);
			Shape_Load	: OUT STD_LOGIC;
			Shape_Numb	: OUT STD_LOGIC_VECTOR(2 downto 0);
			Area_Numb	: OUT STD_LOGIC_VECTOR(7 downto 0));
end component;


component Disp_ImgGen_ShapeGenerator
	port (
		Clk			: IN  STD_LOGIC;
		Reset			: IN  STD_LOGIC;
		Ce				: IN  STD_LOGIC;
		Shape_Load	: IN  STD_LOGIC;
		Shape_Numb	: IN  STD_LOGIC_VECTOR(2  downto 0);
		Area_Numb	: IN  STD_LOGIC_VECTOR(7 downto 0);
		VRAM_data	: OUT	STD_LOGIC_VECTOR(7  downto 0);
		VRAM_addr	: OUT STD_LOGIC_VECTOR(18 downto 0);
		VRAM_enable	: OUT STD_LOGIC);
end component;

signal Grid_state : std_logic_vector(8 downto 0);
signal Grid_Player : std_logic_vector(8 downto 0);
signal busy : std_logic;
signal Shape_Load : std_logic;
signal Shape_Numb : std_logic_vector(2 downto 0); 
signal area_numb : std_logic_vector(7 downto 0);
signal OK_Load_sync : std_logic;



begin

	
	VRAM_EnableW <= Busy;
	
	Grid_Manager : Disp_ImgGen_GridManager 
	port map(
		Clk			=> Clk,
		Rst 			=> Reset,
		CE 			=> Ce,
		Ok_Load		=> Ok_load,
		Player		=> Player_val,
		OK				=> OK_val,
		Ok_Load_sync=> OK_Load_sync,
		Grid_State	=> Grid_state,
		Grid_Player	=> Grid_Player);
		
	Shape_Determination : Disp_ImgGen_ShapeDetermination	
	port map(
		Clk			=> Clk,
		Rst			=> Reset,
		CE				=> CE,
		Busy			=> busy,
		Pos_Load		=> Pos_load,
		Ok_Load		=> OK_Load_sync,
		Ok				=> Ok_val,
		Pos			=> Pos_val,
		OldPos		=> OldPos_val,
		Grid_State	=> Grid_state,
		Grid_Player	=> Grid_player,
		Shape_Load	=> Shape_Load,
		Shape_Numb	=> Shape_Numb,
		Area_Numb	=> Area_Numb);
		
		
	Shape_Generator : Disp_ImgGen_ShapeGenerator
	port map(
		Clk			=> Clk,
		Reset			=> Reset,
		Ce				=> Ce,
		Shape_Load	=> Shape_Load,
		Shape_Numb	=> Shape_Numb,
		Area_Numb	=> Area_Numb,
		VRAM_data	=> VRAM_DataW,
		VRAM_addr	=> VRAM_AddrW,
		VRAM_enable	=> Busy);
	

end Behavioral;

