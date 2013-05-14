--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:11 05/14/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Morpion/VHDL/Morpion/Disp_ImgGen_ShapeGenerator_Cpt_testbench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Disp_ImgGen_ShapeGenerator_Cpt
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
 
ENTITY Disp_ImgGen_ShapeGenerator_Cpt_testbench IS
END Disp_ImgGen_ShapeGenerator_Cpt_testbench;
 
ARCHITECTURE behavior OF Disp_ImgGen_ShapeGenerator_Cpt_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Disp_ImgGen_ShapeGenerator_Cpt
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Ce : IN  std_logic;
         Load : IN  std_logic;
         X_out : OUT  std_logic_vector(6 downto 0);
         Y_out : OUT  std_logic_vector(6 downto 0);
         Counting : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Ce : std_logic := '0';
   signal Load : std_logic := '0';

 	--Outputs
   signal X_out : std_logic_vector(6 downto 0);
   signal Y_out : std_logic_vector(6 downto 0);
   signal Counting : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Disp_ImgGen_ShapeGenerator_Cpt PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Ce => Ce,
          Load => Load,
          X_out => X_out,
          Y_out => Y_out,
          Counting => Counting
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
      -- hold reset state for 100 ns.
      wait for 13 ns;
		Reset <= '1';
		Ce <= '1';
      wait for Clk_period;
		Reset <= '0';
		wait for 50 ns;
		
		load <= '1';
		wait for Clk_period;
		load <= '0';
		
      -- insert stimulus here 

      wait;
   end process;

END;
