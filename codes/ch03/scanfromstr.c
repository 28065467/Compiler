/*************** scanfromstr.c ************/
#include <stdio.h>
int main()
{
  int a, b, sum;
  char buffer[80];
  printf("請輸入一個字串(1234 567): ");
  fgets(buffer, sizeof(buffer), stdin);
  sscanf(buffer, "%4d%4d", &a, &b);
  sum = a + b;
  printf("a=%d  b=%d  sum=%d\n", a,b,sum);
  return 0;
}
