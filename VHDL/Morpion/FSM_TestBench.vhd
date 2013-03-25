--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:12:11 02/21/2013
-- Design Name:   
-- Module Name:   H:/Cours/S8/VHDL/Proc_tom/toto/FSM_TestBench.vhd
-- Project Name:  toto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FSM
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
 
ENTITY FSM_TestBench IS
END FSM_TestBench;
 
ARCHITECTURE behavior OF FSM_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FSM
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         CE : IN  std_logic;
         Carry : IN  std_logic;
         Code_Op : IN  std_logic_vector(1 downto 0);
         A : OUT  std_logic;
         B : OUT  std_logic;
         C : OUT  std_logic;
         D : OUT  std_logic;
         E : OUT  std_logic;
         F : OUT  std_logic;
         G : OUT  std_logic;
         H : OUT  std_logic;
         I : OUT  std_logic;
         J : OUT  std_logic;
         K : OUT  std_logic;
         L : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '1';
   signal CE : std_logic := '0';
   signal Carry : std_logic := '0';
   signal Code_Op : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal A : std_logic;
   signal B : std_logic;
   signal C : std_logic;
   signal D : std_logic;
   signal E : std_logic;
   signal F : std_logic;
   signal G : std_logic;
   signal H : std_logic;
   signal I : std_logic;
   signal J : std_logic;
   signal K : std_logic;
   signal L : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FSM PORT MAP (
          Clk => Clk,
          Rst => Rst,
          CE => CE,
          Carry => Carry,
          Code_Op => Code_Op,
          A => A,
          B => B,
          C => C,
          D => D,
          E => E,
          F => F,
          G => G,
          H => H,
          I => I,
          J => J,
          K => K,
          L => L
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
			Rst <= '0';
			CE <= '1';
			
      wait for 100 ns;	
		Code_Op <= "10";
		Carry <= '1';

		wait for 100 ns;	
		Code_Op <= "11";
		Carry <= '1';



      wait;
   end process;

END;
