library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity %ROM_NAME% is
	port (CLK : in std_logic;
		  EN : in std_logic;
		  ADDR : in std_logic_vector(%ROM_ADDR_SIZE%);
		  DATA : out %ROM_DATA_TYPE%);
end %ROM_NAME%;

architecture Behavioral of %ROM_NAME% is

type zone_memoire is array (%ROM_ADDR_TAB%) of %ROM_DATA_TYPE%;
constant ROM: zone_memoire := (
%DATAS%
	others => '0'
);

begin
	
	-- process ROM
	process (CLK)
	begin
		if (CLK'event and CLK = '1') then
			if (EN = '1') then
				DATA <= ROM(to_integer(unsigned(ADDR)));
			end if;
		end if;
	end process;
	
end Behavioral;

