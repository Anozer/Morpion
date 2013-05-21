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
begin
	VRAM_dataOut <= (others => pixel_out) WHEN img='1' ELSE "00000000";
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

