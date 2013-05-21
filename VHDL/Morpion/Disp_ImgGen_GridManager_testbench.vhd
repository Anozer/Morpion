--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:44:58 04/25/2013
-- Design Name:   
-- Module Name:   C:/Users/Utilisateur/Documents/GitHub/Morpion/VHDL/Morpion/Disp_ImgGen_GridManager_testbench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Disp_ImgGen_GridManager
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
 
ENTITY Disp_ImgGen_GridManager_testbench IS
END Disp_ImgGen_GridManager_testbench;
 
ARCHITECTURE behavior OF Disp_ImgGen_GridManager_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Disp_ImgGen_GridManager
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         CE : IN  std_logic;
         Ok_Load : IN  std_logic;
         Player : IN  std_logic;
         OK : IN  std_logic_vector(7 downto 0);
         Grid_State : OUT  std_logic_vector(8 downto 0);
         Grid_Player : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '1';
   signal CE : std_logic := '1';
   signal Ok_Load : std_logic := '0';
   signal Player : std_logic := '0';
   signal OK : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Grid_State : std_logic_vector(8 downto 0);
   signal Grid_Player : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Disp_ImgGen_GridManager PORT MAP (
          Clk => Clk,
          Rst => Rst,
          CE => CE,
          Ok_Load => Ok_Load,
          Player => Player,
          OK => OK,
          Grid_State => Grid_State,
          Grid_Player => Grid_Player
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
      wait for 10 ns;	
			Rst <= '0';
			Ok_load <='1';
		wait for 10 ns;	
			OK <="00000001";
			Player <= '1';
		wait for 10 ns;	
			OK <= "00001000";
			Player <= '0';
		wait for 10 ns;	
			OK <= "00001000";
			Player <= '1';
		wait for 10 ns;	
			OK <= "00001000";
			Player <= '1';
		wait for 10 ns;	
		OK <= "00000100";
		Player <= '1';
      wait;
   end process;

END;
