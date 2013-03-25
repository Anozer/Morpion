----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:00 02/15/2011 
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
    Port ( reset 			: in  STD_LOGIC;
           clk100M 		: in  STD_LOGIC;
			  valid_saisie : in  STD_LOGIC;
           AN1 			: out  STD_LOGIC;
           AN2 			: out  STD_LOGIC;
           AN3 			: out  STD_LOGIC;
           AN4 			: out  STD_LOGIC;
           Sevenseg 		: out  STD_LOGIC_VECTOR (7 downto 0);
           LED 			: out  STD_LOGIC_VECTOR (7 downto 0);
           pdb		   	: inout std_logic_vector(7 downto 0);
           astb 	   	: in std_logic;
           dstb 	   	: in std_logic;
           pwr 	   	: in std_logic;
           pwait 	   	: out std_logic;
		     ldg		   	: out std_logic);
end CPU_8bits;

architecture Behavioral of CPU_8bits is

component IP_clk
	port (
		CLK_IN1           : in	std_logic;
		CLK_OUT1          : out	std_logic);
end component;

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

component RAM_SP_64_8 
    Port (
		ADD      		: in  STD_LOGIC_VECTOR (5 downto 0);
		DATA_IN  		: in  STD_LOGIC_VECTOR (7 downto 0);
		R_W      		: in  STD_LOGIC;
		ENABLE   		: in  STD_LOGIC;
		clk         	: in  STD_LOGIC;
		Ce			  		: in  STD_LOGIC;
		DATA_OUT 		: out  STD_LOGIC_VECTOR (7 downto 0)
			 );
end component;

component acces_carte 
    port (
		clk 			: in std_logic;
		reset  		: in std_logic;
		AdrLSB 		: in std_logic_vector(3 downto 0);
		AdrMSB 		: in std_logic_vector(1 downto 0);
		DataLSB		: in std_logic_vector(3 downto 0);
		DataMSB		: in std_logic_vector(3 downto 0);
		DataInMem	: in std_logic_vector(7 downto 0);
		ce1s  		: out std_logic;
		ce25M  		: out std_logic;
		AN1 			: out std_logic;
		AN2  			: out std_logic;
		AN3  			: out std_logic;
		AN4  			: out std_logic;
		Sseg 			: out std_logic_vector(7 downto 0);
		LED  			: out std_logic_vector(7 downto 0);
		LEDg 			: out std_logic);
end component;

component interface_PC is
    Port (
		mclk				: in std_logic;
		reset				: in std_logic;
		valid_saisie	: in std_logic;
		pdb				: inout std_logic_vector(7 downto 0);
		astb				: in std_logic;
		dstb				: in std_logic;
		pwr				: in std_logic;
		pwait				: out std_logic;
		rgOp1				: out std_logic_vector(7 downto 0);
		rgOp2				: out std_logic_vector(7 downto 0);
		rgSwt				: in std_logic_vector(7 downto 0);
		Adr				: in std_logic_vector(5 downto 0);
		R_W				: in  STD_LOGIC;
		ldg				: out std_logic
	);
	end component;

signal Data_Mem_Unit		: STD_LOGIC_VECTOR (7 downto 0);
signal Data_Unit_Mem		: STD_LOGIC_VECTOR (7 downto 0);
signal val_PC_in1		   : STD_LOGIC_VECTOR (7 downto 0);
signal val_PC_in2		   : STD_LOGIC_VECTOR (7 downto 0);
signal Adr           	: STD_LOGIC_VECTOR (5 downto 0);
signal Carry 		 		: STD_LOGIC;
signal Clear_Carry		: STD_LOGIC;
signal Enable_Mem			: STD_LOGIC;
signal Load_Reg1			: STD_LOGIC;
signal Load_Reg_Accu 	: STD_LOGIC;
signal Load_Reg_Carry 	: STD_LOGIC;
signal Sel_UAL_UT			: STD_LOGIC;
signal Sel_UAL_UC			: STD_LOGIC;
signal W_Mem  				: STD_LOGIC;
signal clk25M 				: STD_LOGIC;
signal ce1s 				: STD_LOGIC;
signal ce25M			   : STD_LOGIC;
signal LEDg 				: STD_LOGIC;

begin

Sel_UAL_UT <= Sel_UAL_UC;

-- Attention pour la simulation mettre  ce de UT et UC ‡ ce25M sinon ce1s

Clock_manager : IP_clk
  port map
   (
    CLK_IN1            => clk100M,
    CLK_OUT1           => clk25M);

UC : Control_Unit port map (
	clk25M, 
	ce1s,
	--ce25M,
	Reset, 
	Carry, 
	Data_Mem_Unit, 
	Adr, 
	Clear_Carry, 
	Enable_Mem,
	Load_Reg1, 
	Load_Reg_Accu, 
	Load_Reg_Carry, 
	Sel_UAL_UC, 
	W_Mem);
													  
UT : Processing_unit port map (
	Data_Mem_Unit, 
	clk25M,
	ce1s,
	--ce25M,
	Reset, 
	Load_Reg1, 
	Load_Reg_Accu, 
	Load_Reg_Carry,
	Clear_Carry, 
	Sel_UAL_UT, 
	Data_Unit_Mem,	
	Carry);
														  
UM : RAM_SP_64_8 port map (
	Adr, 
	Data_Unit_Mem, 
	W_Mem, 
	Enable_Mem,
	clk25M,
	ce1s,
	--ce25M,
	Data_Mem_Unit);

Peripheriques 	 : acces_carte  port map (
	clk25M,
	Reset, 
	Adr(3 downto 0), 
	Adr(5 downto 4),
	Data_Unit_Mem(3 downto 0), 
	Data_Unit_Mem(7 downto 4),
	Data_Mem_Unit,
	ce1s,  
	ce25M, 
	AN1, 
	AN2, 
	AN3, 
	AN4, 
	Sevenseg, 
	LED, 
	LEDg);		

Peripherique_PC : interface_PC  port map (
	clk25M,
	Reset,
	valid_saisie,
	pdb,
	astb, 
	dstb, 	
	pwr, 	
	pwait,
	val_PC_in1,
	val_PC_in2,
	Data_Unit_Mem,
	Adr,
	W_Mem,
	ldg);												  										  

end Behavioral;

