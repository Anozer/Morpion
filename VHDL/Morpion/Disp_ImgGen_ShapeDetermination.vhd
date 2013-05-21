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
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

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
			Player_Load	: IN  STD_LOGIC;
			Ok				: IN  STD_LOGIC_VECTOR(7 downto 0);
			Pos			: IN  STD_LOGIC_VECTOR(7 downto 0);
			Player		: IN  STD_LOGIC;
			OldPos		: IN  STD_LOGIC_VECTOR(7 downto 0);
			Grid_State	: IN  STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player	: IN  STD_LOGIC_VECTOR(8 downto 0);
			Win_J1		: IN  STD_LOGIC;
			Win_J2		: IN  STD_LOGIC;
			Shape_Load	: OUT STD_LOGIC;
			Shape_Numb	: OUT STD_LOGIC_VECTOR(2 downto 0);
			Area_Numb	: OUT STD_LOGIC_VECTOR(7 downto 0));
end Disp_ImgGen_ShapeDetermination;

architecture Behavioral of Disp_ImgGen_ShapeDetermination is

-- Types et signaux correspondant aux états de la FSM
type etats is (START, WAIT_CHANGE, NEW_OK, NEW_POS, OLD_POS, WAIT_BUSY_OLD, WAIT_BUSY, NEW_PLAYER, WINNER, INIT, BUSY_INIT);
signal etat_present		:etats := START;
signal etat_futur			:etats := START;

begin

-- Actualisation des etats presents à chaque coup d'horloge et gestion du reset
	process (Clk, Rst) 
	begin
		if (Rst = '1') then 
				etat_present <= START;	-- En cas de reset, initialisation état START

		elsif (Clk'event and Clk = '1') then
			
			if(CE = '1') then
				etat_present <= etat_futur; -- Actualisation des états
			else
				etat_present <= etat_present;
			end if;
			
		end if;
		
	end process;
	
	-- Definition des etats futurs en fonction de la FSM	
	process (etat_present, Pos_Load, Ok_Load, Busy, player_load, Win_J1, Win_J2 )
	begin
		CASE etat_present IS
			WHEN START 			=>	
				etat_futur <= INIT;
				
			WHEN INIT 			=>	
				etat_futur <= BUSY_INIT;
				
			WHEN BUSY_INIT 			=>	
				if (busy = '0') then
					etat_futur <=  WAIT_CHANGE;
				else
					etat_futur <= BUSY_INIT;
				end if;
				
			WHEN WAIT_CHANGE 	=>
				if (Ok_Load = '1') then
					etat_futur <= NEW_OK;
				elsif (Player_Load = '1') then
					etat_futur <= NEW_PLAYER;
				elsif (Pos_Load = '1') then
					etat_futur <= OLD_POS;
				elsif (Win_J1= '1' OR Win_J2 ='1') then
					etat_futur <= WINNER;
				else
					etat_futur <= WAIT_CHANGE;
				end if;
				
			WHEN NEW_OK			=>
				etat_futur <= WAIT_BUSY;
				
			WHEN NEW_PLAYER			=>
				etat_futur <= WAIT_BUSY;
				
			WHEN OLD_POS		=>
				etat_futur <= WAIT_BUSY_OLD;
			
			WHEN NEW_POS		=>
				etat_futur <= WAIT_BUSY;
			
			WHEN WAIT_BUSY_OLD =>
				if (busy = '0') then
					etat_futur <= NEW_POS;
				else
					etat_futur <= WAIT_BUSY_OLD;
				end if;
				
			WHEN WAIT_BUSY		=>
				if (busy = '0') then
					etat_futur <= WAIT_CHANGE;
				else
					etat_futur <= WAIT_BUSY;
				end if;
				
			WHEN WINNER	=>
					etat_futur <= WINNER;
			
			WhEN OTHERS			=>
				etat_futur <= START;
		END CASE;
	end process;
	
	process (etat_present, grid_state, grid_player, oldPos, pos, OK, player, Win_J1, Win_J2)
	begin
		CASE etat_present IS
			WHEN START 				=>	
				Shape_load	<= '0';
				Shape_numb	<= "000";
				Area_numb	<= (others => '0');
				
			WHEN INIT			=>
				Shape_load	<= '1';
				Shape_numb	<= "000";
				Area_numb	<= "00001010";
				
			WHEN BUSY_INIT			=>
				Shape_load	<= '0';
				Shape_numb	<= "000";
				Area_numb	<= (others => '0');
				
			WHEN WAIT_CHANGE 		=>
				Shape_load	<= '0';
				Shape_numb	<= "000";
				Area_numb	<= (others => '0');
				
			WHEN NEW_OK				=>
				Shape_load	<= '1';
				Shape_numb	<= "11" & grid_player(to_integer(unsigned(Pos)));
				Area_numb	<= Pos;
				
			WHEN NEW_PLAYER				=>
				Shape_load	<= '1';
				Shape_numb	<= "01" & Player;
				Area_numb	<= "00001001";
				
			WHEN NEW_POS			=>
				Shape_load	<= '1';
				Shape_numb	<= '1' & grid_state(to_integer(unsigned(Pos))) & grid_player(to_integer(unsigned(Pos)));
				Area_numb	<= Pos;
				
			WHEN OLD_POS			=>
				Shape_load	<= '1';
				Shape_numb	<= '0' & grid_state(to_integer(unsigned(oldPos))) & grid_player(to_integer(unsigned(oldPos)));
				Area_numb	<= oldPos;
				
			WHEN WAIT_BUSY_OLD	=>
				Shape_load	<= '0';
				Shape_numb	<= "000";
				Area_numb	<= (others => '0');
				
			WHEN WAIT_BUSY			=>
				Shape_load	<= '0';
				Shape_numb	<= "000";
				Area_numb	<= (others => '0');
				
			WHEN WINNER			=>
				Shape_load	<= '1';
				Shape_numb	<= "101";
				Area_numb	<= "00001010";
				
			WHEN OTHERS				=>
				Shape_load	<= '0';
				Shape_numb	<= "000";
				Area_numb	<= (others => '0');
			
		END CASE;
		
	end process;
	
	
end Behavioral;

