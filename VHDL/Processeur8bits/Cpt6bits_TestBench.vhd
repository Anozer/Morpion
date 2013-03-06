--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:04:57 02/21/2013
-- Design Name:   
-- Module Name:   H:/Cours/S8/VHDL/Proc_tom/Processeur8bits/Cpt6bits_TestBench.vhd
-- Project Name:  Processeur8bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Cpt6bits
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
 
ENTITY Cpt6bits_TestBench IS
END Cpt6bits_TestBench;
 
ARCHITECTURE behavior OF Cpt6bits_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Cpt6bits
    PORT(
         Data_in : IN  std_logic_vector(5 downto 0);
         Enable : IN  std_logic;
         Init : IN  std_logic;
         Load : IN  std_logic;
         Rst : IN  std_logic;
         CE : IN  std_logic;
         H : IN  std_logic;
         Data_out : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Data_in : std_logic_vector(5 downto 0) := "111100";
   signal Enable : std_logic := '0';
   signal Init : std_logic := '0';
   signal Load : std_logic := '0';
   signal Rst : std_logic := '0';
   signal CE : std_logic := '0';
   signal H : std_logic := '0';

 	--Outputs
   signal Data_out : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant H_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Cpt6bits PORT MAP (
          Data_in => Data_in,
          Enable => Enable,
          Init => Init,
          Load => Load,
          Rst => Rst,
          CE => CE,
          H => H,
          Data_out => Data_out
        );

   -- Clock process definitions
   H_process :process
   begin
		H <= '0';
		wait for H_period/2;
		H <= '1';
		wait for H_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
				
		Rst <= '1';
		
		wait for 10 ns;
		
		Rst <= '0';
		
      wait for 10 ns;	      -- insert stimulus here

		CE <= '1';
		
		wait for 10 ns;
		
		Enable <= '1';
		
		wait for 10 ns;
		
		Init <= '1';
		
		wait for 10 ns;
		
		Init <= '0';
		
		wait for 30 ns;
		
		Load <= '1';
		
		wait for 10 ns;
		
		Load <= '0';
		

		
      wait;
   end process;

END;
