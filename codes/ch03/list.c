/************************ list.c ***********************/
#include <stdio.h>
#include <stdlib.h>
struct wordTag
{
  char word[36];
  struct wordTag *next;
};
struct wordTag *head, *tail;
void insertNode(char *word)
{
  struct wordTag *p, *p0, *p2;
  p = malloc(sizeof(struct wordTag));
  strcpy(p->word, word);
  p0 = head;
  p2 = p0->next;
  while (1)
  {
    if (strcmp(p->word, p2->word)<0)
    {
      p->next = p2;
      p0->next = p;
      break;
    }
    else
    {
      p0 = p2;
      p2 = p2->next;
    }
  }
}
void listprint()
{
  struct wordTag *p=head->next;
  while (p!=NULL)
  {
    if (p==tail) break;
    printf("p=0x%p next=0x%p word=\"%s\"\n",
           p, p->next, p->word);
    p = p->next;
  }
}
int main()
{
  char word[36];
  tail = malloc(sizeof(struct wordTag));
  strcpy(tail->word, "}");               /*比英文字母大*/
  tail->next = NULL;
  head=malloc(sizeof(struct wordTag));
  strcpy(head->word, "!");               /*比英文字母小*/
  head->next = tail;
  printf("請逐次輸入字串插入連結串列，Ctrl-Z結束\n");
  while (fgets(word,sizeof(word),stdin)!=NULL)
  {
    word[strlen(word)-1]='\0';             /*清除\n為\0*/
    insertNode(word);
    printf("%s\n", word);
  }
  printf("逐次從連結串列前端取出後輸出\n");
  listprint();
  return 0;
}
