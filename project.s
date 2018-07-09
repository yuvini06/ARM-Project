@ ARM Assembly example for using scanf("%d") and printf("%d")
@ Try this with characters (%c)

	.text	@ instruction memory
@-------------------------------------
scan_Matrix:
	MOV r2,#4
	MUL r10,r4,r5
	MUL r11,r10,r2
	
	MOV r7,#0	@rows
	MOV r8,#0	@columns
	MOV r9,#0	@elements
	

	@scanf matrix elements
loop: 
	CMP r9,r10
	BNE input_loop

	CMP r6,#0
	BEQ original
	
	CMP r6,#1
	BEQ inversion
	
	CMP r6,#2
	BEQ rotation_180
	
	CMP r6,#3
	BEQ flip

	

input_loop:
	SUB	sp, sp, #4
	LDR	r0, =formats
	MOV	r1, sp	
	BL	scanf
	ADD r9,#1
	b loop
	
@-------------------------------------
original:



print_Original:
		LDR	r0, =format0
		BL 	printf
		b print_Matrix0



@print matrix elements
print_Matrix0:
	
	MOV r7,#0	@rows
	MOV r8,#0	@columns
	MOV r9,r11	@elements
	SUB r9,r9,#4
	
row0:
	CMP r4,r7
	BNE column0
	ADD sp,sp,r11
	b exit

column0:
	CMP r5,r8
	BNE result0
	MOV r8,#0
	ADD r7,#1
	LDR	r0, =formatnew_row
	BL 	printf
	b row0 

result0:
	LDR	r1,[sp,r9]
	LDR r0, =formatelement
	BL printf
	SUB r9,r9,#4
	ADD r8,#1
	b row0

@------------------------------------
inversion:



print_Invert:
		LDR	r0, =format1
		BL 	printf
		b print_Matrix1


@print matrix elements
print_Matrix1:
	
	MOV r7,#0	@rows
	MOV r8,#0	@columns
	MOV r9,r11	@elements
	SUB r9,r9,#4

row1:
	CMP r4,r7
	BNE column1
	ADD sp,sp,r11
	b exit

column1:
	CMP r5,r8
	BNE result1
	MOV r8,#0
	ADD r7,#1
	LDR	r0, =formatnew_row
	BL 	printf
	b row1 

result1:
	MOV r2,#255
	LDR	r1,[sp,r9]
	SUB r2,r2,r1
	MOV r1,r2

	LDR r0, =formatelement
	BL printf
	SUB r9,r9,#4
	ADD r8,#1
	b row1

@-------------------------------------	
rotation_180:
	


print_Rotate:
		ldr	r0, =format2
		bl 	printf
		b print_Matrix2


@print matrix elements
print_Matrix2:
	
	MOV r7,#0	@rows
	MOV r8,#0	@columns
	MOV r9,#0	@elements

row2:
	CMP r4,r7
	BNE column2
	ADD sp,sp,r11
	b exit

column2:
	CMP r5,r8
	BNE result2
	MOV r8,#0
	ADD r7,#1
	LDR	r0, =formatnew_row
	BL 	printf
	b row2 

result2:
	LDR	r1,[sp,r9]
	LDR r0, =formatelement
	BL printf
	ADD r9,r9,#4
	ADD r8,#1
	b row2

@------------------------------------
flip:
	

print_Flip:
		ldr	r0, =format3
		bl 	printf
		b print_Matrix3


@print matrix elements
print_Matrix3:
	
	MOV r7,#0	@rows
	MOV r8,#0	@columns
	MOV r9,r11	@elements
	MOV r2,#4
	MUL r2,r5,r2
	SUB r9,r9,r2
	@SUB r9,#4
	MOV r6,r9

row3:
	CMP r4,r7
	BNE column3
	ADD sp,sp,r11
	b exit

column3:
	CMP r5,r8
	BNE result3
	MOV r9,r6
	MOV r2,#4
	MUL r2,r5,r2
	SUB r9,r9,r2
	MOV r6,r9
	MOV r8,#0
	ADD r7,#1
	LDR	r0, =formatnew_row
	BL 	printf
	b row3

result3:

	LDR	r1,[sp,r9]
	LDR r0, =formatelement
	BL printf
	ADD r9,r9,#4
	ADD r8,#1
	b row3

@------------------------------------


	.global main

main:
	@ stack handling
	@ push (store) lr to the stack
	SUB	sp, sp, #4
	STR	lr, [sp, #0]

	@allocate stack for inputs
	SUB	sp, sp, #12

	@scanf for rows
	LDR	r0, =formats
	MOV	r1, sp	
	BL	scanf	

	@copy rows from the stack to register r4
	LDR	r4, [sp]

	@scanf for columns
	LDR	r0, =formats
	MOV	r1, sp	
	BL	scanf	
	
	@copy columns from stack to register r5
	LDR	r5, [sp]

	@scanf for opcode
	LDR	r0, =formats
	MOV	r1, sp	
	BL	scanf	
	
	@copy opcode from stack to register r6
	LDR	r6, [sp]	
	
	@release stack
	ADD	sp, sp, #12

	@BL scan_Matrix

	CMP r6,#0
	BEQ scan_Matrix
	
	CMP r6,#1
	BEQ scan_Matrix
	
	CMP r6,#2
	BEQ scan_Matrix
	
	CMP r6,#3
	BEQ scan_Matrix

	BNE print_Error
	

	


	print_Error:
		ldr	r0, =format4
		bl 	printf
		b exit

	exit:
	mov r1, r4
	mov	r2, r5
	mov	r3, r6

	@format for printf
	@ldr	r0, =formatp
	@bl 	printf
	

	
    @ stack handling (pop lr from the stack) and return
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr		
	
	
	.data	@ data memory
formats: .asciz "%d"
@formatp: .asciz "The number is inputs are %d %d %d\n"
format0: .asciz "Original\n"
format1: .asciz "Inversion\n"
format2: .asciz "Rotation by 180\n"
format3: .asciz "Flip\n"
format4: .asciz "Invalid operation\n"
formatnew_row: .asciz "\n"
formatelement: .asciz "%d "
formate: .asciz "%d "




