/**************** 中置記法計算機 (incalc.y) *************/
%{
    #include <stdio.h>
    #include <ctype.h>
    #include <math.h>
    #define YYSTYPE double
    int yylex (void);
    void yyerror (char const *);
%}
%token NUM
%left '-' '+'
%left '*' '/'
%left NEG         /*negation--unary minus*/
%right '^'        /*exponentiation*/
%%
input
  : input line
  | /*empty*/
  ;
line
  : '\n'
  | expr '\n'          { printf ("\t%.10g\n", $1); }
  ;
expr
  : NUM                { $$ = $1; }
  | expr '+' expr      { $$ = $1 + $3; }
  | expr '-' expr      { $$ = $1 - $3; }
  | expr '*' expr      { $$ = $1 * $3; }
  | expr '/' expr      { $$ = $1 / $3; }
  | '-' expr %prec NEG { $$ = -$2; }
  | expr '^' expr      { $$ = pow ($1, $3); }
  | '(' expr ')'       { $$ = $2; }
  ;
%%
void yyerror(char const *s)
{
  fprintf (stderr, "%s\n", s);
}
int yylex (void)
{
  int ch;
  while ((ch=getchar())==' ' || ch=='\t')
    ;                                         /*忽略空白*/
  if (ch=='.' || isdigit(ch))       /*小數點或阿拉伯數字*/
  {
    ungetc(ch, stdin);                /*ch擺回輸入資料流*/
    scanf("%lf", &yylval);  /*再從輸入資料流以浮點數讀回*/
    return NUM;                        /*傳回NUM整數編號*/
  }
  if (ch==EOF) return 0;                   /*檔尾傳回0值*/
  return ch;            /*傳回非小數點及非阿拉伯數字字元*/
}
int main (int argc, char *argv[])
{
  printf("    輸入資料檔\"incalc.txt\"內容如下：\n");
  system("TYPE incalc.txt");
  printf("    透過bison的yyparse()逐一剖析結果如下：\n");
  yyparse();
  return 0;
}
