;************** whiletest.asm ****************
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
msg1	DB	' keyin a number (a): ','$'
msg2	DB	' keyin a number (b): ','$'
msg3	DB	'H.C.F =','$'
a	DW	0
b	DW	0
c	DW	0
q	DW	0
r	DW	0
hcf	DW	0
_start1:
	dispstr	msg1
	readstr	_buf
	strtoi	_buf, '$', a
	newline
	dispstr	msg2
	readstr	_buf
	strtoi	_buf, '$', b
	newline
	PUSH	WORD [a]
	PUSH	WORD [b]
	POP	BX
	POP	AX
	CMP	AX, BX
	JL	_go2
	JMP	_go3
_go2:
	PUSH	WORD [a]
	POP	AX
	MOV	[c], AX
	PUSH	WORD [b]
	POP	AX
	MOV	[a], AX
	PUSH	WORD [c]
	POP	AX
	MOV	[b], AX
_go3:
_go4:
	PUSH	WORD [b]
	PUSH	0
	POP	BX
	POP	AX
	CMP	AX, BX
	JG	_go5
	JMP	_go6
_go5:
	PUSH	WORD [a]
	PUSH	WORD [b]
	POP	BX
	MOV	DX, 0
	POP	AX
	DIV	BX
	PUSH	AX
	POP	AX
	MOV	[q], AX
	PUSH	WORD [a]
	PUSH	WORD [b]
	PUSH	WORD [q]
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	POP	BX
	POP	AX
	SUB	AX, BX
	PUSH	AX
	POP	AX
	MOV	[r], AX
	PUSH	WORD [b]
	POP	AX
	MOV	[a], AX
	PUSH	WORD [r]
	POP	AX
	MOV	[b], AX
	JMP	_go4
_go6:
	PUSH	WORD [a]
	POP	AX
	MOV	[hcf], AX
	dispstr	msg3
	itostr	hcf, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
