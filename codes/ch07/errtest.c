/***************** errtest.c **************/
#include <stdio.h>
#include "err.h"
int main()
{
  int i;

  for (i=0; i<ERRMAX; i++)
  {
    printf("i=%d errmsgs[%d]=\"%s\"\n",
           i, i, errmsgs[i]);
  }

  return 0;
}
