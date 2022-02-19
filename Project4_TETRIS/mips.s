#$0 = 0
#$1 = 1
#$2 = 1024
#$3 = one of the current block
#$4 = one of the current block
#$5 = one of the current block
#$6 = one of the current block
#$7 = 7 -- dead block number
#$8 = 0 to 6 -- the current block type
#$9 = 0 to 3 -- the current block rotate type
#$10 = 1024
#$11 = 1224
#$12 = keyboard input
#$13 = null
#$14 = counter
#$15 = temp to counter
#$16 = temp to line start
#$17 = 1213 left bottom of blocks
#$18 = 1033 right corner of blocks
#$19 to $30 = temp
#$31 = ra
#Dmem[1024] to Dmem[1224] = blocks information
#Dmem[4095] = score
#Dmem[4094] = speed
#Dmem[4092] = temp ra

#############################################################################

begin: addi $24 $0 114 #begin of the game
input $12
beq $12 $24 restart
j begin

restart: sw  $0  4095($0) #restart the game
addi $31 $0 10
sw   $31 4094($0)
addi $31 $0 27
addi $10 $0 1024
addi $11 $0 1224
j block

cleandm: sw   $0  0($10) #clean dmem
addi $10 $10 1
bgt  $11 $10 clrdm
addi $10 $0 1024
addi $27 $0 1
addi $26 $0 20
sll  $27 $27 $26
add $26 $0 $27

initial: addi $1  $0 1   #main initial
addi $2  $0 1024
addi $7 $0 7
addi $17 $0 1213
addi $18 $2 9
addi $29 $0 1024
addi $28 $0 10
sll  $29 $29 $28
addi $22 $17 21
addi $23 $17 11

setbottom: sw   $7  0($23)  #set the bottom of the blocks
addi $23 $23 1
bgt  $22 $23 setbottom
addi $20 $0 113

mainlp: addi $24 $0 20   #main loop
sll  $24 $1 $24
lw   $8 0($24)
lw   $24 4095($0)
addi $24 $24 1
addi $25 $0 1024
sw   $24 4095($0)
output $24
addi $9 $0 0
addi $20 $0 0
beq  $8  $20 shpa
addi $20 $0 1
beq  $8  $20 shpb
addi $20 $0 2
beq  $8  $20 shpc
addi $20 $0 3
beq  $8  $20 shpd
addi $20 $0 4
beq  $8  $20 shpe
addi $20 $0 5
beq  $8  $20 shpf

display: lw $21 0($3) # show the block and choose its colour
beq $7 $21 gameover
lw $22 0($4)
beq $7 $22 gameover
lw $23 0($5)
beq $7 $23 gameover
lw $24 0($6)
beq $7 $24 gameover
addi $20 $0 0
beq  $8  $20 displaya
addi $20 $0 1
beq  $8  $20 displayb
addi $20 $0 2
beq  $8  $20 displayc
addi $20 $0 3
beq  $8  $20 displayd
addi $20 $0 4
beq  $8  $20 displaye
addi $20 $0 5
beq  $8  $20 displayf

waitin: addi $20 $0 101 #wait for an input of keyboard
addi $21 $0 38
beq  $12 $21 rtt
addi $22 $0 39
beq  $12 $22 jr
addi $23 $0 37
beq  $12 $23 jl
addi $24 $0 40
beq  $12 $24 down
addi $25 $0 112
beq  $12 $25 pause
addi $26 $0 113
input $12

depause: sub  $28 $28 $1 #depause the game
bgt  $28 $0 waitin

down: lw $20 10($3) #block go down
beq  $20 $7 die
lw $20 10($4)
beq  $20 $7 die
lw $20 10($5)
beq  $20 $7 die
lw $20 10($6)
beq  $20 $7 die
addi $20 $0 0
bgt  $3 $17 die
addi $3 $3 10
addi $4 $4 10
addi $5 $5 10
addi $6 $6 10
j display

