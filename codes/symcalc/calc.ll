%{
   /********************* symcalc.l *********************/
   #include <stdlib.h>
   #include "calc.h"                    /*�ŧi�ѧO�r���c*/
   #include "calc.tab.h"                     /*bison�ҫ�*/
   void yyerror(char *);
   struct nodeTag *nodestackTop=NULL;     /*�ŰO���|����*/
   char *nodeToString(struct nodeTag *p);    /*p�`�I���e*/
   char *nodestackToString();
   struct nodeTag *putsym(char const *name, int sym);
   struct nodeTag *getsym(char const *name);
%}
DIGIT [0-9]
ID [A-Za-z]([A-Za-z]|[0-9])*
%%
[ \t\r]+ {
            /*�ťզr��,�Ъ`�N\n�D�ťզr��,���O�@�C������*/
    }
{DIGIT}+ {                                        /*���*/
    yylval.val = atof(yytext);
    return NUM;
    }
{DIGIT}+"."{DIGIT}* {                           /*�B�I��*/
    yylval.val = atof(yytext);
    return NUM;
    }
{DIGIT}+[eE]["+""-"]?{DIGIT}* {            /*e�榡�B�I��*/
    yylval.val = atof(yytext);
    return NUM;
    }
{DIGIT}+"."{DIGIT}*[eE]["+""-"]?{DIGIT}* { /*e�榡�B�I��*/
    yylval.val = atof(yytext);
    return NUM;
    }
{ID} {                                          /*�ѧO�r*/
    struct nodeTag *p=getsym(yytext);             /*���o*/
    if (p==NULL) p=putsym(yytext,VAR);    /*�䤣��ɥ[�J*/
    yylval.nodeptr = p;                     /*�Ǧ^�ӫ���*/
    return VAR;                       /*�Ǧ^�ŰO��ƽs��*/
    }
[-+*/();=\n]  { return *yytext; }     /*�Ǧ^��@�r���ŰO*/
.   { yyerror("Unknown character"); }         /*��L�r��*/
%%
int yywrap(void)
{
  return 1;                                 /*�ɧ��ɵ���*/
}
char *nodeToString(struct nodeTag *p)  /*���p�����ѧO�r*/
{
  static char node[256];
  sprintf(node,
    "p=0x%p sym=%d name=%s var=%lf next=0x%p\n",
    p, p->sym, p->name, p->value.var, p->next);
  return node;
}
char *nodestackToString()               /*����ѧO�r���|*/
{
  struct nodeTag *p=nodestackTop;
  static char str[1024], node[256];
  sprintf(node,
    "\n    ===== nodestackTop=0x%p nodesize=%d =====\n",
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