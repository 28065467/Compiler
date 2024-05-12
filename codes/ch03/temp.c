/********************** tree.c ***************************/
#include <stdio.h>
#include <stdlib.h>
struct wordTag
{
  char word[36];
  struct wordTag *linkL, *linkR;                /*左鏈, 右鏈*/
};
struct wordTag node, *root, *p, *q;       /*樹結構變數, 指標*/
void createRoot(char word[])
{
  root=malloc(sizeof(struct wordTag));   /*建立節點p*/
  root->linkL=NULL;                               /*左鏈空白*/
  root->linkR=NULL;                               /*右鏈空白*/
  strcpy(root->word, word);
}
struct wordTag *insertNode(char word[])
{
  p=root;
  q=root;
  while (p!=NULL)
  {
    q = p;
    if (strcmp(word, p->word) < 0)
      p = p->linkL;                                   /*往左*/
    else if (strcmp(word, p->word) > 0)
      p = p->linkR;                                   /*往右*/
    else
      return p;
  }
  p = malloc(sizeof(struct wordTag));       /*建立節點p*/
  p->linkL=NULL;                                  /*左鏈空白*/
  p->linkR=NULL;                                  /*右鏈空白*/
  strcpy(p->word, word);                              /*資料欄*/
  if (strcmp(word, q->word) < 0)
    q->linkL = p;                                     /*左掛*/
  else
    q->linkR = p;                                     /*右掛*/
}
void inOrder(struct wordTag *p)
{
  if (p != NULL)
  {
    inOrder(p->linkL);
    printf("%p   %p  %p  %s\n", p,p->linkL,p->linkR,p->word);
    inOrder(p->linkR);
  }
}
int main()
{
  char key[21];                                     /*資料鍵*/
  root=NULL;                              /*根節點指標, 空白*/
  while (1)                           /*不是空字串時重覆執行*/
  {
    printf("keyin key : ");
    gets(key);                           /*鍵入資料鍵key字串*/
    if (strlen(key)==0) break;       /*空字串跳出while()迴圈*/
    if (root==NULL)                                   /*空樹*/
      createRoot(key);                          /*建立根節點*/
    else                                            /*非空樹*/
      insertNode(key);                /*找尋key,找不到時建立*/
  }
  printf("\nIn order sequence, root=0x%p\n", root); /*根指標*/
  printf("  p   linkL  linkR key\n");         /*左鏈,右鏈,鍵*/
  inOrder(root);                                  /*中序印出*/
  return 0;
}
