----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:53:15 04/15/2013 
-- Design Name: 
-- Module Name:    Morpion - Behavioral 
-- Project Name: 
-- Target DeviCEs: 
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
	port (Clk			: IN  STD_LOGIC;			BT				: IN  STD_LOGIC_VECTOR(4 downto 0);
			VGA_RED		: OUT STD_LOGIC_VECTOR(2 downto 0);
			VGA_GREEN	: OUT STD_LOGIC_VECTOR(2 downto 0);
			VGA_BLUE		: OUT STD_LOGIC_VECTOR(1 downto 0);
			VGA_HS		: OUT STD_LOGIC;
			VGA_VS		: OUT STD_LOGIC);
end Morpion;

architecture Behavioral of Morpion is

	component CPU_8bits
		Port (Reset 			: in  STD_LOGIC;
				Clk		 		: in  STD_LOGIC;
				CE					: in	STD_LOGIC;
				data_in			: in  STD_LOGIC_VECTOR(7 downto 0);
				data_out			: out STD_LOGIC_VECTOR(7 downto 0);
				addr				: out STD_LOGIC_VECTOR(5 downto 0);
				Enable			: out STD_LOGIC;
				RW					: out STD_LOGIC);
	end component;

	component BP
		Port (Clk				: in  STD_LOGIC;
				CE					: in  STD_LOGIC;
				Reset				: in  STD_LOGIC;
				BP_NEXT 			: IN  STD_LOGIC;
				BP_PREV 			: IN  STD_LOGIC;
				BP_OK	 			: IN  STD_LOGIC;
				Enable			: IN  STD_LOGIC;
				RW					: IN	STD_LOGIC;
				DataBus_toCPU	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;

	component busArbiter
		Port (Enable		: in	STD_LOGIC;
				AddrBus		: in	STD_LOGIC_VECTOR(5 downto 0);
				Enable_RAM	: out	STD_LOGIC;
				Enable_BP	: out	STD_LOGIC;
				Enable_DISP	: out	STD_LOGIC);
	end component;

	component RAM_56
		Port (AddrBus				: in  STD_LOGIC_VECTOR (5 downto 0);
				DataBus_fromCPU	: in  STD_LOGIC_VECTOR (7 downto 0);
				RW						: in  STD_LOGIC;
				ENABLE				: in  STD_LOGIC;
				clk					: in  STD_LOGIC;
				Ce						: in  STD_LOGIC;
				DataBus_toCPU		: out STD_LOGIC_VECTOR (7 downto 0));
	end component;


	signal Reset				: std_logic;
	signal CE					: std_logic;
	signal DataBus_cpu2p		: std_logic_vector(7 downto 0);
	signal DataBus_p2cpu		: std_logic_vector(7 downto 0);
	signal DataBus_bp2cpu	: std_logic_vector(7 downto 0); 
	signal DataBus_ram2cpu	: std_logic_vector(7 downto 0);
	signal AddrBus			 	: std_logic_vector(5 downto 0);
	signal RW					: std_logic;
	signal Enable				: std_logic;
	signal Enable_ram 		: std_logic;
	signal Enable_bp			: std_logic;
	signal Enable_disp		: std_logic;
	
begin
	Reset <= BT(2);
	CE <= '1';
	
	-- MUX du bus de données (periph vers cpu)
	DataBus_p2cpu <=	DataBus_ram2cpu	WHEN Enable_ram = '1' ELSE
							DataBus_bp2cpu		WHEN Enable_bp = '1';
	
	The_CPU : CPU_8bits port map (
		Reset,
		Clk,
		CE,
		DataBus_p2cpu,
		DataBus_cpu2p,
		AddrBus,
		Enable,
		RW
	);
	
	The_BP : BP port map (
		Clk,
		CE,
		Reset,
		BT(1),
		BT(3),
		BT(4),
		Enable_bp,
		RW,
		DataBus_bp2cpu
	);
	
	The_busArbiter : busArbiter port map (
		Enable,
		AddrBus,
		Enable_ram,
		Enable_bp,
		Enable_disp
	);
	
	The_RAM : RAM_56 port map (
		AddrBus,
		DataBus_cpu2p,
		RW,
		Enable_ram,
		Clk,
		CE,
		DataBus_ram2cpu
	);

end Behavioral;

