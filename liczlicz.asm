ORG 1800h
START:
	LD SP,1900h
	XOR	A
	LD	C,A
	JR enable

ds 	0x1838-$,0
Interrupt:
	XOR	A
	IN	A,(00h)
	AND	15
	LD	B,A
	OUT	(00h),A
	IN	A,(01h)
	LD	C,A
	EI
	RETI
enable:
	IM 1
	XOR	A
	LD	B, A
	EI
ini:
	OUT	(00h),A
	LD	D,64
	LD	H,255
main:
	IN	A,(01h)
	BIT	4,A
	JR	Z,zera
jedynki:
	DEC	H
	LD	D,64
	XOR	A
	CP	H
	JR	NZ, main
	DI
	LD	A,9
	CP	B
	JR	Z, reload
	LD	A,C
	BIT	4,A
	JR	NZ,time
	INC 	B
	LD	A,B
time:
	OUT	(00h),A
	EI
	XOR	A
	LD	C,A
	LD	D,255
	IN	A,(01h)
	BIT	4,A
	JR	NZ,time
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
reload:
	LD 	B,0
	JP	time
