----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:18:25 05/20/2013 
-- Design Name: 
-- Module Name:    win_manager - Behavioral 
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

entity win_manager is
	Port( Grid_State		: IN STD_LOGIC_VECTOR(8 downto 0);
			Grid_Player		: IN STD_LOGIC_VECTOR(8 downto 0);
			Enable_win_J1	: OUT STD_LOGIC;
			Enable_win_J2	: OUT STD_LOGIC);
end win_manager;

architecture Behavioral of win_manager is

signal J1 : std_logic_vector (8 downto 0);
signal J2 : std_logic_vector (8 downto 0);

--	0 => "xxxxxx111",
--	1 => "xxx111xxx",
--	2 => "111xxxxxx",
--	3 => "xx1xx1xx1",
--	4 => "1xx1xx1xx",
--	5 => "x1xx1xx1x",
--	6 => "1xxx1xxx1",
--	7 => "xx1x1x1xx";
	
begin

	J1 <= Grid_State and (not Grid_Player);
	J2 <= Grid_State and Grid_Player;
	Enable_win_J1<= 	'1' when J1(0)='1' and J1(1)='1' and J1(2)='1' else
							'1' when	J1(3)='1' and J1(4)='1' and J1(5)='1' else
							'1' when J1(8)='1' and J1(7)='1' and J1(6)='1' else
							'1' when J1(0)='1' and J1(3)='1' and J1(6)='1' else
							'1' when J1(2)='1' and J1(5)='1' and J1(8)='1' else
							'1' when J1(1)='1' and J1(4)='1' and J1(7)='1' else
							'1' when	J1(0)='1' and J1(4)='1' and J1(8)='1' else
							'1' when J1(2)='1' and J1(4)='1' and J1(6)='1' else
							'0';
							
	Enable_win_J2<= 	'1' when	J2(0)='1' and J2(1)='1' and J2(2)='1' else
							'1' when J2(3)='1' and J2(4)='1' and J2(5)='1' else
							'1' when J2(8)='1' and J2(7)='1' and J2(6)='1' else
							'1' when J2(0)='1' and J2(3)='1' and J2(6)='1' else
							'1' when J2(2)='1' and J2(5)='1' and J2(8)='1' else
							'1' when J2(1)='1' and J2(4)='1' and J2(7)='1' else
							'1' when J2(0)='1' and J2(4)='1' and J2(8)='1' else
							'1' when J2(2)='1' and J2(4)='1' and J2(6)='1' else
							'0';			
							
							
							
				
end Behavioral;

