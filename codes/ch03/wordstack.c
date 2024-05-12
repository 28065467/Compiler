/******************* wordstack.c ***************/
#include <stdio.h>
#include <stdlib.h>
#define WORDMAX 512
char words[WORDMAX][36];
int top=0;
void push(char word[])
{
  strcpy(words[top], word);
  top++;
}
char * pop()
{
  static char word[36];
  top--;
  strcpy(word, words[top]);
  return word;
}
int isEmpty()
{
  if (top==0)
    return 1;
  else
    return 0;
}
int main()
{
  char word[36];
  printf("請逐次輸入字串疊入堆疊，Ctrl-Z結束\n");
  while (fgets(word,sizeof(word),stdin)!=NULL)
  {
    push(word);
  }
  printf("逐次從堆疊疊出後輸出\n");
  while (! isEmpty())
  {
    printf("%s", pop());
  }
  return 0;
}
