/************************* calr.y ***********************/
%{
    #include <stdio.h>
    #define YYSTYPE double
    int yylex(void);
    void yyerror (char const *);
    extern FILE *yyin;
%}
%token NUM
%%
input
  : input line
  | /*empty*/
  ;
line
  : '\n'
  | expr '\n' { printf ("\t%.10g\n", $1); }
  ;
expr
  : NUM           { $$ = $1; }
  | expr expr '+' { $$ = $1 + $2; }
  | expr expr '-' { $$ = $1 - $2; }
;
%%
void yyerror(char const *s)
{
  fprintf (stderr, "%s\n", s);
}
int main (int argc, char *argv[])
{
  char cmd[80]="TYPE ";
  yyin = fopen(argv[1], "r");
  printf("    輸入資料檔\"%s\"內容如下：\n",argv[1]);
  strcat(cmd, argv[1]);
  system(cmd);
  printf("    透過bison的yyparse()逐一剖析結果如下：\n");
  yyparse();
  return 0;
}
