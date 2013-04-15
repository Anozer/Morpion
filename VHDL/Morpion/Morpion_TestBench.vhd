--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:20:40 04/15/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Morpion/VHDL/Morpion/Morpion_TestBench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Morpion
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
 
ENTITY Morpion_TestBench IS
END Morpion_TestBench;
 
ARCHITECTURE behavior OF Morpion_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Morpion
    PORT(
         CLK : IN  std_logic;
         BT : IN  std_logic_vector(4 downto 0);
         VGA_RED : OUT  std_logic_vector(2 downto 0);
         VGA_GREEN : OUT  std_logic_vector(2 downto 0);
         VGA_BLUE : OUT  std_logic_vector(1 downto 0);
         VGA_HS : OUT  std_logic;
         VGA_VS : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal BT : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal VGA_RED : std_logic_vector(2 downto 0);
   signal VGA_GREEN : std_logic_vector(2 downto 0);
   signal VGA_BLUE : std_logic_vector(1 downto 0);
   signal VGA_HS : std_logic;
   signal VGA_VS : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Morpion PORT MAP (
          CLK => CLK,
          BT => BT,
          VGA_RED => VGA_RED,
          VGA_GREEN => VGA_GREEN,
          VGA_BLUE => VGA_BLUE,
          VGA_HS => VGA_HS,
          VGA_VS => VGA_VS
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		wait for 4 ns;
		BT <= "00100"; -- reset
		wait for 100 ns;
		
		
		BT <= "00010";
		wait for 200 ns;
		BT <= "00000";
		
      -- insert stimulus here 

      wait;
   end process;

END;
