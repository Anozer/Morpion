--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:09:32 03/25/2013
-- Design Name:   
-- Module Name:   Z:/Dev/VHDL/Morpion/VHDL/Morpion/CPU_8bits_TestBench.vhd
-- Project Name:  Morpion
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
         clk : IN  std_logic;
         ce : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         addr : OUT  std_logic_vector(5 downto 0);
         enable : OUT  std_logic;
         rw : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT RAM_SP_64_8
	 Port (ADD		: in  STD_LOGIC_VECTOR (5 downto 0);
			DATA_IN	: in  STD_LOGIC_VECTOR (7 downto 0);
			R_W		: in  STD_LOGIC;
			ENABLE	: in  STD_LOGIC;
			clk		: in  STD_LOGIC;
			Ce			: in  STD_LOGIC;
			DATA_OUT	: out STD_LOGIC_VECTOR (7 downto 0));
    END COMPONENT;

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal ce : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);
   signal addr : std_logic_vector(5 downto 0);
   signal enable : std_logic;
   signal rw : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_8bits PORT MAP (
          reset => reset,
          clk => clk,
          ce => ce,
          data_in => data_in,
          data_out => data_out,
          addr => addr,
          enable => enable,
          rw => rw
        );
		  
	ram: RAM_SP_64_8 PORT MAP (
			ADD => addr,
			DATA_IN => data_out,
			R_W => rw,
			ENABLE => enable,
			clk => clk,
			Ce	=> ce,
			DATA_OUT => data_in);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	ce_process :process
	begin
		ce <= '0';
		wait for clk_period;
		ce <= '1';
		wait for clk_period;
	end process;

   -- Stimulus process
   stim_proc: process
   begin		

      reset <= '1';
	   wait for 40 ns;
		reset <= '0';

 

      wait;
   end process;

END;
