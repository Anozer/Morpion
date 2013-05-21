----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
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
use IEEE.NUMERIC_STD.ALL;

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
		Area_Numb	: IN  STD_LOGIC_VECTOR(7 downto 0);
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
		DATA	: OUT STD_LOGIC);
end component;

component ROM_Vide_sel
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN  STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC);
end component;

component ROM_O
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN  STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC);
end component;


component ROM_O_sel
port (CLK : in std_logic;
      EN : in std_logic;
      ADDR : in std_logic_vector(13 downto 0);
      DATA : out std_logic);
end component;


component ROM_X
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN  STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC);
end component;

component ROM_X_sel
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC);
end component;

component ROM_victoire
	port (
		Clk	: IN  STD_LOGIC;
		En		: IN  STD_LOGIC;
		ADDR	: IN STD_LOGIC_VECTOR(13 downto 0);
		DATA	: OUT STD_LOGIC);
end component;


signal sig_ShapeNumb : STD_LOGIC_VECTOR(2 downto 0);

signal Enable_rom	: STD_LOGIC;
signal ROM_addr	: STD_LOGIC_VECTOR(13 downto 0);

signal coord_init	: STD_LOGIC_VECTOR(18 downto 0);
signal X_init		: STD_LOGIC_VECTOR(9 downto 0);
signal Y_init		: STD_LOGIC_VECTOR(8 downto 0);
signal X_rom		: STD_LOGIC_VECTOR(6 downto 0);
signal Y_rom		: STD_LOGIC_VECTOR(6 downto 0);
signal X_vram		: STD_LOGIC_VECTOR(9 downto 0);
signal Y_vram		: STD_LOGIC_VECTOR(8 downto 0);

signal MUX_IN0		: STD_LOGIC;
signal MUX_IN1		: STD_LOGIC;
signal MUX_IN2		: STD_LOGIC;
signal MUX_IN3		: STD_LOGIC;
signal MUX_IN4		: STD_LOGIC;
signal MUX_IN5		: STD_LOGIC;
signal MUX_IN6		: STD_LOGIC;
signal MUX_IN7		: STD_LOGIC;

type coord_tab is array (10 downto 0) of std_logic_vector(18 downto 0);
constant Shape_Coord : coord_tab := (
	0 => "0001101010010000101",	-- x134 y54
	1 => "0001101010100000010",	-- x259 y54
	2 => "0001101010101111111",	-- x384 y54
	3 => "0101100100010000101",	-- x134 y179
	4 => "0101100100100000010",	-- x259 y179
	5 => "0101100100101111111",	-- x384 y179
	6 => "1001011110010000101",	-- x134 y304
	7 => "1001011110100000010",	-- x259 y304
	8 => "1001011110101111111",	-- x384 y304
	9 => "0011101110000000011",	-- x4 y120 : info joueur
	10 => "0011101111000000011"	-- x516 y120 : victoire
);

begin		

	VRAM_enable <= Enable_rom;
	
	process (Clk, Reset)
	begin 
		if (Reset = '1') then
			Coord_init <= Shape_Coord(0);	
			sig_ShapeNumb <= "000";
		elsif (Clk'event and Clk='1') then
			if(Shape_Load = '1') then
				Coord_init <= Shape_Coord(to_integer(unsigned(Area_numb)));
				sig_ShapeNumb <= Shape_Numb;
			end if;
		end if;
	end process;
	
	
	-- Coord de la case
	X_init <= Coord_init( 9 downto  0);
	Y_init <= Coord_init(18 downto 10);

	-- Coord de la VRAM = case+rom
	X_vram <= X_init + ("000" & X_rom);
	Y_vram <= Y_init +  ("00" & Y_rom);
	
	-- Adresses des mémoires
	ROM_addr  <= Y_rom & X_rom;
	VRAM_addr <= Y_vram & X_vram;
	

	MUX_IN1 <= MUX_IN0;

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
		Data_In_0	=> (others => MUX_IN0),
		Data_In_1	=> (others => MUX_IN1), 
		Data_In_2	=> (others => MUX_IN2),
		Data_In_3	=> (others => MUX_IN3),
		Data_In_4	=> (others => MUX_IN4),
		Data_In_5	=> (others => MUX_IN5),
		Data_In_6	=> (others => MUX_IN6),
		Data_In_7	=> (others => MUX_IN7),
		Channel		=> sig_ShapeNumb,
		Data_Out		=> VRAM_data
	);
	
	ROM0 : ROM_O
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN2
	);
	
	ROM1 : ROM_X
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN3
	);
	
	ROM2 : ROM_Vide
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN0
	);
	
	ROM3 : ROM_Vide_Sel
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN4
	);
	
	ROM4 : ROM_O_sel 
	port map (
		CLK => Clk,
      EN => Enable_rom,
      ADDR => Rom_addr,
      DATA => MUX_IN6
	);
	
	ROM5 : ROM_X_Sel
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN7
	);
	
	ROM6 : ROM_victoire
	port map (
		Clk	=> Clk,
		En		=> Enable_rom,
		ADDR	=> ROM_addr,
		DATA	=> MUX_IN5
	);


end Behavioral;

