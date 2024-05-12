/******************* scanner.c ****************/
#include <stdio.h>
#include "scanner.h"
int main(int argc, char *argv[])
{
  struct symbolTag *token;
  FILE *f=fopen(argv[1], "r");
  scanner(f);
  while ((token=nextToken())!=NULL)
  {
    printf("\t%s\n", symbolToString(token));
  }
}
