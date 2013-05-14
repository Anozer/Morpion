library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity %ROM_NAME% is
	port (CLK : in std_logic;
		  EN : in std_logic;
		  ADDR : in std_logic_vector(%ROM_ADDR_SIZE%);
		  DATA : out std_logic_vector(%ROM_DATA_SIZE%));
end %ROM_NAME%;

architecture Behavioral of %ROM_NAME% is

type zone_memoire is array (%ROM_ADDR_TAB%) of std_logic_vector (%ROM_DATA_SIZE%);
constant ROM: zone_memoire := (
%DATAS%
	others => (others => '0')
);

begin
	
	-- process ROM
	process (CLK)
	begin
		if (CLK'event and CLK = '1') then
			if (EN = '1') then
				DATA <= ROM(conv_integer(ADDR));
			end if;
		end if;
	end process;
	
end Behavioral;

