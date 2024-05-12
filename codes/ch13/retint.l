/********************* retint.l ********************/
%{
   #include <stdlib.h>
   #include "sym.h"
   #include "symname.h"
%}
%%
"while"   return symWHILE;
"if"      return symIF;
"else"    return symELSE;
"print"   return symPRINT;
[a-z]     return symIDENTIFIER;
[0-9]+    return symNUMBER;
"-"       return symMINUS;
"("       return symLPAREN;
")"       return symRPAREN;
"<"       return symLESS;
">"       return symGREATER;
"="       return symEQUAL;
"+"       return symPLUS;
"*"       return symMUL;
"/"       return symDIV;
";"       return symSEMI;
"{"       return symLBRACE;
"}"       return symRBRACE;
"."       return symPERIOD;
">="      return symGEQ;
"<="      return symLEQ;
"=="      return symEQ;
"!="      return symNEQ;
<<EOF>>   return -1;
[ \t\n]+  ;                             /*空白*/
.         printf("Unknown character");  /*錯誤*/
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
  yyin = fopen(argv[1], "r");
  symnameinit();
  while (1)
  {
    int token = yylex();
    if (token == -1) break;
    printf("\ttoken=%d  \t%s\n",token,names[token]);
  }
  return 0;
}
