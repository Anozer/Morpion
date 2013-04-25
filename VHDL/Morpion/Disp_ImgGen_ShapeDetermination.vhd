----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:00:00 04/25/2013 
-- Design Name: 
-- Module Name:    Disp_ImgGen_ShapeDetermination - Behavioral 
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

entity Disp_ImgGen_ShapeDetermination is
	Port(	Clk			: IN  STD_LOGIC;
			Rst 			: IN  STD_LOGIC;
			CE 			: IN  STD_LOGIC;
			Busy			: IN  STD_LOGIC;
			Pos_Load		: IN  STD_LOGIC;
			Ok_Load		: IN  STD_LOGIC;
			Player		: IN  STD_LOGIC;
			Ok				: IN  STD_LOGIC_VECTOR(7 downto 0);
			Pos			: IN  STD_LOGIC_VECTOR(7 downto 0);
			Grid_State	: IN STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player	: IN STD_LOGIC_VECTOR(8 downto 0);
			Shape_Load	: IN STD_LOGIC;
			Shape_Numb	: IN STD_LOGIC_VECTOR(2 downto 0);
			Shape_Coord	: IN STD_LOGIC_VECTOR(18 downto 0));
end Disp_ImgGen_ShapeDetermination;

architecture Behavioral of Disp_ImgGen_ShapeDetermination is

-- Types et signaux correspondant aux états de la FSM
type etats is (START, WAIT_CHANGE, OK, NEW_POS, OLD_POS, WAIT_BUSY);
signal etat_present		:etats := START;
signal etat_futur			:etats := START;
signal sig_NewPos			: std_logic;
signal sig_OldPos			: std_logic;
signal sig_EraseOldPos	: std_logic;

begin

-- Actualisation des etats presents à chaque coup d'horloge et gestion du reset
	process (Clk, Rst) 
	begin
	
		if (Rst = '1') then 
				etat_present <= START;	-- En cas de reset, initialisation état A

		elsif (Clk'event and Clk = '1') then
			
			if(CE = '1') then
				etat_present <= etat_futur; -- Actualisation des états
			else
				etat_present <= etat_present;
			end if;
			
		end if;
		
	end process;
	
	-- Definition des etats futurs en fonction de la FSM	
	process (etat_present, Pos_Load, Ok_Load, sig_EraseOldPos, Busy )
	begin
		CASE etat_present IS
		
			WHEN START 			=>	
				etat_futur <= WAIT_CHANGE;

			WHEN WAIT_CHANGE 	=>
				if (Ok_Load = "1") then
					etat_futur <= OK;
				elsif (Pos_Load = "1") then
					etat_futur <= NEW_POS;
				elsif (sig_EraseOldPos = "1") then
					etat_futur <= OLD_POS;
				else
					etat_futur <= WAIT_CHANGE;
				end if;
				

end Behavioral;

