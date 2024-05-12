;************** readwrite2.asm ****************
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
msg1	DB	' please key in two numbers: ','$'
msg2	DB	' numbers keyed in are ','$'
msg3	DB	' sum is ','$'
m	DW	0
n	DW	0
sum	DW	0
_start1:
	dispstr	msg1
	readstr	_buf
	strtoi	_buf, '$', m
	newline
	readstr	_buf
	strtoi	_buf, '$', n
	newline
	dispstr	msg2
	itostr	m, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	itostr	n, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	PUSH	WORD [m]
	PUSH	WORD [n]
	POP	BX
	POP	AX
	ADD	AX, BX
	PUSH	AX
	POP	AX
	MOV	[sum], AX
	dispstr	msg3
	itostr	sum, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
