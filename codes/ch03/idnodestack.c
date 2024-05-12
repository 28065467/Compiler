/*********************** idnodestack.c *******************/
#include <stdio.h>
#include <stdlib.h>
struct idnodeTag
{
  char name[36];
  int sym;
  int attr;
  int level;
  struct idnodeTag *next;
} *idnode, *idnodeStack;
int main()
{
  int i;
  idnode=malloc(sizeof(struct idnodeTag));  //建立speed結構
  strcpy(idnode->name, "speed");
  idnode->sym = 2;
  idnode->attr = 31;
  idnode->level = 1;
  idnode->next = NULL;
  idnodeStack = idnode;                      //疊入堆疊頂端
  idnode = malloc(sizeof(struct idnodeTag)); //建立time結構
  strcpy(idnode->name, "time");
  idnode->sym = 2;
  idnode->attr = 31;
  idnode->level = 1;
  idnode->next = idnodeStack;
  idnodeStack = idnode;
  idnode = malloc(sizeof(struct idnodeTag)); //建立dist結構
  strcpy(idnode->name, "dist");
  idnode->sym = 2;
  idnode->attr = 31;
  idnode->level = 0;
  idnode->next = idnodeStack;
  idnodeStack = idnode;                      //疊入堆疊頂端
  while (idnodeStack != NULL)          //從堆疊頂端逐一疊出
  {
    printf(
      "name=\"%s\" sym=%d attr=%d level=%d next=0x%p\n",
      idnodeStack->name, idnodeStack->sym,
      idnodeStack->attr, idnodeStack->level,
      idnodeStack->next);
    idnodeStack = idnodeStack->next;
  }
  return 0;
}
