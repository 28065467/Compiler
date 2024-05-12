/************************ counts.l **********************/
DIGIT  [0-9]
LETTER [A-Za-z]
%{
   int ids=0, lines=0;
%}
%%
{LETTER}({LETTER}|{DIGIT})* {
     ids++;
     printf("\t%3d\t\t\"%s\"\n",yyleng,yytext);
   }                                            /*識別字*/
\n { lines++; }                                 /*列結束*/
.  ;                                          /*其他字元*/
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
  printf("\t識別字長度\t識別字名稱\n");
  yyin = fopen(argv[1], "r");
  yylex();
  printf("\n\t總共列數=%d\t識別字數=%d\n", lines, ids);
  return 0;
}
