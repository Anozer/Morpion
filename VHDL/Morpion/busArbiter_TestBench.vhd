--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:48:35 04/15/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Morpion/VHDL/Morpion/busArbiter_TestBench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: busArbiter
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
 
ENTITY busArbiter_TestBench IS
END busArbiter_TestBench;
 
ARCHITECTURE behavior OF busArbiter_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT busArbiter
    Port (Enable		: in	STD_LOGIC;
			AddrBus		: in	STD_LOGIC_VECTOR(5 downto 0);
			Enable_RAM	: out	STD_LOGIC;
			Enable_BP	: out	STD_LOGIC;
			Enable_DISP	: out	STD_LOGIC);
    END COMPONENT;
    

   --Inputs
   signal ENABLE : std_logic := '0';
   signal AddrBus : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ENABLE_RAM : std_logic;
   signal ENABLE_BP : std_logic;
   signal ENABLE_DISP : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: busArbiter PORT MAP (
          ENABLE => ENABLE,
          AddrBus => AddrBus,
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
      AddrBus <= "001111"; -- memoire
		
		wait for 20 ns;
		AddrBus <= "101000"; -- memoire
		
		wait for 20 ns;
		AddrBus <= "110100"; -- memoire
		
		wait for 20 ns;
		AddrBus <= "111000"; -- BP
		
		wait for 20 ns;
		AddrBus <= "111001"; -- AFF J
		
		wait for 20 ns;
		AddrBus <= "111100"; -- rien


      wait;
   end process;

END;
