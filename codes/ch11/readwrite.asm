;************** readwrite.asm ****************
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
msg1	DB	' please key in a number: ','$'
msg2	DB	' number keyed in is ','$'
msg3	DB	' value doubled is ','$'
n	DW	0
d	DW	0
_start1:
	dispstr	msg1
	readstr	_buf
	strtoi	_buf, '$', n
	newline
	dispstr	msg2
	itostr	n, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	PUSH	WORD [n]
	PUSH	2
	POP	BX
	POP	AX
	MUL	BX
	PUSH	AX
	POP	AX
	MOV	[d], AX
	dispstr	msg3
	itostr	d, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