rtt: sw   $0 0($3) #rotate the block
sw   $0 0($4)
sw   $0 0($5)
sw   $0 0($6)
addi $22 $0 2
beq $8 $22 rttc
addi $23 $0 3
beq $8 $23 rttd
addi $24 $0 4
beq $8 $24 rtte
addi $25 $0 5
beq $8 $25 rttf
beq $8 $0 rtta
beq $8 $1 rttb
j waitin

die: sw   $7  0($3) #block goes die
add  $20 $0 $3
jal checkc
sw   $7  0($4)
add  $20 $0 $4
jal checkc
sw   $7  0($5)
add  $20 $0 $5
jal checkc
sw   $7  0($6)
add  $20 $0 $6
jal checkc
j continue

checkc: addi $14 $2 10 #check if the line needs to be cleaned
forcheckc: bgt  $14 $24 line
addi $14 $14 10
addi $20 $0 0
beq $20 $7 checkc
j forcheckc

line: addi $16 $14 -11 #get the line from the bottom
forline: addi $14 $14 -1
beq $16 $14 getscore
addi $20 $0 0
lw  $15 0($14)
beq $15 $20 record
j forline

record: add $24 $31 $0 #record the $31 to jump & update the block
jal block
add $31 $24 $0
jr $31

continue: jal block #update the block then go continue to the main loop
j mainlp

getscore: sw $24 13($0) #get 10 points for clean a line and update it to vga
lw $24 4095($0)
addi $24 $24 10
sw   $24 4095($0)
addi $20 $0 0
output $24
sw $31 4092($0)
lw $31 4094($0)
bgt $24 $31 speedup

cleanaline: sw $0 0($16) #change the line to 0
addi $16 $16 1
beq  $16 $18 checkc
j cleanaline

getlineabove: lw $31 4092($0) #get lines above the cleaning line and move them down
lw $24 13($0)
addi $25 $0 0
addi $14 $16 10
addi $20 $0 0
forclnline: sw $0 0($14)
addi  $14 $14 -1
beq   $14 $16 mvdown
j forclnline

mvdown: addi $14 $16 10  #move down all blocks above
formvdown: lw   $15 0($16)
sw   $15 0($14)
addi $16 $16 -1
addi $14 $14 -1
beq  $16 $0 cleanaline
j formvdown

#####################################################################################

jl: add $20 $7 $0 #judge if can move left
add $21 $3 $0
add $22 $4 $0
add $23 $5 $0
add $24 $6 $0

jllp: beq $21  $2 waitin #judge the left block $3
addi $21 $21 -10
add $20 $7 $0
bgt  $2  $21 jllp1
j jllp

jllp1: beq $22  $2 waitin #judge the second left block $4
addi $22 $22 -10
add $20 $7 $0
bgt  $2  $22 jllp2
j jllp1

jllp2: beq $23  $2 waitin #judge the third left block $5
addi $23 $23 -10
add $20 $7 $0
bgt  $2  $23 jllp3
j jllp2

jllp3: beq $24  $2 waitin #judge the fourth left block $6
addi $24 $24 -10
add $20 $7 $0
bgt  $2  $24 ml
j jllp3

jr: add $20 $7 $0 #judge if can move right
add $21 $6 $0
add $22 $5 $0
add $23 $4 $0
add $24 $3 $0

jrlp: beq $21  $18 waitin #judge the block $6
addi $21 $21 -10
add $20 $7 $0
bgt  $2  $21 jrlp1
j jrlp

jrlp1: beq $22  $18 waitin #judge the block $5
addi $22 $22 -10
add $20 $7 $0
bgt  $2  $22 jrlp2
j jrlp1

jrlp2: beq $23  $18 waitin #judge the block $4
addi $23 $23 -10
add $20 $7 $0
bgt  $2  $23 jrlp3
j jrlp2

jrlp3: beq $24  $18 waitin #judge the block $3
addi $24 $24 -10
add $20 $7 $0
bgt  $2  $24 mr
j jrlp3

