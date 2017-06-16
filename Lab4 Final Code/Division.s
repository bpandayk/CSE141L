set 16     //MSW dividend from 128
slg r0
slg r0
slg r0
ld r2
mv r14
set 1         //LSW dividend from 129
add r14
ld r3
mv r14
set 1         //divisor from 130
add r14
ld r4
set 0 //set loop counter to 0
mv r1
set 0 //set temporary dividend to  0
mv r7 //LOOP:
slg r2 //shift MSB off dividend
slo r7 //shift overflow into div
sra r2
slg r3 //shift MSB of LSW into LSB of MSW
slo r2
xor r0
add r4
sro r0
mv r15 //put divisor in comp reg
xor r0
add r7 //put div in r0
sro r0
bl PUSH0 //div less than divisor
slg r6 //move MSB of LSW of quotient to
slo r5 //LSB of MSW of quotient
set 1
add r6
mv r6
set 0 //div=div-divisor_temp
add r7
sub r4
mv r7
br END_PUSH //PUSH0:
slg r6 //move MSB of LSW of quotient to
slo r5 //LSB of MSW of quotient //END_PUSH:
set 16
mv r15
set 0
sra r0
set 1
add r1
mv r1
bl LOOP
set 3
mv r10
set 0
sra r0
add r14
sub r10
mv r14
st r5
set 0
sra r0
set 1
add r14
st r6
halt
