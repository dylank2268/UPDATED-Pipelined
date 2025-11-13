.data
.text
.globl main

main:
    # Initialize test values in registers
    addi t0, zero, 42         # t0 = 42 (also tests addi)
    addi t1, zero, 17         # t1 = 17
    addi t2, zero, -5         # t2 = -5 
    addi s0, zero, 100        # s0 = 100
    addi zero, zero, 0
    # ADD
    add s1, t0, t1            # s1 = 42 + 17 = 59
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0
    add a1, s1, t2    
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0       # a1 = 59 + -5 = 54
    add a2, s0, a1     
    addi zero, zero, 0
    addi zero, zero, 0  
    addi zero, zero, 0     # a2 = 100 + 54 = 154
    
    # SUB
    sub a3, a2, t0      
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0     # a3 = 154 - 42 = 112
    sub a4, a3, t1    
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0       # a4 = 112 - 17 = 95
    sub a5, a4, s0            # a5 = 95 - 100 = -5
    
    # ANDI
    andi a6, t0, 0x0F         # a6 = 42 & 15 = 10 
    andi a7, s0, 0xFF    
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0     # a7 = 100 & 255 = 100
    andi s2, a6, 0x08         # s2 = 10 & 8 = 8
    
    # XOR
    xor s3, t0, t1    
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0        # s3 = 42 ^ 17 = 59 
    xor s4, s3, a6    
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0       # s4 = 59 ^ 10 = 49 
    xor s5, s4, s4            # s5 = 49 ^ 49 = 0 
    
    # XORI
    xori s6, t0, 0x1F   
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0     # s6 = 42 ^ 31 = 53
    xori s7, s6, -1           # s7 = 53 ^ -1 = ~53 
    xori t3, s5, 0x55         # t3 = 0 ^ 85 = 85
    
    # OR
    or t4, t0, t1    
    addi zero, zero, 0
    addi zero, zero, 0  
    addi zero, zero, 0       # t4 = 42 | 17 = 59 
    or t5, t4, a6             # t5 = 59 | 10 = 59
    or t6, s5, t3             # t6 = 0 | 85 = 85
    
    # ORI
    ori s11, s5, 0x0F   
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0     # s11 = 0 | 15 = 15
    ori t3, s11, 0xF0         # t3 = 15 | 240 = 255
    ori t4, t0, 0x01          # t4 = 42 | 1 = 43
    
    # SLT
    slt t5, t2, t0            # t5 = (-5 < 42) = 1
    slt t6, t0, t2            # t6 = (42 < -5) = 0
    addi t0, zero, 10    
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0     # t0 = 10 
    slt t1, t0, s0            # t1 = (10 < 100) = 1
    
    # SLTIU
    sltiu t2, t0, 100         # t2 = (10 < 100) = 1
    sltiu s0, t0, 5           # s0 = (10 < 5) = 0
    addi s1, zero, -1   
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0     # s1 = -1 
    sltiu a1, s1, 10          # a1 = (0xFFFFFFFF < 10) = 0
    
    # SLL
    addi a2, zero, 8          # a2 = 8
    addi a3, zero, 2    
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0      # a3 = 2 
    sll a4, a2, a3      
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0      # a4 = 8 << 2 = 32
    sll a5, a4, a3            # a5 = 32 << 2 = 128
    
    # SLLI
    slli a6, a2, 3      
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0     # a6 = 8 << 3 = 64
    slli a7, a6, 2            # a7 = 64 << 2 = 256
    slli s2, t0, 4            # s2 = 10 << 4 = 160
    
    # SRL
    addi s3, zero, 128        # s3 = 128
    addi s4, zero, 3    
    addi zero, zero, 0
    addi zero, zero, 0  
    addi zero, zero, 0    # s4 = 3 
    srl s5, s3, s4      
    addi zero, zero, 0
    addi zero, zero, 0   
    addi zero, zero, 0   # s5 = 128 >> 3 = 16
    srl s6, s5, a3            # s6 = 16 >> 2 = 4
    
    # SRLI
    srli s7, s3, 4            # s7 = 128 >> 4 = 8
    srli t3, a7, 5            # t3 = 256 >> 5 = 8
    srli t4, a5, 3            # t4 = 128 >> 3 = 16
    
    # SRA
    addi t5, zero, -64        # t5 = -64
    addi t6, zero, 2     
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0     # t6 = 2 
    sra s11, t5, t6           # s11 = -64 >> 2 = -16 
    nop
    nop
    nop
    sra t3, s11, t6           # t3 = -16 >> 2 = -4
    
    # SRAI
    srai t4, t5, 3       
    addi zero, zero, 0
    addi zero, zero, 0  
    addi zero, zero, 0   # t4 = -64 >> 3 = -8
    srai t5, t4, 2            # t5 = -8 >> 2 = -2
    addi t6, zero, 64    
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0    # t6 = 64 
    srai t0, t6, 2            # t0 = 64 >> 2 = 16 
    
    # many different tests 
    add t1, a4, a6            # t1 = 32 + 64 = 96
    sub t2, a7, s7       
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0    # t2 = 256 - 8 = 248
    xor s0, t1, t2       
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0    # s0 = 96 ^ 248
    or s1, s0, s2        
    addi zero, zero, 0
    addi zero, zero, 0  
    addi zero, zero, 0   # s1 = s0 | 160
    andi a1, s1, 0xFF   
    addi zero, zero, 0
    addi zero, zero, 0  
    addi zero, zero, 0    # a1 = s1 & 255
    slli a2, a1, 1    
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0       # a2 = a1 << 1
    srli a3, a2, 1            # a3 = a2 >> 1 
    nop
    nop
    nop
    # Verify final result with comparison
    slt a4, a3, a1            # a4 = (a3 < a1) = 0
    addi a5, zero, 1      
    addi zero, zero, 0
    addi zero, zero, 0 
    addi zero, zero, 0   # a5 = 1
    sub a6, a5, a4            # a6 = 1 - 0 = 1
    nop
    nop
    nop
    wfi
