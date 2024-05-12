/************************** cal.l ***********************/
%{
   #include <stdlib.h>
   #include "cal.h"
   #include "cal.tab.h"
   void yyerror(char *);
%}
%%
[a-z]  {
         yylval.varIndex = *yytext - 'a';         /*�ܼ�*/
         return VAR;
       }
[0-9]+ {
         yylval.numValue = atoi(yytext);          /*�`��*/
         return NUM;
       }
[-+()=/*;]      { return *yytext; }             /*��r��*/
"print"         return PRINT;
[ \t\n]+        ;                                 /*�ť�*/
.               yyerror("Unknown character");     /*���~*/
%%
int yywrap(void)
{
  return 1;                                 /*�ɧ��ɵ���*/
}