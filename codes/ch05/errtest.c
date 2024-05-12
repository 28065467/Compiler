/******************** errtest.c *****************/
#include <stdio.h>
#include "err.h"
int main()
{
  int i;
  for (i=0; i<5; i++)
    printf("errmsgs[%d]=\"%s\"\n", i, errmsgs[i]);
  return 0;
}
