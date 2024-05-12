;************** consttest.asm ****************
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
msg	DB	'This is a CONST message!!','$'
_start1:
	dispstr	msg
	MOV	AX, 4C00H
	INT	21H
