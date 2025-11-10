library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.NUMERIC_STD.all;

entity tt_um_counter_isaharp is
  port (
    ui_in   : in  std_logic_vector(7 downto 0);
    uo_out  : out std_logic_vector(7 downto 0);
    uio_in  : in  std_logic_vector(7 downto 0);
    uio_out : out std_logic_vector(7 downto 0);
    uio_oe  : out std_logic_vector(7 downto 0);
    ena     : in  std_logic;
    clk     : in  std_logic;
    rst_n   : in  std_logic
  );
end entity;

architecture Behavioral of tt_um_counter_isaharp is

  signal ctr : unsigned(3 downto 0) := (others => '0');
  signal direction : std_logic := '0';

begin

    p0 : process(clk) begin
        if rising_edge(clk) then
            direction <= ui_in(0);
        end if;
    end process p0;


    p1 : process (clk, rst_n) begin

        if rst_n = '0' then
            ctr <= (others => '0');

        elsif rising_edge(clk) then

            if direction = '0' then

                if ctr = 15 then
                    ctr <= ctr;
                else
                    ctr <= ctr + 1;
                end if;
            else
                if ctr = 0 then 
                    ctr <= ctr;
                else
                    ctr <= ctr - 1;
                end if;
            end if;
        end if;
    end process p1;


    with ctr (3 downto 0) select

        uo_out <=   "00111111" when "0000", --0
                    "00000110" when "0001", --1
                    "01011011" when "0010", --2
                    "01001111" when "0011", --3
                    "01100110" when "0100", --4
                    "01101101" when "0101", --5
                    "01011111" when "0110", --6
                    "01110000" when "0111", --7
                    "01111111" when "1000", --8
                    "01111011" when "1001", --9 
                    "01110111" when "1010", --A
                    "01111110" when "1011", --B
                    "00111100" when "1100", --C
                    "01011110" when "1101", --D
                    "01111100" when "1110", --E
                    "01111000" when "1111", --F
                    "00000000" when others; -- 0 or other

    uio_oe <= (others => '0');


end Behavioral;
