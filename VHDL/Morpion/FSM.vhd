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

entity FSM is
    Port ( Clk 		: in  STD_LOGIC;
           Rst 		: in  STD_LOGIC;
           CE 			: in  STD_LOGIC;
           Carry 		: in  STD_LOGIC;
           Code_Op	: in  STD_LOGIC_VECTOR (1 downto 0);
           A 			: out  STD_LOGIC;
           B 			: out  STD_LOGIC;
           C 			: out  STD_LOGIC;
           D 			: out  STD_LOGIC;
           E 			: out  STD_LOGIC;
           F 			: out  STD_LOGIC;
           G 			: out  STD_LOGIC;
           H 			: out  STD_LOGIC;
           I 			: out  STD_LOGIC;
           J 			: out  STD_LOGIC;
           K 			: out  STD_LOGIC;
           L 			: out  STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

-- Types et signaux correspondant aux états de la FSM
type etats is (INIT, FETCH_INST, DECODE, FETCH_OP, STORE, JUMP, EXECUTE);
signal etat_present	:etats := INIT;
signal etat_futur		:etats := INIT;

begin

	-- Actualisation des etats presents à chaque coup d'horloge et gestion du reset
	process (Clk, Rst) 
	begin
	
		if (Rst = '1') then 
				etat_present <= INIT;	-- En cas de reset, initialisation état A

		elsif (Clk'event and Clk = '1') then
			
			if(CE = '1') then
				etat_present <= etat_futur; -- Actualisation des états
			end if;
			
		end if;
		
	end process;
	
	-- Definition des etats futurs en fonction de la FSM				
	process (etat_present, Carry, Code_Op)
	begin
		CASE etat_present IS
		
			WHEN INIT 			=>	
				etat_futur <= FETCH_INST;

			WHEN FETCH_INST 	=>
				etat_futur <= DECODE ;
				
			WHEN DECODE 		=>
				if (Code_Op = "10") then
					etat_futur <= STORE;
				elsif (Code_Op = "11") then
					etat_futur <= JUMP;
				elsif (Code_Op(1)= '0') then
					etat_futur <= FETCH_OP ;
				end if;

			WHEN FETCH_OP 		=>
				etat_futur <= EXECUTE ;

			WHEN STORE 			=>
				etat_futur <= FETCH_INST;

			WHEN JUMP 			=>
				etat_futur <= FETCH_INST;

			WHEN EXECUTE		=>
				etat_futur <= FETCH_INST;
				
			WHEN OTHERS			=>
				etat_futur <= INIT;
				
		END CASE;
	end process;
	
	
	--Affectation des sorties si l'état présent a changé
	process (etat_present, carry, code_op) begin	
	
		if 	(etat_present = INIT) then --
			A <= '0';
			B <= '1';
			C <= '0';
			D <= '0';
			E <= '0';
			F <= '0';
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
			L <= '1';


		elsif (etat_present = FETCH_INST) then -- 
			A <= '1';
			B <= '0';
			C <= '0';
			D <= '0';
			E <= '1';
			F <= '1';
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
			L <= '0';
		
		elsif (etat_present =  DECODE) then --
			A <= '0';
			B <= '0';
			C <= '0';
			D <= '1';
			E <= '0';
			F <= '0';
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
			L <= '0';
			
		elsif (etat_present = FETCH_OP) then --
			A <= '0';
			B <= '0';
			C <= '0';
			D <= '1';
			E <= '0';
			F <= '1';
			G <= '0';
			H <= '0';
			I <= '1';
			J <= '0';
			K <= '0';
			L <= '0';
			
		elsif (etat_present = STORE) then -- 
			A <= '0';
			B <= '0';
			C <= '0';
			D <= '1';
			E <= '0';
			F <= '1';
			G <= '1';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
			L <= '0';
			
		elsif (etat_present =   JUMP) then --
			A <= '0';
			B <= '0';
			C <= not(Carry);
			D <= '1';
			E <= '1';
			F <= '0';
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
			L <= Carry;
			
		elsif (etat_present = EXECUTE) then -- 		
			A <= '0';
			B <= '0';
			C <= '0';
			D <= '1';
			E <= '0';
			F <= '0';
			G <= '0';
			H <= Code_Op(0);
			I <= '0';
			J <= '1';
			K <=  Code_Op(0);
			L <= '0';
			
		else	--
			A <= '0';
			B <= '0';
			C <= '0';
			D <= '0';
			E <= '0';
			F <= '0';
			G <= '0';
			H <= '0';
			I <= '0';
			J <= '0';
			K <= '0';
			L <= '0';
			
		end if;
	end process;

end Behavioral;



