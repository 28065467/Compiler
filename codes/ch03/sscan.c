/******************** sscan.c ****************/
#include <stdio.h>
int main(void)
{
  char str[]="12 3.4";
  int i;
  double d;
  sscanf(str, "%d %lf", &i, &d);
  printf("整數i=%d 倍精確浮點數d=%lf\n", i,d);
  return 0;
}
