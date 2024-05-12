;************** test1001.asm ****************
;
	ORG	100H
	JMP	_start1
_intstr	DB	'     ','$'
_buf	TIMES 256 DB ' '
	DB 13,10,'$'
%include	"itostr.mac"
%include	"newline.mac"
a	DW	0
b	DW	0
c	DW	0
_start1:
	PUSH	5
	POP	AX
	MOV	[a], AX
	PUSH	2
	POP	AX
	MOV	[b], AX
	PUSH	WORD [a]
	PUSH	WORD [b]
	POP	BX
	POP	AX
	CMP	AX, BX
	JG	_go2
	JMP	_go3
_go2:
	PUSH	WORD [a]
	PUSH	WORD [b]
	POP	BX
	POP	AX
	SUB	AX, BX
	PUSH	AX
	POP	AX
	MOV	[c], AX
_go3:
	itostr	c, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
