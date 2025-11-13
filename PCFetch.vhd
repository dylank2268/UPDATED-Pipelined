library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PCFetch is
  generic(
    -- Reset PC value, default 0x0040_0000
    G_RESET_VECTOR : unsigned(31 downto 0) := to_unsigned(16#00400000#, 32)
  );
  port(
    i_clk       : in  std_logic;
    i_rst       : in  std_logic;
    i_halt      : in  std_logic;
    i_pc_src    : in  std_logic_vector(1 downto 0); -- SEQ, BR_TGT, JAL_TGT, JALR_TGT
    i_br_taken  : in  std_logic;
    i_rs1_val   : in  std_logic_vector(31 downto 0); -- rs1 value
    i_immI      : in  std_logic_vector(31 downto 0); -- I-type imm (JALR)
    i_immB      : in  std_logic_vector(31 downto 0); -- B-type imm (branch)
    i_immJ      : in  std_logic_vector(31 downto 0); -- J-type imm (JAL)
    o_pc        : out std_logic_vector(31 downto 0);
    o_pc_plus4  : out std_logic_vector(31 downto 0);
    o_imem_addr : out std_logic_vector(31 downto 0)
  );
end entity PCFetch;

architecture rtl of PCFetch is

  -- Internal PC signals as unsigned for easy arithmetic
  signal s_pc_reg    : unsigned(31 downto 0);
  signal s_pc_next   : unsigned(31 downto 0);
  signal s_pc_plus4  : unsigned(31 downto 0);
  signal s_br_tgt    : unsigned(31 downto 0);
  signal s_jal_tgt   : unsigned(31 downto 0);
  signal s_jalr_tgt  : unsigned(31 downto 0);

  -- Encodings for i_pc_src
  constant PC_SRC_SEQ  : std_logic_vector(1 downto 0) := "00"; -- sequential (PC+4)
  constant PC_SRC_BR   : std_logic_vector(1 downto 0) := "01"; -- branch target
  constant PC_SRC_JAL  : std_logic_vector(1 downto 0) := "10"; -- JAL target
  constant PC_SRC_JALR : std_logic_vector(1 downto 0) := "11"; -- JALR target

begin

  -------------------------------------------------------------------
  -- Compute candidate next-PCs
  -------------------------------------------------------------------
  -- PC + 4
  s_pc_plus4 <= s_pc_reg + to_unsigned(4, 32);

  -- Branch target: PC + B-imm (already sign-extended before this)
  s_br_tgt   <= s_pc_reg + unsigned(i_immB);

  -- JAL target: PC + J-imm
  s_jal_tgt  <= s_pc_reg + unsigned(i_immJ);

  -- JALR target: rs1 + I-imm (you can mask bit 0 later if you want strict alignment)
  s_jalr_tgt <= unsigned(i_rs1_val) + unsigned(i_immI);

  -------------------------------------------------------------------
  -- Next-PC mux
  -------------------------------------------------------------------
  process(i_pc_src, s_pc_plus4, s_br_tgt, s_jal_tgt, s_jalr_tgt, i_br_taken)
  begin
    case i_pc_src is
      when PC_SRC_SEQ =>
        -- Normal fall-through
        s_pc_next <= s_pc_plus4;

      when PC_SRC_BR =>
        -- Only branch if taken; otherwise fall through
        if i_br_taken = '1' then
          s_pc_next <= s_br_tgt;
        else
          s_pc_next <= s_pc_plus4;
        end if;

      when PC_SRC_JAL =>
        s_pc_next <= s_jal_tgt;

      when PC_SRC_JALR =>
        s_pc_next <= s_jalr_tgt;

      when others =>
        s_pc_next <= s_pc_plus4;
    end case;
  end process;

  -------------------------------------------------------------------
  -- PC register with reset vector + halt
  -------------------------------------------------------------------
  process(i_clk, i_rst)
  begin
    if i_rst = '1' then
      -- Start from reset vector (e.g., 0x0040_0000)
      s_pc_reg <= G_RESET_VECTOR;
    elsif rising_edge(i_clk) then
      -- Halt means "hold PC"
      if i_halt = '0' then
        s_pc_reg <= s_pc_next;
      end if;
    end if;
  end process;

  -------------------------------------------------------------------
  -- Outputs
  -------------------------------------------------------------------
  o_pc        <= std_logic_vector(s_pc_reg);
  o_pc_plus4  <= std_logic_vector(s_pc_plus4);
  -- Instruction memory address is just the current PC
  o_imem_addr <= std_logic_vector(s_pc_reg);

end architecture rtl;
