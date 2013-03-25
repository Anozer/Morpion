--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:47:56 02/21/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Processeur Elementaire/Processeur8bits/FF1bit_TestBench.vhd
-- Project Name:  Processeur8bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FF1bit
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
 
ENTITY FF1bit_TestBench IS
END FF1bit_TestBench;
 
ARCHITECTURE behavior OF FF1bit_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FF1bit
    PORT(
         H : IN  std_logic;
         RST : IN  std_logic;
         CE : IN  std_logic;
         Init : IN  std_logic;
         Load : IN  std_logic;
         Data_In : IN  std_logic;
         Data_Out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal H : std_logic := '0';
   signal RST : std_logic := '0';
   signal CE : std_logic := '0';
   signal Init : std_logic := '0';
   signal Load : std_logic := '0';
   signal Data_In : std_logic := '0';

 	--Outputs
   signal Data_Out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant H_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FF1bit PORT MAP (
          H => H,
          RST => RST,
          CE => CE,
          Init => Init,
          Load => Load,
          Data_In => Data_In,
          Data_Out => Data_Out
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

      wait for 93 ns;	
      
      RST <= '1';
		wait for 10 ns;
		
		RST <= '0';
		Data_In <= '1';
		CE <= '1';
		wait for 10 ns;
		
		Load <= '1';
		wait for 10 ns;
		
		Load <= '0';
		Init <= '1';
		wait for 10 ns;
		
		Init <= '0';
		wait for 10 ns;
		
		Load <= '1';
		wait for 10 ns;
		
		Data_In <= '0';
		Load <= '0';
		wait for 10 ns;
		
		Load <= '1';
		wait for 10 ns;
		
		Load <= '0';
		
      wait;
   end process;

END;
