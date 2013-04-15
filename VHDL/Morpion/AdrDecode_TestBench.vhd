--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:48:35 04/15/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Morpion/VHDL/Morpion/AdrDecode_TestBench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AdrDecode
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
 
ENTITY AdrDecode_TestBench IS
END AdrDecode_TestBench;
 
ARCHITECTURE behavior OF AdrDecode_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AdrDecode
    PORT(
         ENABLE : IN  std_logic;
         ADDR : IN  std_logic_vector(5 downto 0);
         ENABLE_RAM : OUT  std_logic;
         ENABLE_BP : OUT  std_logic;
         ENABLE_DISP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ENABLE : std_logic := '0';
   signal ADDR : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ENABLE_RAM : std_logic;
   signal ENABLE_BP : std_logic;
   signal ENABLE_DISP : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AdrDecode PORT MAP (
          ENABLE => ENABLE,
          ADDR => ADDR,
          ENABLE_RAM => ENABLE_RAM,
          ENABLE_BP => ENABLE_BP,
          ENABLE_DISP => ENABLE_DISP
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
      -- hold reset state for 100 ns.
      wait for 20 ns;
		ENABLE <= '1';
      ADDR <= "001111"; -- memoire
		
		wait for 20 ns;
		ADDR <= "101000"; -- memoire
		
		wait for 20 ns;
		ADDR <= "110100"; -- memoire
		
		wait for 20 ns;
		ADDR <= "111000"; -- BP
		
		wait for 20 ns;
		ADDR <= "111001"; -- AFF J
		
		wait for 20 ns;
		ADDR <= "111100"; -- rien


      wait;
   end process;

END;
