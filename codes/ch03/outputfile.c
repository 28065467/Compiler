/*********** outputfile.c ************/
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
  FILE *f = fopen("randfile.txt", "w");
  int i;
  for (i=0; i<5; i++)
    fprintf(f, "%d %9d\n", i, rand());
  fclose(f);
  system("TYPE randfile.txt");
  return 0;
}
