----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:11:27 05/14/2013 
-- Design Name: 
-- Module Name:    Disp_ImgGen_ShapeGenerator - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Disp_ImgGen_ShapeGenerator is
	port (
		Clk			: IN  STD_LOGIC;
		Reset			: IN  STD_LOGIC;
		Ce				: IN  STD_LOGIC;
		Shape_Load	: IN  STD_LOGIC;
		Shape_Numb	: IN  STD_LOGIC_VECTOR(2  downto 0);
		Shape_Coord	: IN  STD_LOGIC_VECTOR(18 downto 0);
		VRAM_data	: OUT	STD_LOGIC_VECTOR(7  downto 0);
		VRAM_addr	: OUT STD_LOGIC_VECTOR(18 downto 0);
		VRAM_enable	: OUT STD_LOGIC);
end Disp_ImgGen_ShapeGenerator;

architecture Behavioral of Disp_ImgGen_ShapeGenerator is


component Disp_ImgGen_ShapeGenerator_Cpt
	port (
		Clk			: IN  STD_LOGIC;
		Reset			: IN  STD_LOGIC;
		Ce				: IN  STD_LOGIC;
		Load			: IN  STD_LOGIC;
		X_out			: OUT	STD_LOGIC_VECTOR(6 downto 0);
		Y_out			: OUT STD_LOGIC_VECTOR(6 downto 0);
		Counting		: OUT STD_LOGIC);
end component;

component MUX_8to1
    Port ( Data_In_0 : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_In_1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_2	: in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_3 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_4 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_5 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_6 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_7 : in  STD_LOGIC_VECTOR (7 downto 0);
           Channel   : in  STD_LOGIC_VECTOR (2 downto 0);
           Data_Out  : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component ROM_Vide
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN  STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC_VECTOR(7 downto 0));
end component;

component ROM_Vide_sel
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN  STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC_VECTOR(7 downto 0));
end component;

component ROM_O
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN  STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC_VECTOR(7 downto 0));
end component;


component ROM_O_sel
port (CLK : in std_logic;
      EN : in std_logic;
      ADDR : in std_logic_vector(13 downto 0);
      DATA : out std_logic_vector(7 downto 0));
end component;


component ROM_X
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN  STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC_VECTOR(7 downto 0));
end component;

component ROM_X_sel
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC_VECTOR(7 downto 0));
end component;

signal Enable_rom	: STD_LOGIC;
signal ROM_addr	: STD_LOGIC_VECTOR(13 downto 0);
signal X_rom		: STD_LOGIC_VECTOR(6 downto 0);
signal Y_rom 		: STD_LOGIC_VECTOR(6 downto 0);
signal X_vram		: STD_LOGIC_VECTOR(9 downto 0);
signal Y_vram		: STD_LOGIC_VECTOR(8 downto 0);
signal X_init		: STD_LOGIC_VECTOR(9 downto 0);
signal Y_init		: STD_LOGIC_VECTOR(8 downto 0);
signal MUX_IN0		: STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN1		: STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN2		: STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN3		: STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN4		: STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN5		: STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN6		: STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN7		: STD_LOGIC_VECTOR(7 downto 0);

begin	
	VRAM_enable <= Enable_rom;

	-- Coord de la case
	X_init <= Shape_Coord(9 downto 0);
	Y_init <= Shape_Coord(18 downto 10);
	
	-- Coord de la VRAM = case+rom
	X_vram <= X_init + X_rom;
	Y_vram <= Y_init + Y_rom;
	
	-- Adresses des mémoires
	ROM_addr  <= Y_rom & X_rom;
	VRAM_addr <= Y_vram & X_vram;
	
	
	MUX_IN6 <= MUX_IN2;
	MUX_IN7 <= MUX_IN2;
	
	
	Compteur : Disp_ImgGen_ShapeGenerator_Cpt
	port map (
		Clk		=> Clk,
		Reset		=> Reset,
		Ce			=> Ce,
		Load		=> Shape_Load,
		X_out		=> X_rom,
		Y_out		=> Y_rom,
		Counting	=> Enable_rom
	);
	
	MUX_ROM2OUT : MUX_8to1
	Port map ( 
		Data_In_0	=> MUX_IN0,
		Data_In_1	=> MUX_IN1, 
		Data_In_2	=> MUX_IN2,
		Data_In_3	=> MUX_IN3,
		Data_In_4	=> MUX_IN4,
		Data_In_5	=> MUX_IN5,
		Data_In_6	=> MUX_IN6,
		Data_In_7	=> MUX_IN7,
		Channel		=> Shape_Numb,
		Data_Out		=> VRAM_data
	);
	
	ROM0 : ROM_O
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN0
	);
	
	ROM1 : ROM_X
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN1
	);
	
	ROM2 : ROM_Vide
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN2
	);
	
	ROM3 : ROM_Vide_Sel
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN3
	);
	
	ROM4 : ROM_O_sel 
	port map (
		CLK => Clk,
      EN => Enable_rom,
      ADDR => Rom_addr,
      DATA => MUX_IN4
	);
	
	ROM5 : ROM_X_Sel
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN5
	);


end Behavioral;

