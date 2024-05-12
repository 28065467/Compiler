/************************* utag.c ***********************/
#include <stdio.h>
int main()
{
  union utag
  {
    int i;
    char ch[4];
  } u;
  u.ch[0]='5';
  printf("u.ch[0] = \'%c\' \n", u.ch[0]);
  printf("u.i  = 0x%08x\n", u.i);
  printf("¦ì§}i= 0x%08x \nch[0]= 0x%08x", &u.i, &u.ch[0]);
  return 0;
}
