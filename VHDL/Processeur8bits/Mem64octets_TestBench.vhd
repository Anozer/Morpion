--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:08:09 02/26/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Processeur Elementaire/Processeur8bits/Mem64octets_TestBench.vhd
-- Project Name:  Processeur8bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM_SP_64_8
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
 
ENTITY Mem64octets_TestBench IS
END Mem64octets_TestBench;
 
ARCHITECTURE behavior OF Mem64octets_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM_SP_64_8
    PORT(
         ADD : IN  std_logic_vector(5 downto 0);
         DATA_IN : IN  std_logic_vector(7 downto 0);
         R_W : IN  std_logic;
         ENABLE : IN  std_logic;
         clk : IN  std_logic;
         Ce : IN  std_logic;
         DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADD : std_logic_vector(5 downto 0) := (others => '0');
   signal DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal R_W : std_logic := '0';
   signal ENABLE : std_logic := '0';
   signal clk : std_logic := '0';
   signal Ce : std_logic := '0';

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM_SP_64_8 PORT MAP (
          ADD => ADD,
          DATA_IN => DATA_IN,
          R_W => R_W,
          ENABLE => ENABLE,
          clk => clk,
          Ce => Ce,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 13 ns;	
		
		-- Test de lecture
		CE <= '1';
		Enable <= '1';
		R_W <= '0';
		ADD <= "000111"; -- lecture de 0x07
		wait for 20 ns;
		
		
		-- test d'écriture
		ADD <= "001000";	-- écriture à 0x08
		Data_In <= X"FF";	-- écriture de 0xFF
		R_W <= '1';			-- activation écriture
		wait for 10 ns;
		R_W <= '0';			-- lecture de la valeur écrite

      wait;
   end process;

END;
