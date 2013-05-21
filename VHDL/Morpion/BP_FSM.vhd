----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013 
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
SIGNAL etat_present_BP	:etats := WAIT_RELEASE;
SIGNAL etat_futur_BP		:etats := WAIT_RELEASE;

signal cond_wait_release : std_logic;
signal cond_wait_press : std_logic;

BEGIN

	cond_wait_release	<= 	'1' WHEN BP_NEXT ='0' AND BP_PREV ='0' AND BP_OK ='0' ELSE
									'0';
	cond_wait_press	<= 	'1' WHEN BP_NEXT ='1' OR BP_PREV ='1' OR BP_OK ='1' ELSE
									'0';

	-- Actualisation des etats presents à chaque coup d'horloge et gestion du reset
	PROCESS (Clk, Rst) 
	BEGIN
	
		IF (Rst = '1') THEN 
				etat_present_BP <= WAIT_RELEASE;	-- En cas de reset, initialisation état A

		ELSIF (Clk'event AND Clk = '1') THEN
			
			IF(CE = '1') THEN
				etat_present_BP <= etat_futur_BP; -- Actualisation des états
			ELSE
				etat_present_BP <= etat_present_BP;
			END IF;
			
		END IF;
		
	END PROCESS;
	
	-- Definition des etats futurs en fonction de la FSM				
	PROCESS (etat_present_BP, BP_NEXT, BP_PREV, BP_OK, BP_ENABLE, cond_wait_release, cond_wait_press)
	BEGIN
		CASE etat_present_BP IS
		
			WHEN WAIT_RELEASE	=>	
				--IF (BP_NEXT ='0' AND BP_PREV ='0' AND BP_OK ='0') THEN
				IF (cond_wait_release = '1') THEN
					etat_futur_BP <= WAIT_PRESS;
				ELSE
					etat_futur_BP <= WAIT_RELEASE;
				END IF;

			WHEN WAIT_PRESS 	=>
				--IF (BP_NEXT ='1' OR BP_PREV ='1' OR BP_OK ='1') THEN
				IF (cond_wait_press = '1') THEN
					etat_futur_BP <= BP_DETECT;
				ELSE 
					etat_futur_BP <= WAIT_PRESS;
				END IF;
				
			WHEN BP_DETECT		=>
				etat_futur_BP <= WAIT_ENABLE;
				
			WHEN WAIT_ENABLE	=>
				IF (BP_ENABLE ='1') THEN
					etat_futur_BP <= WAIT_RELEASE;
				ELSE 
					etat_futur_BP <= WAIT_ENABLE;
				END IF;
				
			WHEN OTHERS			=>
				etat_futur_BP <= WAIT_RELEASE;

		END CASE;
	END PROCESS;
	
	
	--Affectation des sorties si l'état présent a changé
	PROCESS (etat_present_BP, BP_NEXT, BP_PREV, BP_OK) BEGIN	
		
		CASE etat_present_BP IS 
			WHEN  WAIT_RELEASE =>
				Data_toReg					<= "00000000";
				RegLoad 						<= '0';
				RegClear						<= '1';
			WHEN  WAIT_PRESS =>
				Data_toReg					<= "00000000";
				RegLoad 						<= '0';
				RegClear						<= '0';
			WHEN  BP_DETECT =>
				RegLoad 						<= '1';
				RegClear						<= '0';
				Data_toReg(0)				<= (BP_NEXT); 
				Data_toReg(1)				<= (BP_PREV);
				Data_toReg(2)				<= (BP_OK);
				Data_toReg(7 DOWNTO 3)	<= "00000";
			WHEN  WAIT_ENABLE =>
				RegLoad 						<= '0';
				RegClear						<= '0';
				Data_toReg					<= "00000000";
			WHEN  OTHERS =>
				RegLoad						<= '0';
				RegClear						<= '0';				Data_toReg					<= "00000000";
			
		END CASE;
	END PROCESS;

end Behavioral;




