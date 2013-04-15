----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:05:11 10/26/2010 
-- Design Name: 
-- Module Name:    VGA_EX - Behavioral 
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

entity VGA is
    Port ( CLK 	: in  STD_LOGIC;
	        RESET	: in  STD_LOGIC;
	        SW 		: IN std_logic_vector(3 DOWNTO 0);
           HS  	: out  STD_LOGIC;
           VS  	: out  STD_LOGIC;
           R   	: out  STD_LOGIC;
           G   	: out  STD_LOGIC;
           B   	: out  STD_LOGIC;
			  pdb		: inout std_logic_vector(7 downto 0);
			  astb 	: in std_logic;
           dstb 	: in std_logic;
			  pwr 	: in std_logic;
           pwait 	: out std_logic
			  );
end VGA;

architecture Behavioral of VGA is

component dpim is
   Port (
		  mclk 	: in std_logic;
        pdb		: inout std_logic_vector(7 downto 0);
		  reset  : in std_logic;
        astb 	: in std_logic;
        dstb 	: in std_logic;
        pwr 	: in std_logic;
		  val	   : out std_logic_vector(7 downto 0);
		  enable_val	: out std_logic;
        pwait 	: out std_logic
	);
end component;

component GeneSync is
    Port ( CLK   : in std_logic;
           HSYNC : out std_logic;
           VSYNC : out std_logic;
		     IMG   : out std_logic;
           X     : out std_logic_vector(9 downto 0);
           Y     : out std_logic_vector(8 downto 0));
end component;

component GeneRGB_C  is
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
end component;

--component RAM_dual is
--    Port ( clock          : in  std_logic; 
--	        reset			  : in  std_logic; 
--			  write_enable   : in  std_logic;
--	        read_address   : in  STD_LOGIC_VECTOR  (12 downto 0);
--           input_data 	  : in  STD_LOGIC_VECTOR  (15 downto 0);
--           ram_output     : out  STD_LOGIC_VECTOR (15 downto 0)
--			 );
--end component;

component ROM is
    Port ( AD  : in  std_logic_vector (12 downto 0);
           D   : out std_logic_vector(15 downto 0);
           CLK : in  std_logic
			  );
end component;

signal Xi          : std_logic_vector(9 downto 0);
signal Yi          : std_logic_vector(8 downto 0);
signal ADi         : std_logic_vector(12 downto 0);
signal DATAi       : std_logic_vector(15 downto 0);
signal IMGi        : std_logic;  
signal sval			 : std_logic_vector(7 downto 0);
signal senable_val : std_logic;  
--signal HSi         : std_logic;  
--signal VSi         : std_logic;  

begin

U0 : dpim port map(
			mclk 	=> CLK,
			reset => RESET,
			pdb 	=> pdb,
			astb 	=> astb,
			dstb 	=> dstb,
			pwr 	=> pwr,
			val => sval,
			enable_val => senable_val,
			pwait => pwait
			);

U1 : GeneSync port map(
    CLK    => CLK,
    HSYNC  => HS,
    VSYNC  => VS,
    IMG    => IMGi,
	 X      => Xi,
    Y      => Yi);
	 
U2 : GeneRGB_C  port map(
    CLK   => CLK,
	 SW    => SW,
	 X     => Xi,
    Y     => Yi,
    IMG   => IMGi,
	 DATA  => DATAi,
    R     => R,
    G     => G,
    B     => B,
	 AD    => ADi);
	 
--	 U4 : RAM_dual port map(
--		clock 			=> CLK,        
--	   reset 			=>	RESET,		   
--	   write_enable 	=> senable_val,
--	   read_address   => ADi,
--      input_data 	   => sval,
--      ram_output     => DATAi
--		);

U3 : ROM port map(
    CLK   => CLK,
    AD    => ADi,
    D     => DATAi);
	 
--process (CLK) --retard d'une periode d'horloge pour compenser le cycle induit par la mémoire ROM synchrone
--   begin
--      if (clk'event and clk='1') then	
--         HS<=HSi;
--         VS<=VSi;
--      end if;
--   end process;

end Behavioral;

