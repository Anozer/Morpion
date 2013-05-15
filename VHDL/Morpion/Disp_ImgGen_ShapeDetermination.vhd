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
			Player		: IN  STD_LOGIC;
			Ok				: IN  STD_LOGIC_VECTOR(7 downto 0);
			Pos			: IN  STD_LOGIC_VECTOR(7 downto 0);
			Grid_State	: IN  STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player	: IN  STD_LOGIC_VECTOR(8 downto 0);
			Shape_Load	: OUT STD_LOGIC;
			Shape_Numb	: OUT STD_LOGIC_VECTOR(2 downto 0);
			Shape_Coord	: OUT STD_LOGIC_VECTOR(18 downto 0));
end Disp_ImgGen_ShapeDetermination;

architecture Behavioral of Disp_ImgGen_ShapeDetermination is

-- Types et signaux correspondant aux états de la FSM
type etats is (START, WAIT_CHANGE, NEW_OK, NEW_POS, OLD_POS, WAIT_BUSY_OLD, WAIT_BUSY);
signal etat_present		:etats := START;
signal etat_futur			:etats := START;
signal sig_OldPos			: std_logic_vector(7 downto 0) := "00000000";

type cells_coord is array (0 to 8) of std_logic_vector(18 downto 0);
constant coord : cells_coord := (
	0 => "0001101100001111100",	-- x125 y55
	1 => "0001101100011111001",	-- x250 y55
	2 => "0001101100101110110",	-- x375 y55
	3 => "0101100110001111100",	-- x125 y180
	4 => "0101100110011111001",	-- x250 y180
	5 => "0101100110101110110",	-- x375 y180
	6 => "1001100000001111100",	-- x125 y305
	7 => "1001100000011111001",	-- x250 y305
	8 => "1001100000101110110"		-- x375 y305
);

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
	process (etat_present, Pos_Load, Ok_Load, Busy )
	begin
		CASE etat_present IS
			WHEN START 			=>	
				etat_futur <= WAIT_CHANGE;

			WHEN WAIT_CHANGE 	=>
				if (Ok_Load = '1') then
					etat_futur <= NEW_OK;
				elsif (Pos_Load = '1') then
					etat_futur <= OLD_POS;
				else
					etat_futur <= WAIT_CHANGE;
				end if;
				
			WHEN NEW_OK			=>
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
			
			WhEN OTHERS			=>
				etat_futur <= START;
		END CASE;
	end process;
	
	process (etat_present, sig_oldPos, grid_state, grid_player, pos, OK, player)
	begin
		CASE etat_present IS
			WHEN START 				=>	
				Shape_load			<= '0';
				Shape_Numb			<= "000";
				Shape_Coord			<= (others => '0');
				sig_oldPos			<= "00000000";
				
			WHEN WAIT_CHANGE 		=>
				Shape_load			<= '0';
				Shape_Numb			<= "000";
				Shape_Coord			<= (others => '0');
				sig_oldPos			<= sig_oldPos;
				
			WHEN NEW_OK				=>
				Shape_load			<= '1';
				Shape_Numb			<= "10" & Player;
				Shape_Coord			<= coord(to_integer(unsigned(OK)));
				sig_oldPos			<= sig_oldPos;
				
			WHEN NEW_POS			=>
				Shape_load			<= '1';
				Shape_Numb			<=	Grid_state(to_integer(unsigned(Pos))) 
											& NOT(Grid_state(to_integer(unsigned(Pos)))) 
											& (NOT(Grid_state(to_integer(unsigned(Pos)))) OR Grid_Player(to_integer(unsigned(Pos))));
				Shape_Coord			<= coord(to_integer(unsigned(Pos)));
				sig_oldPos			<= Pos;
				
			WHEN OLD_POS			=>
				Shape_load			<= '1';
				Shape_Numb			<=	'0' 
											& NOT(Grid_state(to_integer(unsigned(sig_oldPos))))
											& (NOT(Grid_state(to_integer(unsigned(sig_oldPos)))) AND Grid_player(to_integer(unsigned(sig_oldPos))));
				Shape_Coord			<= coord(to_integer(unsigned(sig_oldPos)));
				sig_oldPos			<= sig_OldPos;
				
			WHEN WAIT_BUSY_OLD	=>
				Shape_load			<= '0';
				Shape_Numb			<= "000";
				Shape_Coord			<= (others => '0');
				sig_oldPos			<= sig_oldPos;
				
			WHEN WAIT_BUSY			=>
				Shape_load			<= '0';
				Shape_Numb			<= "000";
				Shape_Coord			<= (others => '0');
				sig_oldPos			<= sig_oldPos;
				
			WhEN OTHERS				=>
				Shape_load			<= '0';
				Shape_Numb			<= "000";
				Shape_Coord			<= (others => '0');
				sig_oldPos			<= "00000000";
		END CASE;
	end process;
	
	
end Behavioral;

