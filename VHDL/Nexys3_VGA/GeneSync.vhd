library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity GeneSync is
    Port ( CLK : in std_logic;
           HSYNC : out std_logic;
           VSYNC : out std_logic;
		     IMG : out std_logic;
           X : out std_logic_vector(9 downto 0);
           Y : out std_logic_vector(8 downto 0));
end GeneSync;

architecture Behavioral of GeneSync is
signal 	comptX : std_logic_vector (10 downto 0);
signal 	comptY : std_logic_vector (9 downto 0);
signal 	Yaux : std_logic_vector (9 downto 0);
signal 	pulseX : std_logic;
signal 	pulseY: std_logic;
signal 	IMGX : std_logic;
signal 	IMGY : std_logic;
begin

Y<=Yaux(8 downto 0);
HSYNC<=pulseX;
VSYNC<=pulseY;
IMG<=IMGX AND IMGY;

process (clk)
begin 
	if (CLK'event and CLK='1')then 
		if comptX(10 downto 1)<800 then 
		 	comptX<=comptX+1;
		else 
	 		comptX<="00000000000";
		end if;
		if comptX=0 then 
			if comptY<521 then 
				comptY<=comptY+1;
			else 
				comptY<="0000000000";
			end if;
		end if;
	end if;
end process;


process (comptX)
begin 
	if (comptX(10 downto 1)<96) then 
		X<="0000000000";
		pulseX<='0';
		IMGX<='0';
	else 
		if (comptX(10 downto 1)<(96+48)) then 
			X<="0000000000";
			pulseX<='1';
			IMGX<='0';
		else 
			if (comptX(10 downto 1)<(96+48+640)) then 
				X<=comptX(10 downto 1)-96-48;
				IMGX<='1';
				pulseX<='1';
			else 
				X<="0000000000";
				pulseX<='1';
				IMGX<='0';
			end if;		
		end if;
	end if;
end process;

process (comptY)
begin 
	if (comptY<2) then 
		Yaux<="0000000000";
		pulseY<='0';
		IMGY <= '0';
	else 
		if (comptY<(2+29)) then 
			Yaux<="0000000000";
			pulseY<='1';
			IMGY<='0';
			
		else 
			if (comptY<(2+29+480)) then 
				Yaux<=comptY-2-29;
				pulseY<='1';
				IMGY<='1';
			else 
				Yaux<="0000000000";
				pulseY<='1';
				IMGY<='0';
			end if;		
		end if;
	end if;
end process;

end Behavioral;

