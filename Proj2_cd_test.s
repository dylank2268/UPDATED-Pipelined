# Dylan Kramer
# Tests all control flow instructions with call depth of 5
# SOFTWARE SCHEDULED for 5-stage RISC-V pipeline
# NOPs inserted to handle data hazards

.data
.text
.globl main
main:
    # Initialize stack pointer
    lui sp, 0x10011
    nop               
    nop
    nop
    
    # Allocate stack
    addi sp, sp, -4
    nop                    
    nop
    nop
    sw   ra, 0(sp)
    
    # Initialize test values
    addi a0, x0, 10        # a0 = 10
    addi a1, x0, 5         # a1 = 5

    # Call level 1
    jal  ra, level1        # ra = return address
    nop                   
    nop
    
    # Reallocate stack and exit
    lw   ra, 0(sp)         # Load ra from stack
    nop                  
    nop
    addi sp, sp, 4
    nop
    nop
    nop
    j    end
    nop                    # Control hazard
    nop
    
#Depth 1
level1:
    # Allocate stack
    addi sp, sp, -4
    nop                  
    nop
    nop
    sw   ra, 0(sp)
    
    # BEQ test
    addi t0, x0, 5
    addi t1, x0, 5
    nop                  
    nop
    nop
    bne  t0, t1, skip_eq   # Should NOT branch (5 == 5)
    nop              
    nop
    addi a0, a0, 1         # a0 = 11
    nop                  
skip_eq:
    
    # BNE test
    addi t0, x0, 3
    nop                   
    addi t1, x0, 7
    nop                  
    nop
    nop
    beq  t0, t1, skip_ne   # Should NOT branch (3 != 7)
    nop                  
    nop
    addi a0, a0, 2         # a0 = 13
    nop                   
skip_ne:
    
    # Depth 2 call
    jal  ra, level2
    nop                 
    nop
    
    # Deallocate stack and return
    lw   ra, 0(sp)
    nop              
    nop
    addi sp, sp, 4
    nop               
    nop
    nop
    jalr x0, ra, 0
    nop            
    nop
    
#Depth 2 
level2:
    # Allocate stack
    addi sp, sp, -4
    nop              
    nop
    nop
    sw   ra, 0(sp)
    
    # BLT test
    addi t0, x0, 3
    nop                   
    addi t1, x0, 8
    nop                   
    nop
    nop
    bge  t0, t1, skip_lt   # Should NOT branch (3 < 8)
    nop                   
    nop
    addi a0, a0, 3         # a0 = 16
    nop                    
skip_lt:
    
    # BGE test
    addi t0, x0, 10
    nop                   
    addi t1, x0, 5
    nop                   
    nop
    nop
    blt  t0, t1, skip_ge   # Should NOT branch (10 >= 5)
    nop                   
    nop
    addi a0, a0, 4         # a0 = 20
    nop                   
skip_ge:
    
    # Depth 3 call
    jal  ra, level3
    nop                 
    nop
    
    # Reallocate stack and return
    lw   ra, 0(sp)
    nop                  
    nop
    addi sp, sp, 4
    nop                   
    nop
    nop
    jalr x0, ra, 0
    nop                  
    nop
    
# Depth 3
level3:
    # Allocate stack
    addi sp, sp, -4
    nop                   
    nop
    nop
    sw   ra, 0(sp)
    
    # BLTU test
    addi t0, x0, 5
    nop                    
    addi t1, x0, 10
    nop                  
    nop
    nop
    bgeu t0, t1, skip_ltu  # Should NOT branch (5 < 10 unsigned)
    nop                   
    nop
    addi a0, a0, 5         # a0 = 25
    nop                 
skip_ltu:
    
    # BGEU test
    addi t0, x0, 15
    nop                    
    addi t1, x0, 10
    nop                   
    nop
    nop
    bltu t0, t1, skip_geu  # Should NOT branch (15 >= 10)
    nop                    
    nop
    addi a0, a0, 6         # a0 = 31
    nop                    
skip_geu:
    
    # Depth 4 call
    jal  ra, level4
    nop                 
    nop
    
    # Reallocate stack and return
    lw   ra, 0(sp)
    nop                    
    nop
    addi sp, sp, 4
    nop                    
    nop
    nop
    jalr x0, ra, 0
    nop                   
    nop
    
# Depth 4
level4:
    # Allocate stack
    addi sp, sp, -4
    nop                   
    nop
    nop
    sw   ra, 0(sp)
    
    # Signed compare with negative
    addi t0, x0, -5
    nop                    
    addi t1, x0, 3
    nop                    
    nop
    nop
    bge  t0, t1, skip_neg  # Should NOT branch (-5 < 3)
    nop                    
    nop
    addi a0, a0, 7         # a0 = 38
    nop                   
skip_neg:
    
    # Depth 5 call
    jal  ra, level5
    nop                   
    nop
    
    # Reallocate stack and return
    lw   ra, 0(sp)
    nop                    
    nop
    addi sp, sp, 4
    nop                    
    nop
    nop
    jalr x0, ra, 0
    nop                    
    nop
    
# Depth 5
level5:
    # Allocate stack
    addi sp, sp, -4
    nop                 
    nop
    nop
    sw   ra, 0(sp)
    
    addi t0, x0, 0
    nop                   
    addi t1, x0, 3
    nop                    
    nop
    nop
    
loop:
    addi a0, a0, 1         # Increment a0
    nop                    
    addi t0, t0, 1         # Increment loop counter
    nop                   
    nop
    nop
    blt  t0, t1, loop      # Branch if t0 < 3
    nop                   
    nop
    
    # Re-allocate stack and return
    lw   ra, 0(sp)
    nop                    
    nop
    addi sp, sp, 4
    nop                    
    nop
    nop
    jalr x0, ra, 0
    nop                    
    nop
    
end:
    wfi                    # Wait for interrupt (halt)