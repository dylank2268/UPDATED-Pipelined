-------------------------------------------------------------------------
-- Author: Braedon Giblin
-- Date: 2022.02.12
-- Files: RISCV_types.vhd
-------------------------------------------------------------------------
-- Description: This file contains a skeleton for some types that 381 students
-- may want to use. This file is guarenteed to compile first, so if any types,
-- constants, functions, etc., etc., are wanted, students should declare them
-- here.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package RISCV_types is
  -- Example Constants. Declare more as needed
  constant DATA_WIDTH : integer := 32;
  constant ADDR_WIDTH : integer := 10;

  -- Example record type. Declare whatever types you need here
  type control_t is record
    reg_wr : std_logic;
    reg_to_mem : std_logic;
  end record control_t;
  -- Immediate kind (for imm_gen)
  type imm_type_t is (IMM_I, IMM_S, IMM_B, IMM_U, IMM_J);

  -- ALU function selector
  type alu_fn_t is (
    ALU_ADD, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR,
    ALU_SLT, ALU_SLTU, ALU_SLL, ALU_SRL, ALU_SRA,
    ALU_PASS_IMM 
  );

  -- Next-PC source
  type pc_src_t is (PC_SEQ, PC_BR_TGT, PC_JAL_TGT, PC_JALR_TGT);

      constant four_bit_zero : std_logic_vector := "0000";
	type bus_32 is array (0 to 31) of std_logic_vector(31 downto 0);


end package RISCV_types;

package body RISCV_types is
  -- Probably won't need anything here... function bodies, etc.
end package body RISCV_types;
