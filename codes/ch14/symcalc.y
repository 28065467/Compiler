/*********************** symcalc.y **********************/
%{
   #include <stdio.h>
   #include <ctype.h>
   int yylex (void);
   void yyerror (char const *);
   struct nodeTag
   {
     int  sym;                 /*符記VAR整數編號*/
     char name[36];                /*符記VAR名稱*/
     union
     {
       double   var;             /*符記VAR語意值*/
     } value;
     struct nodeTag *next;          /*下一個節點*/
   };
   char *nodeToString(struct nodeTag *p);
   char *nodestackToString();
   struct nodeTag *putsym(char const *, int);
   struct nodeTag *getsym(char const *);
%}
%union {
  double val;
  struct nodeTag *nodeptr;
  }
%token <val>     NUM
%token <nodeptr> VAR
%type  <val>     expr
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
  : '\n'          { printf("%s",nodestackToString()); }
  | expr '\n'     { printf ("\t%lf\n", $1); }
  | error '\n'    { yyerrok; }
  ;
expr
  : NUM               { $$ = $1; }
  | VAR               { $$ = $1->value.var; }
  | VAR '=' expr      { $$ = $3; $1->value.var = $3; }
  | expr '+' expr     { $$ = $1 + $3; }
  | expr '-' expr     { $$ = $1 - $3; }
  | expr '*' expr     { $$ = $1 * $3; }
  | expr '/' expr     { $$ = $1 / $3; }
  |'-' expr %prec NEG { $$ = -$2; }
  | expr '^' expr     { $$ = pow ($1, $3); }
  |'(' expr ')'       { $$ = $2; }
  ;
%%
struct nodeTag *nodestackTop=NULL;
char *nodeToString(struct nodeTag *p)
{
  static char node[256];
  sprintf(node,
    "p=0x%p sym=%d name=%s var=%lf\n",
    p, p->sym, p->name, p->value.var);
  return node;
}
char *nodestackToString()
{
  struct nodeTag *p=nodestackTop;
  static char str[1024], node[256];
  sprintf(node,
    "    ===== nodestackTop=0x%p nodesize=%d =====\n",
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
struct nodeTag *putsym(char const *name, int sym)
{
  struct nodeTag *p=malloc(sizeof(struct nodeTag));
  strcpy(p->name, name);
  p->sym = sym;
  p->value.var = 0;
  p->next = nodestackTop;
  nodestackTop = p;
  printf("putsym() %s", nodeToString(p));   /*test only*/
  return p;
}
struct nodeTag *getsym(char const *name)
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
int yylex (void)
{
  int ch;
  while ((ch=getchar())==' ' || ch=='\t') ;   /*忽略空白*/
  if (ch==EOF) return 0;
  if (ch=='.' || isdigit(ch))       /*小數點或阿拉伯數字*/
  {
    ungetc(ch, stdin);                /*ch擺回輸入資料流*/
    scanf("%lf", &yylval.val);  /*再從資料流以浮點數讀回*/
    return NUM;                        /*傳回NUM整數編號*/
  }
  if (isalpha(ch))                              /*識別字*/
  {
    struct nodeTag *s;                       /*結點指標s*/
    static char symbuf[36];                     /*緩衝器*/
    int i=0;
    do
    {
      symbuf[i++] = ch;
      ch = getchar();
    } while (isalnum(ch));            /*識別字存於symbuf*/
    ungetc(ch, stdin);                /*ch擺回輸入資料流*/
    symbuf[i] = '\0';                     /*字串結束符號*/
    s = getsym(symbuf);            /*從堆疊取得識別字至s*/
    if (s == 0)                   /*檢查識別字是否在堆疊*/
      s = putsym(symbuf, VAR);    /*識別字不在堆疊時疊入*/
    yylval.nodeptr = s;                     /*設定語意值*/
    return s->sym;              /*傳回識別字符記整數編號*/
  }
  return ch;
}
void yyerror (char const *s)
{
  printf ("%s\n", s);
}
int main(int argc, char *argv[])
{
  printf("    輸入資料檔\"symcalc.txt\"內容如下：\n");
  system("TYPE symcalc.txt");
  printf("    透過bison的yyparse()逐一剖析結果如下：\n");
  yyparse();
  return 0;
}
