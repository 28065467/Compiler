%{
   /********************* symcalc.l *********************/
   #include <stdlib.h>
   #include "calc.h"                    /*宣告識別字結構*/
   #include "calc.tab.h"                     /*bison所建*/
   void yyerror(char *);
   struct nodeTag *nodestackTop=NULL;     /*符記堆疊頂端*/
   char *nodeToString(struct nodeTag *p);    /*p節點內容*/
   char *nodestackToString();
   struct nodeTag *putsym(char const *name, int sym);
   struct nodeTag *getsym(char const *name);
%}
DIGIT [0-9]
ID [A-Za-z]([A-Za-z]|[0-9])*
%%
[ \t\r]+ {
            /*空白字元,請注意\n非空白字元,它是一列的結束*/
    }
{DIGIT}+ {                                        /*整數*/
    yylval.val = atof(yytext);
    return NUM;
    }
{DIGIT}+"."{DIGIT}* {                           /*浮點數*/
    yylval.val = atof(yytext);
    return NUM;
    }
{DIGIT}+[eE]["+""-"]?{DIGIT}* {            /*e格式浮點數*/
    yylval.val = atof(yytext);
    return NUM;
    }
{DIGIT}+"."{DIGIT}*[eE]["+""-"]?{DIGIT}* { /*e格式浮點數*/
    yylval.val = atof(yytext);
    return NUM;
    }
{ID} {                                          /*識別字*/
    struct nodeTag *p=getsym(yytext);             /*取得*/
    if (p==NULL) p=putsym(yytext,VAR);    /*找不到時加入*/
    yylval.nodeptr = p;                     /*傳回該指標*/
    return VAR;                       /*傳回符記整數編號*/
    }
[-+*/();=\n]  { return *yytext; }     /*傳回單一字元符記*/
.   { yyerror("Unknown character"); }         /*其他字元*/
%%
int yywrap(void)
{
  return 1;                                 /*檔尾時結束*/
}
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
