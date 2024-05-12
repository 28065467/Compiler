/*************** symtest.c *************/
#include <stdio.h>
#include "sym.h"
#include "symname.h"
int main()
{
  int i;
  symnameinit();
  for (i=0; i<5; i++)
    printf("sym%s = %d\n", names[i],i);
  return 0;
}
