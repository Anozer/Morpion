--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:32:26 02/21/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Processeur Elementaire/Processeur8bits/UAL_TestBench.vhd
-- Project Name:  Processeur8bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UAL
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
 
ENTITY UAL_TestBench IS
END UAL_TestBench;
 
ARCHITECTURE behavior OF UAL_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UAL
    PORT(
         Sel_UAL : IN  std_logic;
         Data_In_ACCU : IN  std_logic_vector(7 downto 0);
         Data_In_MEM : IN  std_logic_vector(7 downto 0);
         Data_Out : OUT  std_logic_vector(7 downto 0);
         Carry_Out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Sel_UAL : std_logic := '0';
   signal Data_In_ACCU : std_logic_vector(7 downto 0) := (others => '0');
   signal Data_In_MEM : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Data_Out : std_logic_vector(7 downto 0);
   signal Carry_Out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UAL PORT MAP (
          Sel_UAL => Sel_UAL,
          Data_In_ACCU => Data_In_ACCU,
          Data_In_MEM => Data_In_MEM,
          Data_Out => Data_Out,
          Carry_Out => Carry_Out
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 20 ns;	
			
		-- Test du NOR
		-- attendu : "11000000"
		Data_In_ACCU <= "00110011";
		Data_In_MEM  <= "00001111";
		Sel_UAL <= '0';
		
		wait for 20 ns;
		
		-- Test de l'addition 40 - 24
		-- attendu : 16, carry 1
		Data_In_ACCU <= "00101000"; -- 40
		Data_In_MEM  <= "11101000"; -- -24
		Sel_UAL <= '1';
		
		
		wait for 20 ns;

		-- Test de l'addition 16 - 24
		-- attendu : -8,  carry = 0
		Data_In_ACCU <= "00010000"; -- 16
		Data_In_MEM  <= "11101000"; -- -24
		Sel_UAL <= '1';
		
		
      wait;
   end process;

END;
