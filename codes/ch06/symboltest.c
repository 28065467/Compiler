/******************* symboltest.c *******************/
#include <stdio.h>
#include <stdlib.h>
#include "sym.h"
#include "symbol.h"
int main()
{
  char *s="123";  
  symbol.sym = 7;
  symbol.left = 2;
  symbol.right = 13;
  strcpy(symbol.value,"weight");
  s=symbolToString(&symbol);
  printf("symbolToString()=%s\n", s);
  return 0;
}
