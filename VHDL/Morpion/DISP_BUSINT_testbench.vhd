--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:11:46 04/19/2013
-- Design Name:   
-- Module Name:   C:/Users/Utilisateur/Documents/GitHub/Morpion/VHDL/Morpion/DISP_BUSINT_testbench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DISP_BUSINT
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
 
ENTITY DISP_BUSINT_testbench IS
END DISP_BUSINT_testbench;
 
ARCHITECTURE behavior OF DISP_BUSINT_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DISP_BUSINT
    PORT(
         Clk : IN  std_logic;
         CE : IN  std_logic;
         Reset : IN  std_logic;
         Addr_Bus : IN  std_logic_vector(7 downto 0);
         Data_Bus : IN  std_logic_vector(7 downto 0);
         Enable_Img : IN  std_logic;
         RW : IN  std_logic;
         Player_Out : OUT  std_logic_vector(7 downto 0);
         OK_Out : OUT  std_logic_vector(7 downto 0);
         Pos_Out : OUT  std_logic_vector(7 downto 0);
         OK_Load : OUT  std_logic;
         Pos_Load : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal CE : std_logic := '1';
   signal Reset : std_logic := '1';
   signal Addr_Bus : std_logic_vector(7 downto 0) := (others => '0');
   signal Data_Bus : std_logic_vector(7 downto 0) := (others => '0');
   signal Enable_Img : std_logic := '0';
   signal RW : std_logic := '0';

 	--Outputs
   signal Player_Out : std_logic_vector(7 downto 0);
   signal OK_Out : std_logic_vector(7 downto 0);
   signal Pos_Out : std_logic_vector(7 downto 0);
   signal OK_Load : std_logic;
   signal Pos_Load : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DISP_BUSINT PORT MAP (
          Clk => Clk,
          CE => CE,
          Reset => Reset,
          Addr_Bus => Addr_Bus,
          Data_Bus => Data_Bus,
          Enable_Img => Enable_Img,
          RW => RW,
          Player_Out => Player_Out,
          OK_Out => OK_Out,
          Pos_Out => Pos_Out,
          OK_Load => OK_Load,
          Pos_Load => Pos_Load
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
		Reset <= '0';
		Data_Bus <= "10101010";
		wait for 10 ns;
		Addr_Bus <= "00111010";
		wait for 10 ns;
		RW <= '1';
		wait for 10 ns;
		Enable_Img <='1';
		wait for 10 ns;
		Addr_Bus <= "00111011";
		wait for 10 ns;
		Addr_Bus <= "00111001";
      wait;
   end process;

END;
