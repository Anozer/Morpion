----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:16:47 02/21/2013 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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

ENTITY BP_FSM IS
    PORT ( Clk 			: IN  STD_LOGIC;
           Rst 			: IN  STD_LOGIC;
           CE 				: IN  STD_LOGIC;
           BP_NEXT 		: IN  STD_LOGIC;
			  BP_PREV 		: IN  STD_LOGIC;
			  BP_OK	 		: IN  STD_LOGIC;
			  BP_ENABLE		: IN  STD_LOGIC;
			  RegClear		: OUT  STD_LOGIC;
			  RegLoad 		: OUT  STD_LOGIC;
           Data_toReg	: OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
END BP_FSM;

ARCHITECTURE Behavioral OF BP_FSM IS

-- Types et signaux correspondant aux états de la FSM
TYPE etats IS (WAIT_RELEASE, WAIT_PRESS, BP_DETECT, WAIT_ENABLE);
SIGNAL etat_present	:etats := WAIT_RELEASE;
SIGNAL etat_futur		:etats := WAIT_RELEASE;

BEGIN

	-- Actualisation des etats presents à chaque coup d'horloge et gestion du reset
	PROCESS (Clk, Rst) 
	BEGIN
	
		IF (Rst = '1') THEN 
				etat_present <= WAIT_RELEASE;	-- En cas de reset, initialisation état A

		ELSIF (Clk'event AND Clk = '1') THEN
			
			IF(CE = '1') THEN
				etat_present <= etat_futur; -- Actualisation des états
			END IF;
			
		END IF;
		
	END PROCESS;
	
	-- Definition des etats futurs en fonction de la FSM				
	PROCESS (etat_present, BP_NEXT, BP_PREV, BP_OK, BP_ENABLE)
	BEGIN
		CASE etat_present IS
		
			WHEN WAIT_RELEASE	=>	
				IF (BP_NEXT ='0' AND BP_PREV ='0' AND BP_OK ='0') THEN
					etat_futur <= WAIT_PRESS;
				END IF;

			WHEN WAIT_PRESS 	=>
				IF (BP_NEXT ='1' OR BP_PREV ='1' OR BP_OK ='1') THEN
					etat_futur <= BP_DETECT;
				ELSE 
					etat_futur <= WAIT_PRESS;
				END IF;
				
			WHEN BP_DETECT		=>
				etat_futur <= WAIT_ENABLE;
				
			WHEN WAIT_ENABLE	=>
				IF (BP_ENABLE ='1') THEN
					etat_futur <= WAIT_RELEASE;
				ELSE 
					etat_futur <= WAIT_ENABLE;
				END IF;
				

		END CASE;
	END PROCESS;
	
	
	--Affectation des sorties si l'état présent a changé
	PROCESS (etat_present, BP_NEXT, BP_PREV, BP_OK) BEGIN	
	
		IF	(etat_present = WAIT_RELEASE) THEN --
			RegLoad 						<= '0';
			RegClear						<= '1';

		ELSIF	(etat_present = WAIT_PRESS) THEN --
			RegLoad 						<= '0';
			RegClear						<= '0';

		ELSIF (etat_present = BP_DETECT) THEN -- 
			RegLoad 						<= '1';
			Data_toReg(0)				<= (BP_NEXT); 
			Data_toReg(1)				<= (BP_PREV);
			Data_toReg(2)				<= (BP_OK);
			Data_toReg(7 DOWNTO 3)	<= "00000";
			
		ELSIF	(etat_present = WAIT_ENABLE) THEN --
			RegLoad 						<= '0';

		END IF;
	END PROCESS;

end Behavioral;





