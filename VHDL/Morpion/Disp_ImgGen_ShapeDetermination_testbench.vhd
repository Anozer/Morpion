--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:23:36 05/16/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Morpion/VHDL/Morpion/Disp_ImgGen_ShapeDetermination_testbench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Disp_ImgGen_ShapeDetermination
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
 
ENTITY Disp_ImgGen_ShapeDetermination_testbench IS
END Disp_ImgGen_ShapeDetermination_testbench;
 
ARCHITECTURE behavior OF Disp_ImgGen_ShapeDetermination_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Disp_ImgGen_ShapeDetermination
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         CE : IN  std_logic;
         Busy : IN  std_logic;
         Pos_Load : IN  std_logic;
         Ok_Load : IN  std_logic;
         Ok : IN  std_logic_vector(7 downto 0);
         Pos : IN  std_logic_vector(7 downto 0);
         OldPos : IN  std_logic_vector(7 downto 0);
         Grid_State : IN  std_logic_vector(8 downto 0);
         Grid_Player : IN  std_logic_vector(8 downto 0);
         Shape_Load : OUT  std_logic;
         Shape_Numb : OUT  std_logic_vector(2 downto 0);
         Area_Numb : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal CE : std_logic := '0';
   signal Busy : std_logic := '0';
   signal Pos_Load : std_logic := '0';
   signal Ok_Load : std_logic := '0';
   signal Ok : std_logic_vector(7 downto 0) := (others => '0');
   signal Pos : std_logic_vector(7 downto 0) := (others => '0');
   signal OldPos : std_logic_vector(7 downto 0) := (others => '0');
   signal Grid_State : std_logic_vector(8 downto 0) := (others => '0');
   signal Grid_Player : std_logic_vector(8 downto 0) := (others => '0');

 	--Outputs
   signal Shape_Load : std_logic;
   signal Shape_Numb : std_logic_vector(2 downto 0);
   signal Area_Numb : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Disp_ImgGen_ShapeDetermination PORT MAP (
          Clk => Clk,
          Rst => Rst,
          CE => CE,
          Busy => Busy,
          Pos_Load => Pos_Load,
          Ok_Load => Ok_Load,
          Ok => Ok,
          Pos => Pos,
          OldPos => OldPos,
          Grid_State => Grid_State,
          Grid_Player => Grid_Player,
          Shape_Load => Shape_Load,
          Shape_Numb => Shape_Numb,
          Area_Numb => Area_Numb
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
		Rst <= '1';
		Ce <= '1';
		wait for Clk_period;
		Rst <= '0';
		wait for 20 ns;
		
		
		Pos <= "00000001";
		Pos_load <= '1';
		wait for Clk_period;
		Pos_load <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
