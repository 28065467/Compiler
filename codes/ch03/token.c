/******************** token.c ******************/
#include <stdio.h>
#include <string.h>
int main(int argc, char *argv[])
{
  char buf[256], *token;
  printf("請逐次輸入字串，直接按Ctrl-Z鍵結束\n");
  while (fgets(buf,sizeof(buf),stdin)!=NULL)
  {
    token=strtok(buf, " \t\n");
    while (token != NULL)
    {
      puts(token);
      token=strtok(NULL, " \t\n");
    }
  }
  return 0;
}
