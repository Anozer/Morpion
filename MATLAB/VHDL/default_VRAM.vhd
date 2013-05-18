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
	port (Clk		: in 	std_logic;
			CE			: in 	std_logic;
			Enable_w	: in 	std_logic;
			Addr_w	: in 	std_logic_vector	(%ADDR_SIZE%);
			Addr_r	: in 	std_logic_vector	(%ADDR_SIZE%);
			Data_in	: in 	%DATA_TYPE%;
			Data_out	: out %DATA_TYPE%);
end VRAM;

architecture Behavioral of VRAM is

	type ram_type is array (%ARRAY_SIZE%) of %DATA_TYPE%;
	signal VRAM: ram_type := (
		%DATAS%
		others=> '0');
begin

	process (Clk)
	begin
		if (Clk'event and Clk = '1') then
			if (CE = '1') then
				if (Enable_w = '1') then
					VRAM (to_integer(unsigned(Addr_w))) <= Data_in;
				end if;
				Data_out <=  VRAM(to_integer(unsigned(Addr_r)));
			else
				NULL;
			end if;
		end if;
	end process;

end Behavioral;

					
