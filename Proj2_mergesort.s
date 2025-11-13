.data
array:      .word 64, 34, 25, 12, 22, 11, 90, 88  # Example array to sort
array_size: .word 8                                # Size of array
temp_array: .space 32                              # Temporary array for merging (8 * 4 bytes)
newline:    .string "\n"

.text
.globl main

main:
    # Initialize stack pointer to 0x7FFFF7F0 (simpler than 0x7FFFFFF0)
    lui  sp, 0x7FFFF              # sp = 0x7FFFF000
    addi x0, x0, 0              
    addi x0, x0, 0                
    addi x0, x0, 0                
    addi sp, sp, 0x7F0            # sp = 0x7FFFF7F0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    # Load array address
    lui  a0, 0x10010              # Assuming data at 0x10010000
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    addi a0, a0, 0                # Add offset (0 for first data item)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    # Load array_size address
    lui  t0, 0x10010
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    addi t0, t0, 32               # Offset for array_size (8 words * 4 bytes = 32)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a1, 0(t0)                # a1 = array size
    addi x0, x0, 0                 (load delay)
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    # Prepare mergesort arguments
    lui  a0, 0x10010              # Reload array address
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    addi a0, a0, 0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    li   a1, 0                    # a1 = left index (0)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lui  t0, 0x10010
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    addi t0, t0, 32
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a2, 0(t0)                # a2 = right index (size)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi a2, a2, -1               # a2 = size - 1
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    jal  ra, mergesort
    addi x0, x0, 0                 (jump delay)
    addi x0, x0, 0               
    
    # Exit program
    jal  ra, program_end
    addi x0, x0, 0                
    addi x0, x0, 0               

# mergesort(array, left, right)
# a0 = array address
# a1 = left index
# a2 = right index
mergesort:
    addi sp, sp, -16
    nop
    nop
    nop
    sw   ra, 12(sp)
    sw   a0, 8(sp)
    sw   a1, 4(sp)
    sw   a2, 0(sp)
    
    # Base case: if left >= right, return
    bge  a1, a2, mergesort_return
    addi x0, x0, 0                 (branch delay)
    addi x0, x0, 0               
    
    # Calculate mid = (left + right) / 2
    add  t0, a1, a2               # t0 = left + right
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    srai t0, t0, 1                # t0 = (left + right) / 2 (mid)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    # Save mid
    addi sp, sp, -4
    nop
    nop
    nop
    sw   t0, 0(sp)
    
    # mergesort(array, left, mid)
    lw   a0, 12(sp)               # Restore array address
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a1, 8(sp)                # Restore left
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a2, 0(sp)                # Load mid as right
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    jal  ra, mergesort
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    # mergesort(array, mid+1, right)
    lw   a0, 12(sp)               # Restore array address
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a1, 0(sp)                # Load mid
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi a1, a1, 1                # a1 = mid + 1
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a2, 4(sp)                # Restore right
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    jal  ra, mergesort
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    # merge(array, left, mid, right)
    lw   a0, 12(sp)               # Restore array address
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a1, 8(sp)                # Restore left
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a2, 0(sp)                # Load mid
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a3, 4(sp)                # Restore right
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    jal  ra, merge
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    # Clean up mid from stack
    addi sp, sp, 4
    nop
    nop
    nop

mergesort_return:
    lw   ra, 12(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a0, 8(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a1, 4(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   a2, 0(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi sp, sp, 16
    nop
    nop
    nop
    ret
    addi x0, x0, 0                
    addi x0, x0, 0               

# merge(array, left, mid, right)
# a0 = array address
# a1 = left index
# a2 = mid index
# a3 = right index
merge:
    addi sp, sp, -32
    nop
    nop
    nop
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    sw   s1, 20(sp)
    sw   s2, 16(sp)
    sw   s3, 12(sp)
    sw   s4, 8(sp)
    sw   s5, 4(sp)
    sw   s6, 0(sp)
    
    mv   s0, a0                   # s0 = array address
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    mv   s1, a1                   # s1 = i = left
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi s2, a2, 1                # s2 = j = mid + 1
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    mv   s3, a1                   # s3 = k = left
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    mv   s4, a2                   # s4 = mid
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    mv   s5, a3                   # s5 = right
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    # Copy array to temp_array
    lui  s6, 0x10010              # s6 = temp array address base
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi s6, s6, 40               # Offset: 8*4 (array) + 4 (size) + 4 (padding) = 40
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    mv   t0, a1                   # t0 = counter (left)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              

copy_loop:
    bgt  t0, a3, copy_done        # if counter > right, done
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    slli t1, t0, 2                # t1 = counter * 4
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t2, s0, t1               # t2 = &array[counter]
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   t3, 0(t2)                # t3 = array[counter]
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t4, s6, t1               # t4 = &temp[counter]
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    sw   t3, 0(t4)                # temp[counter] = array[counter]
    
    addi t0, t0, 1                # counter++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    j    copy_loop
    addi x0, x0, 0                
    addi x0, x0, 0               

copy_done:
merge_loop:
    bgt  s1, s4, merge_right      # if i > mid, copy from right
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    bgt  s2, s5, merge_left       # if j > right, copy from left
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    slli t0, s1, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s6, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   t1, 0(t0)                # t1 = temp[i]
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    slli t0, s2, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s6, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   t2, 0(t0)                # t2 = temp[j]
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    ble  t1, t2, take_left        # if temp[i] <= temp[j], take left
    addi x0, x0, 0                
    addi x0, x0, 0               

take_right:
    slli t0, s3, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s0, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    sw   t2, 0(t0)                # array[k] = temp[j]
    
    addi s2, s2, 1                # j++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi s3, s3, 1                # k++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    j    merge_loop
    addi x0, x0, 0                
    addi x0, x0, 0               

take_left:
    slli t0, s3, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s0, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    sw   t1, 0(t0)                # array[k] = temp[i]
    
    addi s1, s1, 1                # i++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi s3, s3, 1                # k++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    j    merge_loop
    addi x0, x0, 0                
    addi x0, x0, 0               

merge_left:
    bgt  s1, s4, merge_done       # if i > mid, done
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    slli t0, s1, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s6, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   t1, 0(t0)                # t1 = temp[i]
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    slli t0, s3, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s0, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    sw   t1, 0(t0)                # array[k] = temp[i]
    
    addi s1, s1, 1                # i++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi s3, s3, 1                # k++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    j    merge_left
    addi x0, x0, 0                
    addi x0, x0, 0               

merge_right:
    bgt  s2, s5, merge_done       # if j > right, done
    addi x0, x0, 0                
    addi x0, x0, 0               
    
    slli t0, s2, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s6, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   t1, 0(t0)                # t1 = temp[j]
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    slli t0, s3, 2
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    add  t0, s0, t0
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    sw   t1, 0(t0)                # array[k] = temp[j]
    
    addi s2, s2, 1                # j++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi s3, s3, 1                # k++
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    j    merge_right
    addi x0, x0, 0                
    addi x0, x0, 0               

merge_done:
    lw   ra, 28(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   s0, 24(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   s1, 20(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   s2, 16(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   s3, 12(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   s4, 8(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   s5, 4(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    lw   s6, 0(sp)
    addi x0, x0, 0                
    addi x0, x0, 0               
    addi x0, x0, 0              
    
    addi sp, sp, 32
    nop
    nop
    nop
    
    ret
    addi x0, x0, 0                
    addi x0, x0, 0               

program_end:
    wfi