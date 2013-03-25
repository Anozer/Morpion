--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:43:50 02/21/2013
-- Design Name:   
-- Module Name:   H:/Cours/S8/VHDL/Proc_tom/Processeur8bits/MUX6bits_TestBench.vhd
-- Project Name:  Processeur8bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX6bits
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
 
ENTITY MUX6bits_TestBench IS
END MUX6bits_TestBench;
 
ARCHITECTURE behavior OF MUX6bits_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX6bits
    PORT(
         Data_In_0 : IN  std_logic_vector(5 downto 0);
         Data_In_1 : IN  std_logic_vector(5 downto 0);
         Channel : IN  std_logic;
         Data_Out : OUT std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Data_In_0 : std_logic_vector(5 downto 0) := "001010";
   signal Data_In_1 : std_logic_vector(5 downto 0) := "001111";
   signal Channel : std_logic := '0';
   signal Data_Out : std_logic_vector(5 downto 0) := (others => '0');
   -- No clocks detected in port list. Replace H below with 
   -- appropriate port name 
 
   --constant H_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX6bits PORT MAP (
          Data_In_0 => Data_In_0,
          Data_In_1 => Data_In_1,
          Channel => Channel,
          Data_Out => Data_Out
        );

   -- Clock process definitions
   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		Data_In_0 <= "111111";
		
		wait for 40 ns;	
		Channel <='1';      -- insert stimulus here 

      wait;
   end process;

END;
