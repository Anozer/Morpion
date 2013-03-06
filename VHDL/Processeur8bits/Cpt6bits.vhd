----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:29:18 02/21/2013 
-- Design Name: 
-- Module Name:    Cpt6bits - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cpt6bits is
	Port (H			: in  STD_LOGIC;
			Rst		: in  STD_LOGIC;
			CE			: in  STD_LOGIC;
			Data_in	: in  STD_LOGIC_VECTOR (5 downto 0);
			Enable	: in  STD_LOGIC;
			Init		: in  STD_LOGIC;
			Load		: in  STD_LOGIC;
			Data_out	: out  STD_LOGIC_VECTOR (5 downto 0));
end Cpt6bits;

architecture Behavioral of Cpt6bits is

signal Val : std_logic_vector (5 downto 0);

begin

	Data_out <= Val;
	
	process (H,Rst) begin
	
		if (Rst = '1') then 
			Val <= "000000";

		elsif (H'event and H = '1') then
		
			if (CE = '1') then 
			
				if (Init = '1') then
					Val <= "000000";
				
				elsif (Load = '1') then
					Val <= Data_in;
				
				elsif (Enable = '1') then
				
					if (Val = "111111") then
						Val <= "000000";
						
					else
						Val <= Val + 1 ;
					
					end if;
					
				end if;
			 
			end if;
		
		end if;
		
	end process;

end Behavioral;



