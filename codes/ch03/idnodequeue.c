/******************** idnodequeue.c *******************/
#include <stdio.h>
#include <stdlib.h>
struct idnodeTag
{
  char name[36];
  int sym;
  int attr;
  int level;
  struct idnodeTag *next;
} node, *head=NULL, *tail=NULL, *p;
int main()
{
  p = malloc(sizeof(node));   //建立"speed"節點
  strcpy(p->name, "speed");
  p->sym = 2;
  p->attr = 31;
  p->level = 1;
  p->next = NULL;
  head = p;                   //作為頭及尾節點
  tail = p;
  p = malloc(sizeof(node));   //建立"time"節點
  strcpy(p->name, "time");
  p->sym = 2;
  p->attr = 31;
  p->level = 1;
  p->next = NULL;
  tail->next = p;             //加入尾端
  tail = p;
  p = malloc(sizeof(node));   //建立"dist"節點
  strcpy(p->name, "dist");
  p->sym = 2;
  p->attr = 31;
  p->level = 0;
  p->next = NULL;
  tail->next = p;             //加入尾端
  tail = p;
  printf("head=0x%p  tail=0x%p\n", head, tail);
  p = head;
  while (p!=NULL)             //列印所有節點
  {
    printf(
      "name=\"%s\" sym=%d attr=%d level=%d next=0x%p\n",
      p->name, p->sym, p->attr, p->level, p->next);
    p = p->next;
  }
  return 0;
}
