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

def assemble(words, outFile):

    op = opcode[words[0]]
    outFile.write(format(op, 'b').zfill(3))
    if op == 0:
        reg = registers[words[1]]
        func = funct[words[0]]
        outFile.write(format(reg, 'b').zfill(4))
        outFile.write(format(func, 'b').zfill(2))
    else:
        immediate = int(words[1])
        outFile.write(str(Bits(int = immediate, length = 6).bin))
    outFile.write('    // ')
    for word in words:
        outFile.write(word + ' ')
    outFile.write('\n')


if __name__ == "__main__":
    print("Beginning...")
    with open('Test.s') as theInputFile, open('machineCodeTest.txt', 'w') as theOutputFile:
        count = 1
        for line in theInputFile:
            print ("Assembling line %d" % count)
            words = line.split()
            assemble(words, theOutputFile)
            count += 1
