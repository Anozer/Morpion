----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:21:41 04/15/2013 
-- Design Name: 
-- Module Name:    busArbiter - Behavioral 
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

entity busArbiter is
	Port (ENABLE		: in	STD_LOGIC;
			ADDR			: in	STD_LOGIC_VECTOR(5 downto 0);
			ENABLE_RAM	: out	STD_LOGIC;
			ENABLE_BP	: out	STD_LOGIC;
			ENABLE_DISP	: out	STD_LOGIC);
end busArbiter;

architecture Behavioral of busArbiter is

begin
	ENABLE_RAM	<= ENABLE AND (NOT(ADDR(5)) OR (ADDR(5) AND NOT(ADDR(4))) OR (ADDR(5) AND ADDR(4) AND NOT(ADDR(3))));
	ENABLE_BP	<= ENABLE AND (ADDR(5) AND ADDR(4) AND ADDR(3) AND NOT(ADDR(2)) AND NOT(ADDR(1)) AND NOT(ADDR(0)));
	ENABLE_DISP	<= ENABLE AND ((ADDR(5) AND ADDR(4) AND ADDR(3) AND NOT(ADDR(2)) AND NOT(ADDR(1)) AND(ADDR(0))) OR (ADDR(5) AND ADDR(4) AND ADDR(3) AND NOT(ADDR(2)) AND ADDR(1)));
end Behavioral;

