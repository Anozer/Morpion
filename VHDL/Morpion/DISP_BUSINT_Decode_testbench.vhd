--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:39:18 04/15/2013
-- Design Name:   
-- Module Name:   C:/Users/Utilisateur/Documents/GitHub/Morpion/VHDL/Morpion/DISP_BUSINT_Decode_testbench.vhd
-- Project Name:  Morpion
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DISP_BUSINT_Decode
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
 
ENTITY DISP_BUSINT_Decode_testbench IS
END DISP_BUSINT_Decode_testbench;
 
ARCHITECTURE behavior OF DISP_BUSINT_Decode_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DISP_BUSINT_Decode
    PORT(
         Data_In : IN  std_logic_vector(7 downto 0);
         Enable_Disp : IN  std_logic;
         RW : IN  std_logic;
         POS_Load : OUT  std_logic;
         OK_Load : OUT  std_logic;
         PLAYER_Load : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Data_In : std_logic_vector(7 downto 0) := (others => '0');
   signal Enable_Disp : std_logic := '0';
   signal RW : std_logic := '0';

 	--Outputs
   signal POS_Load : std_logic;
   signal OK_Load : std_logic;
   signal PLAYER_Load : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DISP_BUSINT_Decode PORT MAP (
          Data_In => Data_In,
          Enable_Disp => Enable_Disp,
          RW => RW,
          POS_Load => POS_Load,
          OK_Load => OK_Load,
          PLAYER_Load => PLAYER_Load
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
			Data_In <= "00111001";
		wait for 10 ns;	
			Enable_Disp <= '1';
		wait for 10 ns;	
			RW <= '1';
		wait for 10 ns;	
			Data_In <= "00111010";
		wait for 10 ns;	
			Data_In <= "00111011";
		wait for 10 ns;	
			Data_In <= "00111111";

      -- insert stimulus here 

      wait;
   end process;

END;
