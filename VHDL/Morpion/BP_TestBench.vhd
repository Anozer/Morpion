--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:43:53 03/26/2013
-- Design Name:   
-- Module Name:   C:/Users/Utilisateur/Documents/GitHub/Morpion/VHDL/Morpion/BP_TestBench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BP
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
 
ENTITY BP_TestBench IS
END BP_TestBench;
 
ARCHITECTURE behavior OF BP_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BP
    PORT(
         Clk 			: IN  std_logic;
         CE 			: IN  std_logic;
         Reset 		: IN  std_logic;
         BP_NEXT 		: IN  std_logic;
         BP_PREV 		: IN  std_logic;
         BP_OK 		: IN  std_logic;
         BP_ENABLE 	: IN  std_logic;
         BP_out 		: OUT  std_logic_vector(7 downto 0));
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal CE : std_logic := '1';
   signal Reset : std_logic := '1';
   signal BP_NEXT : std_logic := '0';
   signal BP_PREV : std_logic := '0';
   signal BP_OK : std_logic := '0';
   signal BP_ENABLE : std_logic := '0';

 	--Outputs
   signal BP_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BP PORT MAP (
          Clk => Clk,
          CE => CE,
          Reset => Reset,
          BP_NEXT => BP_NEXT,
          BP_PREV => BP_PREV,
          BP_OK => BP_OK,
          BP_ENABLE => BP_ENABLE,
          BP_out => BP_out
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

      wait for 10 ns;
			Reset <= '0';
			
		wait for 10 ns;
			BP_NEXT <= '1';	

		wait for 10 ns;
			BP_NEXT <= '0';
		
		wait for 10 ns;
			BP_ENABLE <= '1';
			
		wait for 10 ns;
			BP_NEXT <= '1';
			
		wait for 50 ns;
			BP_NEXT <= '0';
			
		wait for 10 ns;
			BP_ENABLE <= '0';
			
      wait;
   end process;

END;
