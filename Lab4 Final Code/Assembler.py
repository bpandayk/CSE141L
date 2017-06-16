from bitstring import Bits

opcode = {
    'ld' : 0,
    'st' : 0,
    'slg' : 0,
    'slo' : 0,
    'add' : 1,
    'sub' : 1,
    'xor' : 1,
    'not' : 1,
    'mv' : 2,
    'sra' : 2,
    'sro' : 2,
    'set' : 3,
    'bl' : 4,
    'br' : 5,
    'bmh' : 6,
    'halt': 7
}

funct = {
    'ld' : 0,
    'st' : 1,
    'slg' : 2,
    'slo' : 3,
    'add' : 0,
    'sub' : 1,
    'xor' : 2,
    'not' : 3,
    'mv' : 0,
    'sra' : 1,
    'sro' : 2
}

registers = {
    'r0' : 0,
    'r1' : 1,
    'r2' : 2,
    'r3' : 3,
    'r4' : 4,
    'r5' : 5,
    'r6' : 6,
    'r7' : 7,
    'r8' : 8,
    'r9' : 9,
    'r10' : 10,
    'r11' : 11,
    'r12' : 12,
    'r13' : 13,
    'r14' : 14,
    'r15' : 15,
}

labels = {
    'OUTER_LOOP' : 0, #string_search labels
    'INNER_LOOP' : 1,
    'INC'        : 2,
    'END_INC'    : 3,
    'END_INNER'  : 4,
    'END_OUTER'  : 5, #end of string search labels
    'LOOP'       : 6,
    'PUSH0'      : 7,
    'END_PUSH'   : 8,
    'CORDIC_LOOP' : 9, #beginning of cordic labels
    'SHIFT_Y'    : 10,
    'END_SHIFT_Y': 11,
    'SHIFT_X'    : 12,
    'END_SHIFT_X': 13,
    'SHIFT_1'    : 14,
    'END_SHIFT1' : 15,
    'LT_0'       : 16,
    'SHIFT_YL'   : 17,
    'SHIFT_XL'   : 18,
    'SHIFT_1L'   : 19,
    'END_SHIFT1L' : 20,
    'SET_NEW'    : 21
}

def assemble(words, outFile):
    if words[0] in opcode:
        op = opcode[words[0]]
        outFile.write(format(op, 'b').zfill(3))
        if op == 0 or op == 1 or op == 2:
            reg = registers[words[1]]
            func = funct[words[0]]
            outFile.write(format(reg, 'b').zfill(4))
            outFile.write(format(func, 'b').zfill(2))
        elif op == 4 or op == 5 or op == 6:
            label = labels[words[1]];
            outFile.write(format(label, 'b').zfill(6))
        elif op == 3:
            immediate = int(words[1])
            outFile.write(str(Bits(int = immediate, length = 6).bin))
        else:
            fill = 0
            outFile.write(format(fill, 'b').zfill(6))
        outFile.write('    // ')
        for word in words:
            outFile.write(word + ' ')
        outFile.write('\n')


if __name__ == "__main__":
    print("Beginning...")
    with open('stringSearch.s') as theInputFile, open('stringsearch.txt', 'w') as theOutputFile:
        count = 1
        for line in theInputFile:
            print ("Assembling line %d" % count)
            words = line.split()
            assemble(words, theOutputFile)
            count += 1
