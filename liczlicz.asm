ORG 1800h
START:
	LD SP,1900h
	JR enable

ds 	0x1838-$,0
Interrupt:
	IN	A,(00h)
	AND	15
	LD	B,A
	OUT	(00h),A
	EI
	RETI
enable:
	IM 1
	XOR	A
	LD	B, A
	EI
ini:
	LD	D,2
	LD	H,4
main:
	IN	A,(01h)
	BIT	4,A
	JR	Z,zera
jedynki:
	DEC	H
	LD	D,2
	XOR	A
	CP	H
	JR	NZ, main
	INC B
	LD	A,B
	OUT	(00h),A
time:	
	LD	D,2
	IN	A,(01h)
	BIT	4,A
	JR	Z,time
	JP 	zera2
zera:
	IN	A,(01h)
	BIT	4,A
	JR	NZ,jedynki
	DEC 	D
	XOR	A
	CP	D
	JR	NZ, main
	JP	ini
zera2:
	IN	A,(01h)
	BIT	4,A
	JR	NZ,time
	DEC 	D
	XOR	A
	CP	D
	JR	NZ, zera2
	JP	ini