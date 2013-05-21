--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:46:35 03/25/2013
-- Design Name:   
-- Module Name:   C:/Users/Utilisateur/Documents/GitHub/Morpion/VHDL/Morpion/BP_FSM_TestBench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BP_FSM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY BP_FSM_TestBench IS
END BP_FSM_TestBench;
 
ARCHITECTURE behavior OF BP_FSM_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BP_FSM
    PORT ( Clk 			: IN  STD_LOGIC;
           Rst 			: IN  STD_LOGIC;
           CE 				: IN  STD_LOGIC;
           BP_NEXT 		: IN  STD_LOGIC;
			  BP_PREV 		: IN  STD_LOGIC;
			  BP_OK	 		: IN  STD_LOGIC;
			  BP_ENABLE		: IN  STD_LOGIC;
			  RegClear		: OUT  STD_LOGIC;
			  RegLoad 		: OUT  STD_LOGIC;
           Data_toReg	: OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
	signal BP_ENABLE	: STD_LOGIC :='0';
   signal CE : std_logic := '1';
   signal BP_NEXT : std_logic := '0';
   signal BP_PREV : std_logic := '0';
   signal BP_OK : std_logic := '0';

 	--Outputs
	signal RegClear : std_logic;
	signal RegLoad : std_logic;
   signal Data_toReg : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BP_FSM PORT MAP (
          Clk => Clk,
          Rst => Rst,
          CE => CE,
          BP_NEXT => BP_NEXT,
          BP_PREV => BP_PREV,
			 BP_ENABLE => BP_ENABLE,
          BP_OK => BP_OK,
          RegClear => RegClear,
          RegLoad => RegLoad,
			 Data_toReg => Data_toReg
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
			BP_NEXT <= '1';
			
		wait for 30 ns;
			BP_NEXT <= '0';
		
		wait for 30 ns;
			BP_ENABLE <= '1';
			
		wait for 20 ns;
			BP_PREV <= '1';
			
		wait for 30 ns;
			BP_PREV <= '0';
			BP_ENABLE <= '0';			
      -- insert stimulus here 

      wait;
   end process;

END;
