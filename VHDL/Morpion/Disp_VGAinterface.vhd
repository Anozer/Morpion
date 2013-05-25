----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013
-- Design Name: 
-- Module Name:    Disp_VGAinterface - Behavioral 
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

entity Disp_VGAinterface is
	Port (Clk				: in  STD_LOGIC;
			CE					: in  STD_LOGIC;
			Reset				: in  STD_LOGIC;
			VRAM_enableW	: in  STD_LOGIC;
			VRAM_addrW		: in	STD_LOGIC_VECTOR(18 downto 0);
			VRAM_dataIn		: in  STD_LOGIC_VECTOR(7 downto 0);
			SW					: in  STD_LOGIC_VECTOR(7 downto 0);
			HS					: OUT STD_LOGIC;
			VS					: OUT STD_LOGIC;
			VRAM_dataOut	: OUT STD_LOGIC_VECTOR(7 downto 0));
end Disp_VGAinterface;

architecture Behavioral of Disp_VGAinterface is

	component Disp_VGAsync
		Port (Clk			: in  STD_LOGIC;
				CE				: in  STD_LOGIC;
				Reset			: in  STD_LOGIC;
				IMG			: OUT STD_LOGIC;
				HS				: OUT STD_LOGIC;
				VS				: OUT STD_LOGIC;
				VRAM_addr	: out STD_LOGIC_VECTOR(18 downto 0));
	end component;
	
	component VRAM
		port (Clk  		: in 	std_logic;
			CE  			: in 	std_logic;
			Enable_w   : in 	std_logic;
			Addr_w 		: in 	std_logic_vector	(18 downto 0);
			Addr_r 		: in 	std_logic_vector	(18 downto 0);
			Data_in   	: in 	std_logic;
			Data_out   : out std_logic);
	end component;
	
	signal VRAM_addrR : std_logic_vector(18 downto 0);
	signal pixel_out : std_logic;
	signal pixel_in : std_logic;
	signal img : std_logic;
	
	signal couleur0: std_logic_vector(7 downto 0);
	signal couleur1: std_logic_vector(7 downto 0);
begin
	VRAM_dataOut <=	couleur0 WHEN img='1' AND pixel_out = '0' ELSE
							couleur1 WHEN img='1' AND pixel_out = '1' ELSE
							"00000000";
	couleur1 <= SW;
	couleur0(0) <= (SW(2) XOR SW(1)) OR (SW(2) AND NOT(SW(0)));
	couleur0(1) <= '0';
	couleur0(2) <= '0';
	couleur0(3) <= (SW(5) XOR SW(4)) OR (SW(5) AND NOT(SW(3)));
	couleur0(4) <= '0';
	couleur0(5) <= '0';
	couleur0(6) <= SW(7) AND NOT(SW(6));
	couleur0(7) <= '0';

	
	pixel_in <= VRAM_dataIn(0);

	VGA_sync : Disp_VGAsync 
	port map (
		Clk			=> Clk,
		CE				=> Ce,
		Reset			=> Reset,
		IMG			=> img,
		HS				=> HS,
		VS				=> VS,
		VRAM_addr	=> VRAM_addrR);
	

	VGA_VRAM : VRAM 
	port map (
		Clk			=> Clk,
		CE				=> Ce,
		Enable_w		=> VRAM_enableW,
		Addr_w		=> VRAM_addrW,
		Addr_r		=> VRAM_addrR,
		Data_in		=> pixel_in,
		Data_out		=> pixel_out);

end Behavioral;

