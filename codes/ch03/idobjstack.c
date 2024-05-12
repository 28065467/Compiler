/*********************** idobjstack.c *******************/
#include <stdio.h>
#include <stdlib.h>
struct idobjTag
{
  char name[36];
  int sym;
  int attr;
  int level;
  struct idobjTag *next;
} *idobj, *idobjStack[10];
int idobjTop = 0;
int main()
{
  int i;
  idobj=malloc(sizeof(struct idobjTag));  //建立speed結構
  strcpy(idobj->name, "speed");
  idobj->sym = 2;
  idobj->attr = 31;
  idobj->level = 1;
  idobjStack[idobjTop++] = idobj;          //疊入堆疊頂端
  idobj = malloc(sizeof(struct idobjTag)); //建立time結構
  strcpy(idobj->name, "time");
  idobj->sym = 2;
  idobj->attr = 31;
  idobj->level = 1;
  idobjStack[idobjTop++] = idobj;          //疊入堆疊頂端
  idobj = malloc(sizeof(struct idobjTag)); //建立dist結構
  strcpy(idobj->name, "dist");
  idobj->sym = 2;
  idobj->attr = 31;
  idobj->level = 0;
  idobjStack[idobjTop++] = idobj;          //疊入堆疊頂端
  for (i=idobjTop-1; i>=0; i--)      //從堆疊頂端逐一疊出
  {
    printf(
      "name=\"%s\" sym=%d attr=%d level=%d next=0x%p\n",
      idobjStack[i]->name, idobjStack[i]->sym,
      idobjStack[i]->attr, idobjStack[i]->level,
      idobjStack[i]->next);
  }
  return 0;
}
