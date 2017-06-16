set 1 //set all initial X_temp, Y_temp, and theta_temp
ld r2 //X MSW
set 2
ld r3 //X LSW
set 3
ld r4 //Y MSW
set 4
ld r5 //Y LSW
xor r0
add r2
mv r8 //copy of X MSW
xor r0
add r3
mv r9 //copy of X LSW
xor r0
add r4
mv r10 //copy of Y MSW
xor r0
add r5
mv r11 //copy of Y LSW
br END_SHIFT_Y //y is in first quadrant so skip to after shift //CORDIC_LOOP:
xor r0
mv r15
add r4
bl LT_0 //otherwise y is greater than or = 0
xor r0 //store y_temp in temp registers
add r4
mv r10
set 0
add r5
mv r11
set 0
mv r14 //shift counter SHIFT_Y:
sra r4 //shift y_temp
sro r5
xor r0 //put i in comparator register
add r1
mv r15
set 1 //increment shift counter and check if it is less than i
add r14
mv r14
bl SHIFT_Y //END_SHIFT_Y:
xor r0 //add x_temp and shifted y_temp
add r3
add r5
mv r9 //store x_new in r8 and r9
set 0
add r2
add r4
mv r8
set 0 //clear shift counter
mv r14
not r3 //flip x_temp
mv r3
not r2
mv r2
set 1
add r3
mv r3
set 0
add r2
mv r2 //end x_temp flip
set 1
mv r15
xor r0
add r1
bl END_SHIFT_X //skip shifting x on iteration 1 SHIFT_X:
sra r2
sro r3
xor r0
add r1
mv r15
set 1
add r14
mv r14
bl SHIFT_X //END_SHIFT_X:
xor r0
add r3 //add y_temp and shifted x_temp
add r11
mv r11
set 0
add r2
mv r2
xor r0
add r2
add r10
mv r10
xor r0
mv r14
mv r2 //use r2 and r3 to hold shifted 1 value
set 1
mv r3
set 11 //skip if i is 11
mv r15
set 0
add r1
bl SHIFT_1
br END_SHIFT1 //SHIFT_1:
slg r3
slo r2
set 11
sub r1
mv r15
set 1
add r14
mv r14
bl SHIFT_1 //END_SHIFT1:
xor r0
mv r14
add r3
add r7
mv r7
set 0
add r2
add r6
mv r6
br SET_NEW //LT_0:
xor r0 //store y_temp in temp registers
mv r14
add r4
mv r10
set 0
add r5
mv r11
not r4 //flip y_temp
mv r4
not r5
mv r5
set 1
add r5
mv r5
set 0
add r4
mv r4 //SHIFT_YL:
sra r4 //shift y
sro r5
xor r0
add r1
mv r15
set 1
add r14
mv r14
bl SHIFT_YL
xor r0 //add x_temp and shifted y_temp and store
add r3
add r5
mv r9
set 0
add r2
add r4
mv r8
xor r0
mv r14 //SHIFT_XL:
sra r2 //shift X
sro r3
xor r0 //clear SC bit and set r0 to 0
add r1
mv r15
set 1
add r14
mv r14
bl SHIFT_XL
xor r0
mv r14
add r3 //add y_temp and shifted x_temp
add r11
mv r11
set 0
add r2
add r10
mv r10
xor r0
mv r2
set 1
mv r3
set 11 //skip if i is 11
mv r15
set 0
add r1
bl SHIFT_1L
br END_SHIFT1L //SHIFT_1L:
slg r3
slo r2
set 11
sub r1
mv r15
set 1
add r14
mv r14
bl SHIFT_1L //END_SHIFT1L:
xor r0
mv r14
not r3 //twos comp of shifted 1
mv r3
not r2
mv r2
set 1
add r3
mv r3
set 0
add r2
mv r2 //end twos comp
xor r0
add r7
add r3
mv r7
set 0
add r6
add r2
mv r6 //SET_NEW:
xor r0
add r9
mv r3
set 0
add r8
mv r2
set 0
add r11
mv r5
set 0
add r10
mv r4
xor r0
set 12
mv r15
set 1
add r1
mv r1
bl CORDIC_LOOP
set 5
st r2
set 6
st r3
slg r7
slo r6
slg r7
slo r6
slg r7
slo r6
slg r7
slo r6
set 7
st r6
set 8
st r7
halt
