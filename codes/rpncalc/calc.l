%{
   /*********************** calc.l **********************/
   #include <stdlib.h>
   #include "calc.tab.h"                     /*bison所建*/
%}
%%
[ \t\r]+ {
            /*空白字元,請注意\n非空白字元,它是一列的結束*/
    }
[0-9]+ {
    sscanf(yytext, "%lf", &yylval);
    return NUM;
    }
[0-9]+"."[0-9]* {
    sscanf(yytext, "%lf", &yylval);
    return NUM;
    }
[0-9]*"."[0-9]+ {
    sscanf(yytext, "%lf", &yylval);
    return NUM;
    }
[-+*/^n\n] {return *yytext; }         /*傳回單一字元符記*/
.   { yyerror("Unknown character"); }         /*其他字元*/
%%
int yywrap(void)
{
  return 1;                                 /*檔尾時結束*/
}
