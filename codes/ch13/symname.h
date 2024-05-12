/****************** symname.h *****************/
#include <stdlib.h>
#include "sym.h"
char names[symSYMMAX][32];
void symnameinit()
{
  strcpy(names[symEOF],"EOF");
  strcpy(names[symerror],"error");
  strcpy(names[symIDENTIFIER],"IDENTIFIER");
  strcpy(names[symNUMBER],"NUMBER");
  strcpy(names[symPLUS],"PLUS");
  strcpy(names[symMINUS],"MINUS");
  strcpy(names[symMUL],"MUL");
  strcpy(names[symDIV],"DIV");
  strcpy(names[symEQ],"EQ");
  strcpy(names[symEQUAL],"EQUAL");
  strcpy(names[symNEQ],"NEQ");
  strcpy(names[symLESS],"LESS");
  strcpy(names[symLEQ],"LEQ");
  strcpy(names[symGREATER],"GREATER");
  strcpy(names[symGEQ],"GEQ");
  strcpy(names[symLPAREN],"LPAREN");
  strcpy(names[symRPAREN],"RPAREN");
  strcpy(names[symSEMI],"SEMI");
  strcpy(names[symPERIOD],"PERIOD");
  strcpy(names[symLBRACE],"LBRACE");
  strcpy(names[symRBRACE],"RBRACE");
  strcpy(names[symWHILE],"WHILE");
  strcpy(names[symIF],"IF");
  strcpy(names[symELSE],"ELSE");
  strcpy(names[symPRINT],"PRINT");
}
