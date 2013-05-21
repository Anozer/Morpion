----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Sylvain MARIEL (sylvain.mariel@otmax.fr)
-- Engineer: Thomas MOREAU  (thomas.moreau-33@hotmail.fr)

-- Create Date:    21/05/2013 
-- Design Name: 
-- Module Name:    CPU_8bits - Behavioral 
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

entity CPU_8bits is
    Port(reset 			: in  STD_LOGIC;
			clk		 		: in  STD_LOGIC;
			ce					: in	STD_LOGIC;
			data_in			: in  STD_LOGIC_VECTOR(7 downto 0);
			data_out			: out STD_LOGIC_VECTOR(7 downto 0);
			addr				: out STD_LOGIC_VECTOR(5 downto 0);
			enable			: out STD_LOGIC;
			rw					: out STD_LOGIC);
end CPU_8bits;

architecture Behavioral of CPU_8bits is


component Control_Unit
    Port ( 
		Clk 					: in   STD_LOGIC;
		Ce					   : in   STD_LOGIC;
		Reset 				: in   STD_LOGIC;
		Carry 				: in   STD_LOGIC;
		Data_In 				: in   STD_LOGIC_VECTOR (7 downto 0);
		Adr					: out  STD_LOGIC_VECTOR (5 downto 0);
		Clear_Carry 		: out  STD_LOGIC;
		Enable_Mem 			: out  STD_LOGIC;
		Load_Reg1 			: out  STD_LOGIC;
		Load_Reg_Accu 		: out  STD_LOGIC;
		Load_Reg_Carry 	: out  STD_LOGIC;
		Sel_UAL 				: out  STD_LOGIC;
		W_Mem 				: out  STD_LOGIC);
end component;

component Processing_unit
    Port ( 
		Data_in 		: in  STD_LOGIC_VECTOR (7 downto 0);
		clk 			: in  STD_LOGIC;
		Ce			   : in  STD_LOGIC;
		reset 		: in  STD_LOGIC;
		load_reg1 	: in  STD_LOGIC;
		load_accu 	: in  STD_LOGIC;
		load_carry 	: in  STD_LOGIC;
		init_carry 	: in  STD_LOGIC;
		Sel_UAL		: in  STD_LOGIC;
		Data_out 	: out STD_LOGIC_VECTOR (7 downto 0);
		Carry 		: out STD_LOGIC);
end component;



signal Data_Bus2Unit		: STD_LOGIC_VECTOR (7 downto 0);
signal Data_Unit2Bus		: STD_LOGIC_VECTOR (7 downto 0);
signal Carry 		 		: STD_LOGIC;
signal Clear_Carry		: STD_LOGIC;
signal Load_Reg1			: STD_LOGIC;
signal Load_Reg_Accu 	: STD_LOGIC;
signal Load_Reg_Carry 	: STD_LOGIC;
signal Sel_UAL				: STD_LOGIC;



begin

-- Attention pour la simulation mettre  ce de UT et UC ‡ ce25M sinon ce1s

Data_Bus2Unit <= data_in;
data_out <= Data_Unit2Bus;

UC : Control_Unit port map (
	clk,
	ce,
	reset, 
	Carry, 
	Data_Bus2Unit, 
	Addr, 
	Clear_Carry, 
	Enable,
	Load_Reg1, 
	Load_Reg_Accu, 
	Load_Reg_Carry, 
	Sel_UAL, 
	RW);
													  
UT : Processing_unit port map (
	Data_Bus2Unit, 
	clk,
	ce,
	reset, 
	Load_Reg1, 
	Load_Reg_Accu, 
	Load_Reg_Carry,
	Clear_Carry, 
	Sel_UAL, 
	Data_Unit2Bus,	
	Carry);
	
end Behavioral;

