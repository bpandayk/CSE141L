//r1 = sequence
//r2 = next byte in string
//r3 = current byte to check in string
//r4 = count1
//r5 = current memory location
//r6 = outer_loop counter
//r7 = inner_loop counter
//r14 = 1
//get sequence from memory and set in most significant bits of r1
set 9
ld r1
slg r1
slg r1
slg r1
slg r1
//get first two bytes of string
set 1
mv r14
set 31
add r14
ld r2
add r14
ld r3
mv r5 // r5 contains current memory location of last loaded byte
OUTER_LOOP: //loops 62 times to load all bytes
set 0 //reset inner loop counter to 0
mv r7
INNER_LOOP: // loops 8 times to shift all of r2 into r3
set 0 //set all 0s into r15 register
mv r15
set 0
add r1 //put sequence in accumulator register
xor r3 //xor r3 with sequence. If sequence matches, r0 will contain 0000 in 4 MSBs
bmh INC
br END_INC
INC:
set 0 //increment count1
add r4
add r14
mv r4
//check if count1 is 255
set 0
add r4
mv r15
set 0
not r0
bl END_OUTER
END_INC:
//shift in MSB from r2 to LSB of r3
slg r2
slo r3
set 0 //increment inner loop counter
add r7
add r14
mv r7
mv r15
set 8 //branch to end of loop if counter is 8, loop again otherwise
bl INNER_LOOP
END_INNER:
set 31 //increment outer_loop counter and check if less than 62
add r0
mv r15
set 0
add r6
add r14
bl END_OUTER
set 0 //load next byte into r2
add r5
add r14
mv r5
ld r2
br OUTER_LOOP
END_OUTER:
set 10
st r4
halt