ml: lw $20 -1($3) #move left
beq  $20 $7 waitin
lw $20 -1($4)
beq  $20 $7 waitin
lw $20 -1($5)
beq  $20 $7 waitin
lw $20 -1($6)
beq  $20 $7 waitin
addi $20 $0 0
beq  $8  $0 mla
beq  $8  $1 mlb
addi $22 $0 2
beq  $8  $22 mlc
addi $23 $0 3
beq  $8  $23 mld
addi $24 $0 4
beq  $8  $24 mle
addi $25 $0 5
beq  $8  $25 mlf


mr: lw $20 1($3) #move right
beq  $20 $7 waitin
lw $20 1($4)
beq  $20 $7 waitin
lw $20 1($5)
beq  $20 $7 waitin
lw $20 1($6)
beq  $20 $7 waitin
addi $20 $0 0
beq  $8  $0 mra
beq  $8  $1 mrb
addi $22 $0 2
beq  $8  $22 mrc
addi $23 $0 3
beq  $8  $23 mrd
addi $24 $0 4
beq  $8  $24 mre
addi $25 $0 5
beq  $8  $25 mrf

#####################################################################################

updrtt: add $20 $0 $7 #judge rotate
beq  $8  $0 updrtta
beq  $8  $1 updrttb
addi $22 $0 2
beq  $8  $22 updrttc
addi $23 $0 3
beq  $8  $23 updrttd
addi $24 $0 4
beq  $8  $24 updrtte
addi $25 $0 5
beq  $8  $25 updrttf


shpa: addi $3 $2 14
addi $4 $2 3
addi $5 $2 4
addi $6 $2 5
j display

rtta: beq $9 $0 shpa1
beq $9 $1 shpa2
beq $9 $22 shpa3
beq $9 $23 shpa0
j updrtt

