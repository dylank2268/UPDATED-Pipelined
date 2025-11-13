--Dylan Kramer
--4t1 mux
library IEEE;
use IEEE.std_logic_1164.all;
use work.RISCV_types.all;

entity mux4t1_N is
  generic (N : integer := 32);
  port(
    i_S  : in  std_logic_vector(1 downto 0);       -- select lines
    i_D0 : in  std_logic_vector(N-1 downto 0);     --00 = ALU result
    i_D1 : in  std_logic_vector(N-1 downto 0);     --01 = Load data
    i_D2 : in  std_logic_vector(N-1 downto 0);     --10 = PC + 4
    i_D3 : in  std_logic_vector(N-1 downto 0);     --11 = unused
    o_O  : out std_logic_vector(N-1 downto 0)
  );
end mux4t1_N;

architecture dataflow of mux4t1_N is
begin
  with i_S select
    o_O <= i_D0 when "00",
           i_D1 when "01",
           i_D2 when "10",
           i_D3 when "11",
           (others => '0') when others;
end dataflow;
