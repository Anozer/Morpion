----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:53:15 04/15/2013 
-- Design Name: 
-- Module Name:    Morpion - Behavioral 
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

entity Morpion is
	port (CLK			: IN  STD_LOGIC;			BT				: IN  STD_LOGIC_VECTOR(4 downto 0);
			VGA_RED		: OUT STD_LOGIC_VECTOR(2 downto 0);
			VGA_GREEN	: OUT STD_LOGIC_VECTOR(2 downto 0);
			VGA_BLUE		: OUT STD_LOGIC_VECTOR(1 downto 0);
			VGA_HS		: OUT STD_LOGIC;
			VGA_VS		: OUT STD_LOGIC);
end Morpion;

architecture Behavioral of Morpion is

	component CPU_8bits
		Port (reset 			: in  STD_LOGIC;
				clk		 		: in  STD_LOGIC;
				ce					: in	STD_LOGIC;
				data_in			: in  STD_LOGIC_VECTOR(7 downto 0);
				data_out			: out STD_LOGIC_VECTOR(7 downto 0);
				addr				: out STD_LOGIC_VECTOR(5 downto 0);
				enable			: out STD_LOGIC;
				rw					: out STD_LOGIC);
	end component;

	component BP
		Port (Clk				: in   STD_LOGIC;
				CE					: in   STD_LOGIC;
				Reset				: in   STD_LOGIC;
				BP_NEXT 			: IN  STD_LOGIC;
				BP_PREV 			: IN  STD_LOGIC;
				BP_OK	 			: IN  STD_LOGIC;
				BP_ENABLE		: IN  STD_LOGIC;
				RW					: IN	STD_LOGIC;
				BP_out			: OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;

	component AdrDecode
		Port (ENABLE		: in	STD_LOGIC;
				ADDR			: in	STD_LOGIC_VECTOR(5 downto 0);
				ENABLE_RAM	: out	STD_LOGIC;
				ENABLE_BP	: out	STD_LOGIC;
				ENABLE_DISP	: out	STD_LOGIC);
	end component;

	component RAM_56
		Port (ADD		: in  STD_LOGIC_VECTOR (5 downto 0);
				DATA_IN	: in  STD_LOGIC_VECTOR (7 downto 0);
				R_W		: in  STD_LOGIC;
				ENABLE	: in  STD_LOGIC;
				clk		: in  STD_LOGIC;
				Ce			: in  STD_LOGIC;
				DATA_OUT	: out STD_LOGIC_VECTOR (7 downto 0));
	end component;


	signal reset			: std_logic;
	signal ce				: std_logic;
	signal dataBus_p2cpu	: std_logic_vector(7 downto 0);
	signal dataBus_cpu2p	: std_logic_vector(7 downto 0);
	signal addr_bus		: std_logic_vector(5 downto 0);
	signal rw				: std_logic;
	signal enable			: std_logic;
	signal enable_ram 	: std_logic;
	signal enable_bp		: std_logic;
	signal enable_disp	: std_logic;
	
begin

	reset <= BT(2);
	ce <= '1';

	The_CPU : CPU_8bits port map (
		reset,
		clk,
		ce,
		dataBus_p2cpu,
		dataBus_cpu2p,
		addr_bus,
		enable,
		rw
	);
	
	The_BP : BP port map (
		clk,
		ce,
		reset,
		bt(1),
		bt(3),
		bt(4),
		enable_bp,
		rw,
		dataBus_p2cpu
	);
	
	The_AdrDecode : AdrDecode port map (
		enable,
		addr_bus,
		enable_ram,
		enable_bp,
		enable_disp
	);
	
	The_RAM : RAM_56 port map (
		addr_bus,
		dataBus_cpu2p,
		rw,
		enable_ram,
		clk,
		ce,
		dataBus_p2cpu
	);

end Behavioral;

