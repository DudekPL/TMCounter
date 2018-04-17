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
	LD	D,127
	LD	H,255
	LD	A,B
	OUT	(00h),A
main:
	IN	A,(01h)
	BIT	4,A
	JR	NZ,zera
jedynki:
	DEC	H
	LD	D,127
	XOR	A
	CP	H
	JR	NZ, main
	INC B
	JP 	ini
zera:
	IN	A,(01h)
	BIT	4,A
	JR	Z,jedynki
	DEC 	D
	XOR	A
	CP	D
	JR	NZ, main
	JP	ini
	