----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013 
-- Design Name: 
-- Module Name:    Disp_ImgGen_GridManager - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Disp_ImgGen_GridManager is
	Port(	Clk				: IN  STD_LOGIC;
			Rst 				: IN  STD_LOGIC;
         CE 				: IN  STD_LOGIC;
			Ok_Load			: IN  STD_LOGIC;
			Player			: IN  STD_LOGIC;
			OK					: IN  STD_LOGIC_VECTOR(7 downto 0);
			Ok_Load_sync	: OUT STD_LOGIC;
			Grid_State		: OUT STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player		: OUT STD_LOGIC_VECTOR(8 downto 0));
end Disp_ImgGen_GridManager;

architecture Behavioral of Disp_ImgGen_GridManager is
signal Tmp_State 	: std_logic_vector(8 downto 0) := "000000000";
signal Tmp_Player : std_logic_vector(8 downto 0) := "000000000";
begin

	Grid_State 	<= Tmp_State;
	Grid_Player	<= Tmp_Player;
	
	process (Clk,Rst)
		begin

		if (Rst = '1') then
		Tmp_State 	<= "000000000";
		Tmp_Player	<= "000000000";
		
		elsif (Clk'event AND Clk = '1') then
		
			if (CE = '1') then	
			
				if (Ok_Load = '1') then
				
					if (Tmp_State(to_integer(unsigned(OK))) = '0') then
						Tmp_State(to_integer(unsigned(OK)))	<= '1';
						Tmp_Player(to_integer(unsigned(OK)))<= Player;
						Ok_Load_sync <= '1';
					else
						Ok_Load_sync <= '0';
					end if;
					
				end if;
				
			end if;
		
		end if;
		
	end process;
end Behavioral;

