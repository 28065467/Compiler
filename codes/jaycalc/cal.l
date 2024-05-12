/************************** cal.l ***********************/
%{
   #include <stdlib.h>
   #include "cal.h"
   #include "cal.tab.h"
   void yyerror(char *);
%}
%%
[a-z]  {
         yylval.varIndex = *yytext - 'a';         /*變數*/
         return VAR;
       }
[0-9]+ {
         yylval.numValue = atoi(yytext);          /*常數*/
         return NUM;
       }
[-+()=/*;]      { return *yytext; }             /*單字元*/
"print"         return PRINT;
[ \t\n]+        ;                                 /*空白*/
.               yyerror("Unknown character");     /*錯誤*/
%%
int yywrap(void)
{
  return 1;                                 /*檔尾時結束*/
}
