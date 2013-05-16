----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:33:34 05/14/2013 
-- Design Name: 
-- Module Name:    MUX_8to1 - Behavioral 
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

entity MUX_8to1 is
    Port ( Data_In_0 : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_In_1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_2	: in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_3 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_4 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_5 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_6 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Data_In_7 : in  STD_LOGIC_VECTOR (7 downto 0);
           Channel   : in  STD_LOGIC_VECTOR (2 downto 0);
           Data_Out  : out STD_LOGIC_VECTOR (7 downto 0));
end MUX_8to1;

architecture Behavioral of MUX_8to1 is

begin

	
   with Channel select
      Data_Out <= Data_In_0 when "000",
						Data_In_1 when "001",
						Data_In_2 when "010",
						Data_In_3 when "011",
						Data_In_4 when "100",
						Data_In_5 when "101",
						Data_In_6 when "110",
						Data_In_7 when "111",
						"00000000" when others;
						
end Behavioral;

