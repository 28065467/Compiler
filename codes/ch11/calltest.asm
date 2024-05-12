;************** calltest.asm ****************
;
	ORG	100H
	JMP	_start1
_intstr	DB	'     ','$'
_buf	TIMES 256 DB ' '
	DB 13,10,'$'
%include	"dispstr.mac"
%include	"itostr.mac"
%include	"readstr.mac"
%include	"strtoi.mac"
%include	"newline.mac"
msg1	DB	' please keyin a degree (deg) : ','$'
msg2	DB	' deg = ','$'
msg3	DB	' c = ','$'
msg4	DB	' f = ','$'
deg	DW	0
f	DW	0
c	DW	0
_start1:
	JMP	_go2
cTOf:
	JMP	_start2
_start2:
	PUSH	WORD [deg]
	PUSH	9
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	PUSH	5
	POP	BX
	MOV	DX, 0
	POP	AX
	DIV	BX
	PUSH	AX
	PUSH	32
	POP	BX
	POP	AX
	ADD	AX, BX
	PUSH	AX
	POP	AX
	MOV	[f], AX
	RET
_go2:
	JMP	_go3
fTOc:
	JMP	_start3
_start3:
	PUSH	WORD [deg]
	PUSH	32
	POP	BX
	POP	AX
	SUB	AX, BX
	PUSH	AX
	PUSH	5
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	PUSH	9
	POP	BX
	MOV	DX, 0
	POP	AX
	DIV	BX
	PUSH	AX
	POP	AX
	MOV	[c], AX
	RET
_go3:
	dispstr	msg1
	readstr	_buf
	strtoi	_buf, '$', deg
	newline
	CALL	cTOf
	dispstr	msg2
	itostr	deg, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	dispstr	msg4
	itostr	f, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	CALL	fTOc
	dispstr	msg2
	itostr	deg, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	dispstr	msg3
	itostr	c, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
