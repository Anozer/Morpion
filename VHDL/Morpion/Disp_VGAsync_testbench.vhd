--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:50:05 04/24/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Morpion/VHDL/Morpion/Disp_VGAsync_testbench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Disp_VGAsync
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Disp_VGAsync_testbench IS
END Disp_VGAsync_testbench;
 
ARCHITECTURE behavior OF Disp_VGAsync_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Disp_VGAsync
    PORT(
         Clk : IN  std_logic;
         CE : IN  std_logic;
         Reset : IN  std_logic;
			IMG : OUT  std_logic;
         HS : OUT  std_logic;
         VS : OUT  std_logic;
         VRAM_addr : OUT  std_logic_vector(18 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal CE : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
	signal IMG : std_logic;
   signal HS : std_logic;
   signal VS : std_logic;
   signal VRAM_addr : std_logic_vector(18 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
	signal Cpt_ce : std_logic_vector(1 downto 0);
BEGIN

	process (Clk,Reset) begin
		if (Reset = '1') then 
			Cpt_ce <= "00";
		elsif (Clk'event and Clk = '1') then
			if (Cpt_ce = "11") then
				Cpt_ce <= "00";
				CE <= '1';
			else
				Cpt_ce <= Cpt_ce + 1;
				CE <= '0';
			end if;
		end if;
	end process;
 
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Disp_VGAsync PORT MAP (
          Clk => Clk,
          CE => CE,
          Reset => Reset,
			 IMG => IMG,
          HS => HS,
          VS => VS,
          VRAM_addr => VRAM_addr
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
		Reset <= '1';
      wait for 23 ns;	
		Reset <= '0';
		-- causera 25 ns de retard dans le TB
      wait;
   end process;

END;
