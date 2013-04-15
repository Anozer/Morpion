----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:46 10/26/2010 
-- Design Name: 
-- Module Name:    GeneRGB - Behavioral 
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

entity GeneRGB_C is
    Port ( CLK   : in std_logic;
	        SW : IN std_logic_vector(3 DOWNTO 0);
	        X     : in std_logic_vector(9 downto 0);
           Y     : in std_logic_vector(8 downto 0);
           IMG   : in std_logic;
			  DATA  : in std_logic_vector(15 downto 0);
		     R     : out std_logic;
           G     : out std_logic;
           B     : out std_logic;
			  AD    : out std_logic_vector (12 downto 0));
end GeneRGB_C ;

architecture Behavioral of GeneRGB_C  is

signal Sortie : std_logic;
signal adr_pixel : unsigned (3 downto 0);
signal IMGr : std_logic;

begin

 pixel :  process(CLK) --retard d'une periode d'horloge pour compenser le cycle induit par la mémoire ROM synchrone
  begin
       if (CLK'event and CLK='1') then
            adr_pixel <= unsigned (X(4 downto 1));
				IMGr <= IMG;
      end if;
 end process pixel ; 
 
 Sortie <=  DATA(15 - (to_integer(adr_pixel)));
 AD <= Y(8 downto 1) & X(9 downto 5);

		 
 switches :  process(SW, Sortie,IMG)
      begin
             case SW is
                when "0000" => 	 R <= Sortie and IMGr;
											 B <= Sortie and IMGr;
											 G <= Sortie and IMGr;
                when "0001" =>  	 R <= Sortie and IMGr;
											 B <= '0';
											 G <= '0';
                when "0010" =>  	 R <= '0';
											 B <= Sortie and IMGr;
											 G <= '0';
                when "0011" => 	 R <= Sortie and IMGr;
											 B <= Sortie and IMGr;
											 G <= '0';
					 when "0100" => 	 R <= '0';
											 B <= '0';
											 G <= Sortie and IMGr;
                when "0101" => 	 R <= Sortie and IMGr;
											 B <= '0';
											 G <= Sortie and IMGr;
                when "0110" =>    R <= '0';
											 B <= Sortie and IMGr;
											 G <= Sortie and IMGr;
                when "0111" =>    R <= Sortie and IMGr;
											 B <= Sortie and IMGr;
											 G <= Sortie and IMGr;
					 when others =>    R <= Sortie and IMGr;
											 B <= Sortie and IMGr;
											 G <= Sortie and IMGr;
            end case; 	
       end process switches ; 

end Behavioral;

