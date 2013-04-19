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
    Port (Clk				: in  STD_LOGIC;
			CE					: in  STD_LOGIC;
			Reset				: in  STD_LOGIC;
			BP_NEXT 			: IN  STD_LOGIC;
			BP_PREV 			: IN  STD_LOGIC;
			BP_OK	 			: IN  STD_LOGIC;
			Enable			: IN  STD_LOGIC;
			RW					: IN	STD_LOGIC;
			DataBus_toCPU	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal CE : std_logic := '1';
   signal Reset : std_logic := '1';
   signal BP_NEXT : std_logic := '0';
   signal BP_PREV : std_logic := '0';
   signal BP_OK : std_logic := '0';
   signal Enable : std_logic := '0';
	signal RW : std_logic := '0';

 	--Outputs
   signal DataBus_toCPU : std_logic_vector(7 downto 0);

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
          Enable => Enable,
          DataBus_toCPU => DataBus_toCPU,
			 RW => RW
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
			Enable <= '1';
			
		wait for 10 ns;
			BP_NEXT <= '1';
			
		wait for 50 ns;
			BP_NEXT <= '0';
			
		wait for 10 ns;
			Enable <= '0';
			
      wait;
   end process;

END;
