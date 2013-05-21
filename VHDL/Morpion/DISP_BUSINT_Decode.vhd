----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
-- Design Name: 
-- Module Name:    DISP_BUSINT_Decode - Behavioral 
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

entity DISP_BUSINT_Decode is
    Port(Data_In			: in  STD_LOGIC_VECTOR(5 downto 0);
			Enable_Disp		: in  STD_LOGIC;
			RW					: in STD_LOGIC;
			POS_Load			: out STD_LOGIC;
			OK_Load			: out STD_LOGIC;
			PLAYER_Load		: out STD_LOGIC);
end DISP_BUSINT_Decode;

architecture Behavioral of DISP_BUSINT_Decode is
	
begin

	POS_Load 	<= '1' WHEN Data_In	="111010" and RW = '1' and Enable_Disp = '1' ELSE 
						'0';
	OK_Load 		<= '1' WHEN Data_In	="111011" and RW = '1' and Enable_Disp = '1' ELSE
						'0';	
	PLAYER_Load <= '1' WHEN Data_In	="111001" and RW = '1' and Enable_Disp = '1' ELSE
						'0';	
	
end Behavioral;

