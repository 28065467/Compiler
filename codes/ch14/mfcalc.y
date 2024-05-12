/*********************** mfcalc.y ***********************/
%{
   #include <stdio.h>
   #include <ctype.h>
   #include <math.h>
   int yylex (void);
   void yyerror (char const *);
   typedef double (*funtype) (double);    /*�w�q�禡���A*/
   struct nodeTag
   {
     int  sym;                         /*�ŰOVAR��ƽs��*/
     char name[36];                           /*�ŰO�W��*/
     union
     {
       double   var;                       /*�ŰOVAR����*/
       funtype funptr;                     /*�ŰOFUN����*/
     } value;
     struct nodeTag *next; /*�s���ܤU�@��VAR�ŰO�`�I����*/
   };
   struct nodeTag *nodestackTop;              /*���|����*/
   struct nodeTag *putsym(char const *, int);     /*�[�J*/
   struct nodeTag *getsym(char const *);          /*���o*/
   char * nodeToString(struct nodeTag *p);    /*��ܸ`�I*/
   char * nodestackToString();                /*��ܰ��|*/
%}
%union {
  double val;
  struct nodeTag *nodeptr;
  }
%token <val>     NUM
%token <nodeptr> VAR FUN
%type <val>      expr
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
  | expr '\n'     { printf("\t%lf\n", $1); }
  | error '\n'    { yyerrok; }
  ;
expr
  : NUM               { $$ = $1; }
  | VAR               { $$ = $1->value.var; }
  | VAR'=' expr       { $$ = $3; $1->value.var = $3; }
  | FUN'(' expr')'    { $$ = (*($1->value.funptr))($3); }
  | expr'+' expr      { $$ = $1 + $3; }
  | expr'-' expr      { $$ = $1 - $3; }
  | expr'*' expr      { $$ = $1 * $3; }
  | expr'/' expr      { $$ = $1 / $3; }
  |'-' expr %prec NEG { $$ = -$2; }
  | expr'^' expr      { $$ = pow ($1, $3); }
  |'(' expr')'        { $$ = $2; }
  ;
%%
char *nodeToString(struct nodeTag *p)  /*���p�����ѧO�r*/
{
  static char node[256];
  sprintf(node,
    "p=0x%p sym=%d name=%s var=%lf\n",
    p, p->sym, p->name, p->value.var);
  return node;
}
char *nodestackToString()               /*����ѧO�r���|*/
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
struct nodeTag *putsym(char const *name, int sym) /*�[�J*/
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
struct nodeTag *getsym(char const *name)  /*���oname����*/
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
  while ((ch=getchar())==' ' || ch=='\t') ;   /*�����ť�*/
  if (ch==EOF) return 0;
  if (ch=='.' || isdigit(ch))       /*�p���I�Ϊ��ԧB�Ʀr*/
  {
    ungetc(ch, stdin);                /*ch�\�^��J��Ƭy*/
    scanf("%lf", &yylval.val);  /*�A�q��Ƭy�H�B�I��Ū�^*/
    return NUM;                        /*�Ǧ^NUM��ƽs��*/
  }
  if (isalpha(ch))                              /*�ѧO�r*/
  {
    struct nodeTag *s;                       /*���I����s*/
    static char symbuf[36];                     /*�w�ľ�*/
    int i=0;
    do
    {
      symbuf[i++] = ch;
      ch = getchar();
    } while (isalnum(ch));            /*�ѧO�r�s��symbuf*/
    ungetc(ch, stdin);                /*ch�\�^��J��Ƭy*/
    symbuf[i] = '\0';                     /*�r�굲���Ÿ�*/
    s = getsym(symbuf);            /*�q���|���o�ѧO�r��s*/
    if (s == 0)                   /*�ˬd�ѧO�r�O�_�b���|*/
      s = putsym(symbuf, VAR);    /*�ѧO�r���b���|���|�J*/
    yylval.nodeptr = s;                     /*�]�w�y�N��*/
    return s->sym;              /*�Ǧ^�ѧO�r�ŰO��ƽs��*/
  }
  return ch;
}
void yyerror (char const *s)
{
  printf("%s\n", s);
}
struct funTag
{
  char const *fname;
  double (*ftype) (double);
} funs[] = { "sin",  sin,
             "cos",  cos,
             "atan", atan,
             "ln",   log,
             "exp",  exp,
             "sqrt", sqrt,
           } ;
void stackfuns(void)
{
  int i;
  struct nodeTag *p;
  for (i=0; i<sizeof(funs)/sizeof(struct funTag); i++)
  {
    p = putsym(funs[i].fname, FUN);
    p->value.funptr = funs[i].ftype;
  }
}
int main(int argc, char *argv[])
{
  printf("    ��J�����\"mfcalc.txt\"���e�p�U�G\n");
  system("TYPE mfcalc.txt");
  printf("    �z�Lbison��yyparse()�v�@��R���G�p�U�G\n");
  stackfuns();
  yyparse();
  return 0;
}