/*************************** symbol.h *********************/
#include <stdio.h>
#include <stdlib.h>
struct symbolTag
{
  int sym;
  int left;
  int right;
  char value[36];
};
struct symbolTag *newSymbol(int sym, int left,
                            int right, char *value)
{
  struct symbolTag *p=malloc(sizeof(struct symbolTag));
  p->sym = sym;
  p->left = left;
  p->right = right;
  strcpy(p->value, value);
  return p;
}
char *symbolToString(struct symbolTag *p)
{
  static char symbol_str[256];
  sprintf(symbol_str,
    "sym=%d left=%d right=%d value=\"%-s\"",
    p->sym, p->left, p->right, p->value);
  return symbol_str;
}
