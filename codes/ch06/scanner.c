/******************* scanner.c ****************/
#include <stdio.h>
#include "scanner.h"
int main(int argc, char *argv[])
{
  struct symbolTag *p;
  FILE *f=fopen(argv[1], "r");
  scanner(f);
  advance();
  while (1)
  {
    p=nextToken();
    if (p==NULL) break;
    printf("\t%s\n", symbolToString(p));
  }
}
