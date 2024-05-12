/*************** getfile.c **************/
#include <stdio.h>
int main()
{
  FILE *f=fopen("randfile.txt", "r");
  char buf[80];
  while (fgets(buf,sizeof(buf),f)!=NULL)
  {
    printf("%s", buf);
  }
  fclose(f);
  return 0;
}
