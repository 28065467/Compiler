/*************** inputfile.c **************/
#include <stdio.h>
int main()
{
  FILE *f=fopen("randfile.txt", "r");
  int i, num;
  while (fscanf(f,"%d %d", &i,&num)!=EOF)
  {
    printf("i=%d  num=%d\n", i,num);
  }
  fclose(f);
  return 0;
}
