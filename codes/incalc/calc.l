%{
   /*********************** calc.l **********************/
   #include <stdlib.h>
   #include "calc.tab.h"                     /*bison�ҫ�*/
%}
%%
[ \t\r]+ {
            /*�ťզr��,�Ъ`�N\n�D�ťզr��,���O�@�C������*/
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
[-+*/^n()\n] {return *yytext; }       /*�Ǧ^��@�r���ŰO*/
.   { yyerror("Unknown character"); }         /*��L�r��*/
%%
int yywrap(void)
{
  return 1;                                 /*�ɧ��ɵ���*/
}