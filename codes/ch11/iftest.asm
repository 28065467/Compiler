;************** iftest.asm ****************
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
msg1	DB	' please key in a number (a): ','$'
msg2	DB	' please key in a number (b): ','$'
msg3	DB	' the bigger is ','$'
a	DW	0
b	DW	0
bigger	DW	0
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
	JGE	_go2
	JMP	_go3
_go2:
	PUSH	WORD [a]
	POP	AX
	MOV	[bigger], AX
_go3:
	PUSH	WORD [b]
	PUSH	WORD [a]
	POP	BX
	POP	AX
	CMP	AX, BX
	JG	_go4
	JMP	_go5
_go4:
	PUSH	WORD [b]
	POP	AX
	MOV	[bigger], AX
_go5:
	dispstr	msg3
	itostr	bigger, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
