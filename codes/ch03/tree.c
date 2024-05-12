/*********************** tree.c **********************/
#include <stdio.h>
#include <stdlib.h>
struct wordTag
{
  char word[36];
  struct wordTag *left, *right;
};
struct wordTag *root;
void createRoot(char word[])
{
  root=malloc(sizeof(struct wordTag));
  root->left=NULL;
  root->right=NULL;
  strcpy(root->word, word);
}
struct wordTag *insertNode(char word[])
{
  struct wordTag *p = root;
  struct wordTag *q = root;
  while (p!=NULL)
  {
    q = p;
    if (strcmp(word, p->word) < 0)
      p = p->left;
    else if (strcmp(word, p->word) > 0)
      p = p->right;
    else
      return p;
  }
  p = malloc(sizeof(struct wordTag));
  p->left = NULL;
  p->right = NULL;
  strcpy(p->word, word);
  if (strcmp(word, q->word) < 0)
    q->left = p;
  else
    q->right = p;
}
void inOrder(struct wordTag *p)
{
  if (p != NULL)
  {
    inOrder(p->left);
    printf("0x%p\t0x%p\t0x%p\t\"%s\"\n",
           p, p->left, p->right, p->word);
    inOrder(p->right);
  }
}
int main()
{
  char word[36];
  root = NULL;
  printf("請逐次輸入字串插入樹結構，Ctrl-Z結束\n");
  while (fgets(word,sizeof(word),stdin)!=NULL)
  {
    word[strlen(word)-1] = '\0';
    if (root==NULL)
      createRoot(word);
    else
      insertNode(word);
  }
  printf("\t樹根root=0x%p 中序(in order)取出\n", root);
  printf("\n  指標 \t\t左鏈 \t\t右鏈 \t\t識別字\n");
  inOrder(root);
  return 0;
}
