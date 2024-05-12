/****************** gets.c **************/
#include <stdio.h>
int main(void)
{
  char buffer[100];
  printf("請輸入一字串: ");
  fgets(buffer, sizeof(buffer), stdin);
  printf("您剛輸入的字串= ");
  puts(buffer);
  return 0;
}
