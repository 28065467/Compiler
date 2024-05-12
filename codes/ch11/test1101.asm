;************** test1101.asm ****************
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
msg1	DB	' keyin a number to n please: ','$'
msg2	DB	' n=','$'
msg3	DB	' 1+2+3+...+n=','$'
n	DW	0
sum	DW	0
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
	PUSH	0
	POP	AX
	MOV	[sum], AX
_go2:
	PUSH	WORD [n]
	PUSH	0
	POP	BX
	POP	AX
	CMP	AX, BX
	JG	_go3
	JMP	_go4
_go3:
	PUSH	WORD [sum]
	PUSH	WORD [n]
	POP	BX
	POP	AX
	ADD	AX, BX
	PUSH	AX
	POP	AX
	MOV	[sum], AX
	PUSH	WORD [n]
	PUSH	1
	POP	BX
	POP	AX
	SUB	AX, BX
	PUSH	AX
	POP	AX
	MOV	[n], AX
	JMP	_go2
_go4:
	dispstr	msg3
	itostr	sum, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
