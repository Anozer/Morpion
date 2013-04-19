----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:16:29 04/19/2013 
-- Design Name: 
-- Module Name:    VRAM - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity VRAM is
    port (Clk  		: in 	std_logic;
          CE  			: in 	std_logic;
          Enable_w   : in 	std_logic;
          Addr_w 		: in 	std_logic_vector	(19 downto 0);
			 Addr_r 		: in 	std_logic_vector	(19 downto 0);
          Data_in   	: in 	std_logic_vector	(7 downto 0);
          Data_out   : out std_logic_vector	(7 downto 0));
end VRAM;

architecture Behavioral of VRAM is
    type ram_type is array (19 downto 0) of std_logic_vector (7 downto 0);
    signal VRAM: ram_type := ((others=> (others=>'0')));
begin

process (Clk)
begin
   if (Clk'event and Clk = '1') then
		if (CE = '1') then
			if (Enable_w = '1') then
				VRAM (to_integer(unsigned(Addr_w))) <= Data_in;
			end if;
			Data_out <= VRAM(to_integer(unsigned(Addr_r)));
		end if;
	end if;
end process;


end Behavioral;

					
