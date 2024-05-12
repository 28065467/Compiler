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
   }                                            /*�ѧO�r*/
\n { lines++; }                                 /*�C����*/
.  ;                                          /*��L�r��*/
%%
int yywrap(void)
{
  return 1;
}
int main(int argc, char *argv[])
{
  char cmd[80]="TYPE ";
  printf("    ��J�W����\"%s\"���e�p�U�G\n",argv[1]);
  system(strcat(cmd, argv[1]));
  printf("\t�ѧO�r����\t�ѧO�r�W��\n");
  yyin = fopen(argv[1], "r");
  yylex();
  printf("\n\t�`�@�C��=%d\t�ѧO�r��=%d\n", lines, ids);
  return 0;
}