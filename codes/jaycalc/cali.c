/*********************** cali.c *********************/
#include <stdio.h>
#include "cal.h"
#include "cal.tab.h"
int debug;
int sym[26];
int ex(struct nodeTag *p)
{
  if (p==NULL) return 0;
  switch(p->type)
  {
    case enumNUM: return p->num.num;
    case enumVAR: return sym[p->var.var];
    case enumOPR:
      switch(p->opr.oper)
      {
        case PRINT:
          printf("%d\n", ex(p->opr.op[0]));
          return 0;
        case ';':
          ex(p->opr.op[0]);
          return ex(p->opr.op[1]);
        case '=':
          return sym[p->opr.op[0]->var.var] =
                 ex(p->opr.op[1]);
        case UMINUS:
          return -ex(p->opr.op[0]);
        case '+':
          return ex(p->opr.op[0]) + ex(p->opr.op[1]);
        case '-':
          return ex(p->opr.op[0]) - ex(p->opr.op[1]);
        case '*':
          return ex(p->opr.op[0]) * ex(p->opr.op[1]);
        case '/':
          return ex(p->opr.op[0]) / ex(p->opr.op[1]);
      }
  }
  return 0;
}
int main(int argc, char *argv[])
{
  extern FILE *yyin;
  char cmd[80]="TYPE ";
  printf("  file \"%s\" contents :\n", argv[1]);
  strcat(cmd, argv[1]);
  system(cmd);
  if (argc==3) debug=1;
  yyin=fopen(argv[1], "r");
  printf("  after yyparse(), print as followings:\n");
  yyparse();
  return 0;
}
