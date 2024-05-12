/******* Location tracking calculator. (ltcalc.y) *******/
%{
   #define YYSTYPE int
   #include <stdio.h>
   #include <math.h>
   int yylex (void);
   void yyerror (char const *);
%}
%token NUM
%left '-' '+'
%left '*' '/'
%left NEG
%right '^'
%%
input
  : input line
  | /*empty*/
  ;
line
  : '\n'
  | expr '\n'     { printf ("%d\n", $1); }
  ;
expr
  : NUM           { $$ = $1; }
  | expr '+' expr { $$ = $1 + $3; }
  | expr '-' expr { $$ = $1 - $3; }
  | expr '*' expr { $$ = $1 * $3; }
  | expr '/' expr
      {
        if ($3)
          $$ = $1 / $3;
        else
        {
          $$ = 1;
          fprintf (stderr,
            "%d.%d-%d.%d: division by zero ",
            @3.first_line, @3.first_column,
            @3.last_line, @3.last_column);
        }
      }
  | '-' expr %prec NEG { $$ = -$2; }
  | expr '^' expr      { $$ = pow ($1, $3); }
  | '(' expr ')'       { $$ = $2; }
%%
void yyerror(char const *s)
{
  fprintf (stderr, "%s\n", s);
}
#include <ctype.h>
int yylex (void)
{
  int ch;
  while ((ch=getchar())==' ' || ch=='\t')
    ++yylloc.last_column;
  yylloc.first_line = yylloc.last_line;
  yylloc.first_column = yylloc.last_column;
  if (isdigit(ch))
  {
    yylval = ch - '0';
    ++yylloc.last_column;
    while (isdigit(ch=getchar()))
    {
      ++yylloc.last_column;
      yylval = yylval * 10 + ch - '0';
    }
    ungetc(ch, stdin);
    return NUM;
  }
  if (ch == EOF) return 0;
  if (ch == '\n')
  {
    ++yylloc.last_line;
    yylloc.last_column = 0;
  }
  else
    ++yylloc.last_column;
  return ch;
}
int main (int argc, char *argv[])
{
  printf("    輸入資料檔\"ltcalc.txt\"內容如下：\n");
  system("TYPE ltcalc.txt");
  printf("    透過bison的yyparse()逐一剖析結果如下：\n");
  yylloc.first_line = yylloc.last_line = 1;
  yylloc.first_column = yylloc.last_column = 0;
  return yyparse();
}
