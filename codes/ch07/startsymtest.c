/******************** startsymtest.c *******************/
#include <stdio.h>
#include "symname.h"
#include "startsym.h"
int main()
{
  int i;
  symnameinit();
  startsyminit();
  for (i=0; i<symSYMMAX; i++)
  {
    if (statement[i] != 0)
      printf("statement[%s]=%d\n",names[i],statement[i]);
  }
  return 0;
}
