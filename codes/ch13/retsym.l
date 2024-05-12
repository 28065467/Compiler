%{
   /*********************** retsym.l *********************/
   #include <stdlib.h>
   #include "sym.h"
   #include "symbol.h"
   #define YY_DECL struct symbolTag *yylex(void)
%}
%%
[a-z]    return newSymbol(symIDENTIFIER, yytext);
[0-9]+   return newSymbol(symNUMBER, yytext);
"-"      return newSymbol(symMINUS, "-");
"("      return newSymbol(symLPAREN, "(");
")"      return newSymbol(symRPAREN, ")");
"<"      return newSymbol(symLESS, "<");
">"      return newSymbol(symGREATER, ">");
"="      return newSymbol(symEQUAL, "=");
"+"      return newSymbol(symPLUS, "+");
"*"      return newSymbol(symMUL, "*");
"/"      return newSymbol(symDIV, "/");
";"      return newSymbol(symSEMI, ";");
"{"      return newSymbol(symLBRACE, "{");
"}"      return newSymbol(symRBRACE, "}");
"."      return newSymbol(symPERIOD, ".");
">="     return newSymbol(symGEQ, ">=");
"<="     return newSymbol(symLEQ, "<=");
"=="     return newSymbol(symEQ, "==");
"!="     return newSymbol(symNEQ, "!=");
"while"  return newSymbol(symWHILE, "while");
"if"     return newSymbol(symIF, "if");
"else"   return newSymbol(symELSE, "else");
"print"  return newSymbol(symPRINT, "print");
<<EOF>>  return NULL;
[ \t\n]+ ; /*忽略空白*/
.        return newSymbol(symerror, yytext);
%%
int yywrap(void)
{
  return 1;
}
int main(int argc, char *argv[])
{
  char cmd[80]="TYPE ";
  printf("    輸入規格檔\"%s\"內容如下：\n",argv[1]);
  system(strcat(cmd, argv[1]));
  printf("    透過yylex()逐一取得下一個符記內容如下：\n");
  yyin = fopen(argv[1], "r");
  while (1)
  {
    struct symbolTag *token = yylex();
    if (token == NULL) break;
    printf("\t%s\n", symbolToString(token));
  }
  return 0;
}