shpa1: lw $24 0($3)
beq $7 $24 updrtt
lw $23 0($4)
beq $7 $23 updrtt
lw $22 0($5)
beq $7 $22 updrtt
lw $21 -11($6)
beq $7 $21 updrtt
addi $24 $0 0
addi $23 $0 0
addi $22 $0 0
addi $21 $0 0
addi $3 $3 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 -11
j forrtt
shpa2: add $22 $6 $0
shpa2lp: beq $22 $18 updrtt
addi $22 $22 -10
bgt $2 $22 shpa2mv
j shpa2lp
shpa2mv: lw $24 -11($3)
beq $7 $24 updrtt
addi $24 $0 0
lw $23 1($4)
addi $3 $3 -11
beq $7 $23 updrtt
addi $23 $0 0
lw $22 1($5)
addi $4 $4 1
beq $7 $22 updrtt
addi $22 $0 0
lw $21 0($6)
addi $5 $5 1
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 0
j forrtt
shpa3: lw $24 11($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 11
lw $23 0($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 0
lw $22 0($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 0
lw $21 0($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 0
j forrtt
shpa0: add $22 $6 $0
shpa0lp: beq $22 $2 updrtt
addi $22 $22 -10
bgt $2 $22 shpa0mv
j shpa0lp
shpa0mv: lw $24 0($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 0
lw $23 -1($4)
beq $7 $23 updrtt
addi $23 $0 0
lw $22 -1($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $4 $4 -1
lw $21 11($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $5 $5 -1
addi $6 $6 11
j forrtt

shpb: addi $3 $2 14
addi $4 $2 15
addi $5 $2 4
addi $6 $2 5
j display
rttb: beq $9 $0 shpb1
beq $9 $1 shpb2
beq $9 $22 shpb3
beq $9 $23 shpb0
j updrtt
shpb1: addi $3 $3 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j forrtt
shpb2: addi $3 $3 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j forrtt
shpb3: addi $3 $3 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j forrtt
shpb0: addi $3 $3 0
addi $4 $4 0
addi $5 $5 0
addi $6 $6 0
j forrtt

shpc: addi $3 $2 14
addi $4 $2 15
addi $5 $2 3
addi $6 $2 4
j display
rttc: beq $9 $0 shpc1
beq $9 $1 shpc2
beq $9 $22 shpc3
beq $9 $23 shpc0
j updrtt
shpc1: lw $24 -1($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 -1
lw $23 -12($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 -12
lw $22 1($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 1
lw $21 -10($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 -10
j forrtt
shpc2: add $22 $6 $0
shpc2lp: beq $22 $18 updrtt
addi $22 $22 -10
bgt $2 $22 shpc2mv
j shpc2lp
shpc2mv: lw $24 1($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 1
lw $23 12($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 12
lw $22 -1($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 -1
lw $21 10($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 10
j forrtt
shpc3: lw $24 -1($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 -1
lw $23 -12($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 -12
lw $22 1($5)
beq $7 $22 updrtt
addi $5 $5 1
addi $22 $0 0
lw $21 -10($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 -10
j forrtt
shpc0: add $22 $6 $0
shpc0lp: beq $22 $18 updrtt
addi $22 $22 -10
bgt $2 $22 shpc0mv
j shpc0lp
shpc0mv: lw $24 1($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 1
lw $23 12($4)
addi $23 $0 0
beq $7 $23 updrtt
addi $4 $4 12
lw $22 -1($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 -1
lw $21 10($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 10
j forrtt

shpd: addi $3 $2 34
addi $4 $2 24
addi $5 $2 14
addi $6 $2 4
j display
rttd: beq $9 $0 shpd1
beq $9 $1 shpd2
beq $9 $22 shpd3
beq $9 $23 shpd0
j updrtt
shpd1: add $22 $6 $0
addi $21 $18 -1
shpd1lp: beq $22 $18 updrtt
beq $22 $21 updrtt
beq $22 $2 updrtt
addi $22 $22 -10
bgt $2 $22 shpd1mv
j shpd1lp
shpd1mv: lw $24 -11($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 -11
lw $23 0($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 0
lw $22 11($5)
beq $7 $22 updrtt
addi $22 $0 0
lw $21 22($6)
addi $5 $5 11
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 22
j forrtt
shpd2: lw $24 11($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 11
lw $23 0($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 0
lw $22 -11($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 -11
lw $21 -22($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 -22
j forrtt
shpd3: add $22 $6 $0
addi $21 $18 -1
shpd3lp: beq $22 $18 updrtt
beq $22 $21 updrtt
beq $22 $2 updrtt
addi $22 $22 -10
bgt $2 $22 shpd3mv
j shpd3lp
shpd3mv: lw $24 -11($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 -11
lw $23 0($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 0
lw $22 11($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 11
lw $21 22($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 22
j forrtt
shpd0: lw $24 11($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 11
lw $23 0($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 0
lw $22 -11($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 -11
lw $21 -22($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 -22
j forrtt

shpe: addi $3 $2 25
addi $4 $2 15
addi $5 $2 4
addi $6 $2 5
j display
rtte: beq $9 $0 shpe1
beq $9 $1 shpe2
beq $9 $22 shpe3
beq $9 $23 shpe0
j updrtt
shpe1: add $22 $6 $0
shpe1lp: beq $22 $18 updrtt
addi $22 $22 -10
bgt $2 $22 shpe1mv
j shpe1lp
shpe1mv: lw $24 -11($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 -11
lw $23 0($4)
addi $23 $0 0
beq $7 $23 updrtt
addi $4 $4 0
lw $22 12($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 12
lw $21 1($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 1
j forrtt
shpe2: lw $24 11($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 11
lw $23 11($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 11
lw $22 -1($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 -1
lw $21 -1($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 -1
j forrtt
shpe3: add $22 $6 $0
shpe3lp: beq $22 $2 updrtt
addi $22 $22 -10
bgt $2 $22 shpe3mv
j shpe3lp
shpe3mv: lw $24 -1($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 -1
lw $23 -12($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 -12
lw $22 0($5)
beq $7 $22 updrtt
addi $22 $0 0
addi $5 $5 0
lw $21 11($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 11
j forrtt
shpe0: lw $24 1($3)
beq $7 $24 updrtt
addi $24 $0 0
addi $3 $3 1
lw $23 1($4)
beq $7 $23 updrtt
addi $23 $0 0
addi $4 $4 1
lw $22 -11($5)
addi $22 $0 0
beq $7 $22 updrtt
addi $5 $5 -11
lw $21 -11($6)
beq $7 $21 updrtt
addi $21 $0 0
addi $6 $6 -11
j forrtt

shpf: addi $3 $2 25
addi $4 $2 15
addi $5 $2 5
addi $6 $2 6
j display
rttf: beq $9 $0 shpf1
beq $9 $1 shpf2
beq $9 $22 shpf3
beq $9 $23 shpf0
j updrtt
shpf1: add $22 $5 $0
shpf1lp: beq $22 $2 updrtt
addi $22 $22 -10
bgt $2 $22 shpf1mv
j shpf1lp
shpf1mv: lw $24 -11($3)
lw $23 0($4)
lw $22 21($5)
lw $21 10($6)
beq $7 $24 updrtt
beq $7 $23 updrtt
beq $7 $22 updrtt
beq $7 $21 updrtt
addi $24 $0 0
addi $23 $0 0
addi $22 $0 0
addi $21 $0 0
addi $3 $3 -11
addi $4 $4 0
addi $5 $5 21
addi $6 $6 10
j forrtt
shpf2: lw $24 10($3)
lw $23 10($4)
lw $22 -11($5)
lw $21 -11($6)
beq $7 $24 updrtt
beq $7 $23 updrtt
beq $7 $22 updrtt
beq $7 $21 updrtt
addi $24 $0 0
addi $23 $0 0
addi $22 $0 0
addi $21 $0 0
addi $3 $3 10
addi $4 $4 10
addi $5 $5 -11
addi $6 $6 -11
j forrtt
shpf3: add $22 $6 $0
shpf3lp: beq $22 $18 updrtt
addi $22 $22 -10
bgt $2 $22 shpf3mv
j shpf3lp
shpf3mv: lw $24 -10($3)
lw $23 -21($4)
lw $22 0($5)
lw $21 11($6)
beq $7 $24 updrtt
beq $7 $23 updrtt
beq $7 $22 updrtt
beq $7 $21 updrtt
addi $24 $0 0
addi $23 $0 0
addi $22 $0 0
addi $21 $0 0
addi $3 $3 -10
addi $4 $4 -21
addi $5 $5 0
addi $6 $6 11
j forrtt
shpf0: lw $24 11($3)
lw $23 11($4)
lw $22 -10($5)
lw $21 -10($6)
beq $7 $24 updrtt
beq $7 $23 updrtt
beq $7 $22 updrtt
beq $7 $21 updrtt
addi $24 $0 0
addi $23 $0 0
addi $22 $0 0
addi $21 $0 0
addi $3 $3 11
addi $4 $4 11
addi $5 $5 -10
addi $6 $6 -10
j forrtt

forrtt: addi $9 $9 1 #update the block rotate information
addi $24 $0 4
beq $9 $24 clr
j updrtt
clr: addi $9 $0 0
j updrtt    #end main

####################################################################

gameover: sw $7 0($3) #game over
sw $7 0($4)
sw $7 0($5)
sw $7 0($6)
addi $3 $0 0
addi $4 $0 0
addi $5 $0 0
addi $6 $0 0
jal block
forgameover:
input $12
addi $24 $0 114
beq $12 $24 restart
j forgameover

pause: addi $25 $0 112 #pause the game
addi $24 $0 114
input $12
beq $12 $25 dep
beq $12 $24 restart
j pause

dep: lw $24 4095($0) #load score and depause the game
output $24
j depause

block: addi $10 $0 1024 #update the block information to vga
add $27 $0 $26
lw   $25 0($10)
sw   $25 0($27)
addi $27 $27 1
addi $10 $10 1
bgt  $11 $10 -5
jr $31

speedup: add $31 $31 $31 #speed up
add $31 $31 $31
sw $31 4094($0)
addi $31 $0 1
addi $31 $0 1
srl $29 $29 $31
j getlineabove


displaya: addi $25 $0 1
sw   $25  0($3)
sw   $0  -10($3)
sw   $25  0($4)
sw   $0  -10($4)
sw   $25  0($5)
sw   $0  -10($5)
sw   $25  0($6)
sw   $0  -10($6)
jal block
add  $28 $0 $29
j waitin

displayb: addi $25 $0 2
sw   $25  0($3)
sw   $0  -10($3)
sw   $25  0($4)
sw   $0  -10($4)
sw   $25  0($5)
sw   $0  -10($5)
sw   $25  0($6)
sw   $0  -10($6)
jal block
add  $28 $0 $29
j waitin

displayc: addi $25 $0 3
sw   $25  0($3)
sw   $0  -10($3)
sw   $25  0($4)
sw   $0  -10($4)
sw   $25  0($5)
sw   $0  -10($5)
sw   $25  0($6)
sw   $0  -10($6)
jal block
add  $28 $0 $29
j waitin

displayd: addi $25 $0 4
sw   $25  0($3)
sw   $0  -10($3)
sw   $25  0($4)
sw   $0  -10($4)
sw   $25  0($5)
sw   $0  -10($5)
sw   $25  0($6)
sw   $0  -10($6)
jal block
add  $28 $0 $29
j waitin

displaye: addi $25 $0 5
sw   $25  0($3)
sw   $0  -10($3)
sw   $25  0($4)
sw   $0  -10($4)
sw   $25  0($5)
sw   $0  -10($5)
sw   $25  0($6)
sw   $0  -10($6)
jal block
add  $28 $0 $29
j waitin

displayf: addi $25 $0 6
sw   $25  0($3)
sw   $0  -10($3)
sw   $25  0($4)
sw   $0  -10($4)
sw   $25  0($5)
sw   $0  -10($5)
sw   $25  0($6)
sw   $0  -10($6)
jal block
add  $28 $0 $29
j waitin

updrtta: addi $20 $0 1
sw   $20 0($3)
sw   $20 0($4)
sw   $20 0($5)
sw   $20 0($6)
jal block
j waitin

updrttb: addi $20 $0 2
sw   $20 0($3)
sw   $20 0($4)
sw   $20 0($5)
sw   $20 0($6)
jal block
j waitin

updrttc: addi $20 $0 3
sw   $20 0($3)
sw   $20 0($4)
sw   $20 0($5)
sw   $20 0($6)
jal block
j waitin

updrttd: addi $20 $0 4
sw   $20 0($3)
sw   $20 0($4)
sw   $20 0($5)
sw   $20 0($6)
jal block
j waitin

updrtte: addi $20 $0 5
sw   $20 0($3)
sw   $20 0($4)
sw   $20 0($5)
sw   $20 0($6)
jal block
j waitin

updrttf: addi $20 $0 6
sw   $20 0($3)
sw   $20 0($4)
sw   $20 0($5)
sw   $20 0($6)
jal block
j waitin

mla: addi $25 $0 1
addi $3 $3 -1
sw $25 0($3)
sw $0 1($3)
addi $4 $4 -1
sw $25 0($4)
sw $0 1($4)
addi $5 $5 -1
sw $25 0($5)
sw $0 1($5)
addi $6 $6 -1
sw $25 0($6)
sw $0 1($6)
jal block
j waitin

mlb: addi $25 $0 2
addi $3 $3 -1
sw $25 0($3)
sw $0 1($3)
addi $4 $4 -1
sw $25 0($4)
sw $0 1($4)
addi $5 $5 -1
sw $25 0($5)
sw $0 1($5)
addi $6 $6 -1
sw $25 0($6)
sw $0 1($6)
jal block
j waitin

mlc: addi $25 $0 3
addi $3 $3 -1
sw $25 0($3)
sw $0 1($3)
addi $4 $4 -1
sw $25 0($4)
sw $0 1($4)
addi $5 $5 -1
sw $25 0($5)
sw $0 1($5)
addi $6 $6 -1
sw $25 0($6)
sw $0 1($6)
jal block
j waitin

mld: addi $25 $0 4
addi $3 $3 -1
sw $25 0($3)
sw $0 1($3)
addi $4 $4 -1
sw $25 0($4)
sw $0 1($4)
addi $5 $5 -1
sw $25 0($5)
sw $0 1($5)
addi $6 $6 -1
sw $25 0($6)
sw $0 1($6)
jal block
j waitin

mle: addi $25 $0 5
addi $3 $3 -1
sw $25 0($3)
sw $0 1($3)
addi $4 $4 -1
sw $25 0($4)
sw $0 1($4)
addi $5 $5 -1
sw $25 0($5)
sw $0 1($5)
addi $6 $6 -1
sw $25 0($6)
sw $0 1($6)
jal block
j waitin

mlf: addi $25 $0 6
addi $3 $3 -1
sw $25 0($3)
sw $0 1($3)
addi $4 $4 -1
sw $25 0($4)
sw $0 1($4)
addi $5 $5 -1
sw $25 0($5)
sw $0 1($5)
addi $6 $6 -1
sw $25 0($6)
sw $0 1($6)
jal block
j waitin

mra: addi $25 $0 1
addi $6 $6 1
sw $25 0($6)
sw $0 -1($6)
addi $5 $5 1
sw $25 0($5)
sw $0 -1($5)
addi $4 $4 1
sw $25 0($4)
sw $0 -1($4)
addi $3 $3 1
sw $25 0($3)
sw $0 -1($3)
jal block
j waitin

mrb: addi $25 $0 2
addi $6 $6 1
sw $25 0($6)
sw $0 -1($6)
addi $5 $5 1
sw $25 0($5)
sw $0 -1($5)
addi $4 $4 1
sw $25 0($4)
sw $0 -1($4)
addi $3 $3 1
sw $25 0($3)
sw $0 -1($3)
jal block
j waitin

mrc: addi $25 $0 3
addi $6 $6 1
sw $25 0($6)
sw $0 -1($6)
addi $5 $5 1
sw $25 0($5)
sw $0 -1($5)
addi $4 $4 1
sw $25 0($4)
sw $0 -1($4)
addi $3 $3 1
sw $25 0($3)
sw $0 -1($3)
jal block
j waitin

mrd: addi $25 $0 4
addi $6 $6 1
sw $25 0($6)
sw $0 -1($6)
addi $5 $5 1
sw $25 0($5)
sw $0 -1($5)
addi $4 $4 1
sw $25 0($4)
sw $0 -1($4)
addi $3 $3 1
sw $25 0($3)
sw $0 -1($3)
jal block
j waitin

mre: addi $25 $0 5
addi $6 $6 1
sw $25 0($6)
sw $0 -1($6)
addi $5 $5 1
sw $25 0($5)
sw $0 -1($5)
addi $4 $4 1
sw $25 0($4)
sw $0 -1($4)
addi $3 $3 1
sw $25 0($3)
sw $0 -1($3)
jal block
j waitin

mrf: addi $25 $0 6
addi $6 $6 1
sw $25 0($6)
sw $0 -1($6)
addi $5 $5 1
sw $25 0($5)
sw $0 -1($5)
addi $4 $4 1
sw $25 0($4)
sw $0 -1($4)
addi $3 $3 1
sw $25 0($3)
sw $0 -1($3)
jal block
j waitin