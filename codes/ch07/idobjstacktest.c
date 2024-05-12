/********************** idobjstacktest.c *******************/
#include <stdio.h>
#include <stdlib.h>
#include "sym.h"
#include "idobj.h"
#include "idobjstack.h"
int main()
{
  struct idobjTag *p=malloc(sizeof(struct idobjTag));
  strcpy(p->name, "speed");
  p->sym = symIDENTIFIER;
  p->attr = symVAR;
  p->level = 0;
  idobjpush(p);
  p=malloc(sizeof(struct idobjTag));
  strcpy(p->name, "time");
  p->sym = symIDENTIFIER;
  p->attr = symVAR;
  p->level = 0;
  idobjpush(p);
  p=malloc(sizeof(struct idobjTag));
  strcpy(p->name, "dist");
  p->sym = symIDENTIFIER;
  p->attr = symVAR;
  p->level = 0;
  idobjpush(p);
  printf("idobjstackToString()=\n%s\n",idobjstackToString());
  p = getIdobj("distance");
  if (p != NULL)
    printf("idobjToString(p)=\n%s\n",idobjToString(p));
  else
    printf("identifier \"distance\" not found!!\n");  
  return 0;
}
