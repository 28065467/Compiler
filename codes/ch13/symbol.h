/************************* symbol.h *********************/
#include <stdio.h>
#include <stdlib.h>
struct symbolTag
{
  int sym;
  char value[36];
};
struct symbolTag *newSymbol(int sym, char *value)
{
  struct symbolTag *p=malloc(sizeof(struct symbolTag));
  p->sym = sym;
  strcpy(p->value, value);
  return p;
}
char *symbolToString(struct symbolTag *p)
{
  static char buf[256];
  sprintf(buf, "sym=%d\tvalue=\"%-s\"", p->sym,p->value);
  return buf;
}
