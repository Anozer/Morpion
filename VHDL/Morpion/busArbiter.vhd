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
	Port (Enable		: in	STD_LOGIC;
			AddrBus		: in	STD_LOGIC_VECTOR(5 downto 0);
			Enable_RAM	: out	STD_LOGIC;
			Enable_BP	: out	STD_LOGIC;
			Enable_DISP	: out	STD_LOGIC);
end busArbiter;

architecture Behavioral of busArbiter is

begin
	Enable_RAM	<= Enable AND (NOT(AddrBus(5)) OR (AddrBus(5) AND NOT(AddrBus(4))) OR (AddrBus(5) AND AddrBus(4) AND NOT(AddrBus(3))));
	Enable_BP	<= Enable AND (AddrBus(5) AND AddrBus(4) AND AddrBus(3) AND NOT(AddrBus(2)) AND NOT(AddrBus(1)) AND NOT(AddrBus(0)));
	Enable_DISP	<= Enable AND ((AddrBus(5) AND AddrBus(4) AND AddrBus(3) AND NOT(AddrBus(2)) AND NOT(AddrBus(1)) AND(AddrBus(0))) OR (AddrBus(5) AND AddrBus(4) AND AddrBus(3) AND NOT(AddrBus(2)) AND AddrBus(1)));
end Behavioral;

