----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
-- Design Name: 
-- Module Name:    BP - Behavioral 
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

entity BP is
	Port (Clk				: in  STD_LOGIC;
			CE					: in  STD_LOGIC;
			Reset				: in  STD_LOGIC;
			BP_NEXT 			: IN  STD_LOGIC;
			BP_PREV 			: IN  STD_LOGIC;
			BP_OK	 			: IN  STD_LOGIC;
			Enable			: IN  STD_LOGIC;
			RW					: IN	STD_LOGIC;
			DataBus_toCPU	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
end BP;

architecture Behavioral of BP is

	component BP_REG8bits
			Port (	Clk			: in	STD_LOGIC;							-- Horloge
						Rst			: in	STD_LOGIC;							-- Reset asynchrone du composant
						CE				: in  STD_LOGIC;							-- Clock Enable, actication du composant
						Load			: in  STD_LOGIC;							-- Chargement de la valeur d'entrée
						CLR			: in  STD_LOGIC;							-- RAZ de Data_Out
						Data_In		: in	STD_LOGIC_VECTOR(7 downto 0);	-- Valeur d'entrée
						Data_Out		: out	STD_LOGIC_VECTOR(7 downto 0));-- Valeur de sortie
	end component;
	
	component BP_FSM
			PORT (	Clk 			: IN  STD_LOGIC;
						Rst 			: IN  STD_LOGIC;
						CE 			: IN  STD_LOGIC;
						BP_NEXT 		: IN  STD_LOGIC;
						BP_PREV 		: IN  STD_LOGIC;
						BP_OK	 		: IN  STD_LOGIC;
						BP_ENABLE	: IN  STD_LOGIC;
						RegClear		: OUT  STD_LOGIC;
						RegLoad 		: OUT  STD_LOGIC;
						Data_toReg	: OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;
	
	signal RegClear		: STD_LOGIC;
	signal RegLoad			: STD_LOGIC;
	signal Data_fsm2reg	: STD_LOGIC_VECTOR(7 downto 0);
	signal Data_reg2bus	: STD_LOGIC_VECTOR(7 downto 0);
	signal Enable_FSM		: STD_LOGIC;

begin
	DataBus_toCPU <= not(Data_reg2bus);
	Enable_FSM <= Enable WHEN RW = '0' ELSE '0';
	
	BP_FSM_in : BP_FSM port map (
		Clk,
		Reset,
		CE,
		BP_NEXT,
		BP_PREV,
		BP_OK,
		Enable_FSM,
		RegClear,
		RegLoad,
		Data_fsm2reg (7 downto 0));
		
	BP_REG_out: BP_REG8bits port map (
		Clk,
		Reset,
		CE,
		RegLoad,
		RegClear,
		Data_fsm2reg (7 downto 0),
		Data_reg2bus (7 downto 0));

end Behavioral;

