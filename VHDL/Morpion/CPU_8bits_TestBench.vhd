--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:19:03 02/22/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Processeur Elementaire/Processeur8bits/CPU_8bits_TestBench.vhd
-- Project Name:  Processeur8bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_8bits
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
 
ENTITY CPU_8bits_TestBench IS
END CPU_8bits_TestBench;
 
ARCHITECTURE behavior OF CPU_8bits_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_8bits
    PORT(
         reset : IN  std_logic;
         clk100M : IN  std_logic;
         valid_saisie : IN  std_logic;
         AN1 : OUT  std_logic;
         AN2 : OUT  std_logic;
         AN3 : OUT  std_logic;
         AN4 : OUT  std_logic;
         Sevenseg : OUT  std_logic_vector(7 downto 0);
         LED : OUT  std_logic_vector(7 downto 0);
         pdb : INOUT  std_logic_vector(7 downto 0);
         astb : IN  std_logic;
         dstb : IN  std_logic;
         pwr : IN  std_logic;
         pwait : OUT  std_logic;
         ldg : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk100M : std_logic := '0';
   signal valid_saisie : std_logic := '0';
   signal astb : std_logic := '0';
   signal dstb : std_logic := '0';
   signal pwr : std_logic := '0';

	--BiDirs
   signal pdb : std_logic_vector(7 downto 0);

 	--Outputs
   signal AN1 : std_logic;
   signal AN2 : std_logic;
   signal AN3 : std_logic;
   signal AN4 : std_logic;
   signal Sevenseg : std_logic_vector(7 downto 0);
   signal LED : std_logic_vector(7 downto 0);
   signal pwait : std_logic;
   signal ldg : std_logic;

   -- Clock period definitions
   constant clk100M_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_8bits PORT MAP (
          reset => reset,
          clk100M => clk100M,
          valid_saisie => valid_saisie,
          AN1 => AN1,
          AN2 => AN2,
          AN3 => AN3,
          AN4 => AN4,
          Sevenseg => Sevenseg,
          LED => LED,
          pdb => pdb,
          astb => astb,
          dstb => dstb,
          pwr => pwr,
          pwait => pwait,
          ldg => ldg
        );

   -- Clock process definitions
   clk100M_process :process
   begin
		clk100M <= '0';
		wait for clk100M_period/2;
		clk100M <= '1';
		wait for clk100M_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for clk100M_period*10;
		
		reset <= '1';
		wait for 100 ns;
		reset <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
