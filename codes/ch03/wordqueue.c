/******************* wordqueue.c ***************/
#include <stdio.h>
#include <stdlib.h>
#define WORDMAX 512
char words[WORDMAX][36];
int head=-1, tail=-1;
int isEmpty()
{
  if (head==-1 && tail==-1)
    return 1;
  else
    return 0;
}
void queuein(char word[])
{
  if (isEmpty())
  {
    strcpy(words[++tail], word);
    head = tail;
  }
  else
  {
    strcpy(words[++tail], word);
  }
}
char * queueout()
{
  if (isEmpty() || head>tail)
    return NULL;
  else
    return words[head++];
}
int main()
{
  char word[36], *wp;
  printf("請逐次輸入字串佇入佇列，Ctrl-Z結束\n");
  while (fgets(word,sizeof(word),stdin)!=NULL)
  {
    queuein(word);
  }
  printf("逐次從佇列佇出後輸出\n");
  while ((wp=queueout())!=NULL)
  {
    printf("%s", wp);
  }
  return 0;
}
