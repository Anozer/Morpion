----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
-- Design Name: 
-- Module Name:    Disp_ImgGen_ShapeGenerator_Cpt - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Disp_ImgGen_ShapeGenerator_Cpt is
	port (
		Clk			: IN  STD_LOGIC;
		Reset			: IN  STD_LOGIC;
		Ce				: IN  STD_LOGIC;
		Load			: IN  STD_LOGIC;
		X_out			: OUT	STD_LOGIC_VECTOR(6 downto 0);
		Y_out			: OUT STD_LOGIC_VECTOR(6 downto 0);
		Counting		: OUT STD_LOGIC);
end Disp_ImgGen_ShapeGenerator_Cpt;

architecture Behavioral of Disp_ImgGen_ShapeGenerator_Cpt is


constant X_max : integer := 119;
constant Y_max : integer := 119;


subtype coordX is integer range 0 to X_max;
subtype coordY is integer range 0 to Y_max;
signal comptX : coordX;
signal comptY : coordY;
signal enable_cpt : std_logic;


begin
	Counting <= enable_cpt;
	X_out <=	std_logic_vector(to_unsigned(comptX, 7)) WHEN enable_cpt = '1' ELSE (others => '0');
	Y_out <=	std_logic_vector(to_unsigned(comptY, 7)) WHEN enable_cpt = '1' ELSE (others => '0');
	
	-- Contrôle des compteurs sur enable_cpt
	process (Clk, Reset)
	begin 
		if (Reset = '1') then
			enable_cpt <= '0';	
		elsif (Clk'event and Clk='1') then
			if(CE = '1') then
				if(Load = '1') then
					enable_cpt <= '1';
				elsif (comptY = Y_max) then
					if(comptX = X_max) then
						enable_cpt <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;

	-- Compteurs X et Y
	process (Clk, Reset)
	begin 
		if (Reset = '1') then
			comptX <= 0;
			comptY <= 0;
		elsif (Clk'event and Clk='1') then
			if(CE = '1') then
				if(enable_cpt = '1') then
					if comptX < X_max then 
						comptX <= comptX+1;
					else 
						comptX<= 0;
					end if;

					if comptX=X_max then 
						if comptY< Y_max then 
							comptY <= comptY+1;
						else 
							comptY <= 0;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	

end Behavioral;

