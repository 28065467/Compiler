/*************** danger.c ****************/
#include <stdio.h>
int main()
{
  char ok[3]="OK";
  char s[5];
  printf("請輸入一個字串s: ");
  gets(s);
  printf("ok=\"%s\"  s=\"%s\"\n", ok,s);
  return 0;
}
