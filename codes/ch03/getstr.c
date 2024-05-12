/*************** getstr.c ************/
#include <stdio.h>
int main()
{
  char s[80];
  printf("請輸入一個字串: ");
  gets(s);
  printf("您剛輸入的值= %s \n", s);
  return 0;
}
