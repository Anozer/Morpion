----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:34:44 02/21/2013 
-- Design Name: 
-- Module Name:    MUX6bits - Behavioral 
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

entity MUX6bits is
    Port ( Data_In_0 : in  STD_LOGIC_VECTOR (5 downto 0);
           Data_In_1 : in  STD_LOGIC_VECTOR (5 downto 0);
           Channel   : in  STD_LOGIC;
           Data_Out  : out  STD_LOGIC_VECTOR (5 downto 0));
end MUX6bits;

architecture Behavioral of MUX6bits is

begin

		Data_Out <= Data_In_0 WHEN Channel ='0' ELSE
						Data_In_1;
		
end Behavioral;

