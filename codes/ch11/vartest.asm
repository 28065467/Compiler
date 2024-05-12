;************** vartest.asm ****************
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
msg1	DB	' b from PROCEDURE is ','$'
msg2	DB	' b from PROGRAM   is ','$'
a	DW	0
_start1:
	JMP	_go2
proc:
	JMP	_start2
b	DW	0
_start2:
	PUSH	123
	POP	AX
	MOV	[b], AX
	dispstr	msg1
	itostr	b, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	RET
_go2:
	CALL	proc
	dispstr	msg2
	itostr	b, _intstr, '$'
	MOV	DX, _intstr
	MOV	AH, 09H
	INT	21H
	newline
	MOV	AX, 4C00H
	INT	21H
