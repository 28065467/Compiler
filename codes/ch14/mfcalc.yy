/*********************** mfcalc.y ***********************/
%{
   #include <stdio.h>
   #include <math.h>
   #include "mfcalc.h"
   int yylex (void);
   void yyerror (char const *);
%}
%union {
  double val;
  struct nodeTag *nodeptr;
  }
%token <val> NUM
%token <nodeptr> VAR FUN
%type <val> expr
%right '='
%left '-' '+'
%left '*' '/'
%left NEG
%right '^'
%%
input
  : /*empty*/
  | input line
  ;
line
  : '\n'
  | expr '\n'   { printf ("\t%.10g\n", $1); }
  | error '\n' { yyerrok; }
  ;
expr
  : NUM { $$ = $1; }
  | VAR { $$ = $1->value.var; }
  | VAR'=' expr { $$ = $3; $1->value.var = $3; }
  | FUN'(' expr')' { $$ = (*($1->value.funptr))($3); }
  | expr'+' expr { $$ = $1 + $3; }
  | expr'-' expr { $$ = $1 - $3; }
  | expr'*' expr { $$ = $1 * $3; }
  | expr'/' expr { $$ = $1 / $3; }
  |'-' expr %prec NEG { $$ = -$2; }
  | expr'^' expr { $$ = pow ($1, $3); }
  |'(' expr')' { $$ = $2; }
  ;
%%
char *nodeToString(struct nodeTag *p)  /*顯示p指標識別字*/
{
  static char node[256];
  sprintf(node,
    "p=0x%p sym=%d name=%s var=%lf next=0x%p\n",
    p, p->sym, p->name, p->value.var, p->next);
  return node;
}
char *nodestackToString()               /*顯示識別字堆疊*/
{
  struct nodeTag *p=nodestackTop;
  static char str[1024], node[256];
  sprintf(node,
    "\n@@@@nodestackTop=0x%p nodesize=%d@@@@\n",
    p, sizeof(struct nodeTag));
  strcpy(str, node);
  while (p != NULL)
  {
    sprintf(node,
      "p=0x%p sym=%d name=%s var=%lf next=0x%p\n",
      p, p->sym, p->name, p->value.var, p->next);
    strcat(str, node);
    p = p->next;
  }
  return str;
}
struct nodeTag *putsym(char const *name, int sym) /*加入*/
{
  struct nodeTag *p=malloc(sizeof(struct nodeTag));
  strcpy(p->name, name);
  p->sym = sym;
  p->value.var = 0;
  p->next = nodestackTop;
  nodestackTop = p;
  printf("putsym() %s", nodeToString(p));    /*test only*/
  return p;
}
struct nodeTag *getsym(char const *name)  /*取得name指標*/
{
  struct nodeTag *p=nodestackTop;
  while (p!=NULL)
  {
    if (strcmp(p->name,name) == 0)
    {
      printf("getsym() %s",nodeToString(p)); /*test only*/
      return p;
    }
    p=p->next;
  }
  return NULL;
}
#include <ctype.h>
int yylex (void)
{
  int ch;
  while ((ch=getchar())==' ' || ch=='\t') ;
  if (ch==EOF) return 0;
  if (ch=='.' || isdigit(ch))
  {
    ungetc(ch, stdin);
    scanf("%lf", &yylval.val);
    return NUM;
  }
  if (isalpha(ch))
  {
    struct nodeTag *s;
    static char symbuf[36];
    int i=0;
    do
    {
      symbuf[i++] = ch;
      ch = getchar();
    } while (isalnum(ch));
    ungetc(ch, stdin);
    symbuf[i] = '\0';
    s = getsym(symbuf);
    if (s == 0)
      s = putsym(symbuf, VAR);
    yylval.nodeptr = s;
    return s->sym;
  }
  return ch;
}

void yyerror (char const *s)
{
  printf ("%s\n", s);
}
struct funTag
{
  char const *fname;
  double (*funtype) (double);
} funs[] = { "sin",  sin,
             "cos",  cos,
             "atan", atan,
             "ln",   log,
             "exp",  exp,
             "sqrt", sqrt,
             0,      0
           } ;
void stackfuns(void)
{
  int i;
  struct nodeTag *p;
  for (i=0; funs[i].fname!=0; i++)
  {
    p = putsym(funs[i].fname, FUN);
    p->value.funptr = funs[i].funtype;
  }
}
int main(int argc, char *argv[])
{
  printf("    輸入資料檔\"mfcalc.txt\"內容如下：\n");
  system("TYPE mfcalc.txt");
  printf("    透過bison的yyparse()逐一剖析結果如下：\n");
  stackfuns ();
  return yyparse ();
}
