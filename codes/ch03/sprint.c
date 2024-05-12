/************ sprint.c ***********/
#include <stdio.h>
int main(void)
{
  char str[80];
  int i=98;
  double d=7.65;
  sprintf(str, "%d %lf", i, d);
  printf("str=\"%s\"\n", str);
  return 0;
}
