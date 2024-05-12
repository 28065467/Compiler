/********************* stack.c *******************/
#include <stdio.h>
#include <stdlib.h>
struct wordTag
{
  char word[36];
  struct wordTag *next;
};
struct wordTag *top=NULL;
int isEmpty()
{
  if (top==NULL)
    return 1;
  else
    return 0;
}
void push(char *word)
{
  struct wordTag *p;
  p = malloc(sizeof(struct wordTag));
  strcpy(p->word, word);
  p->next = top;
  top = p;
}
struct wordTag * pop()
{
  struct wordTag *p;
  if (isEmpty())
    return NULL;
  p = top;
  top = top->next;
  return p;
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
