/********************** mfcalc.h ************************/
typedef double (*funtype) (double);    /*定義函式型態*/
struct nodeTag
{
  int  sym;                         /*符記VAR整數編號*/
  char name[36];                           /*符記名稱*/
  union
  {
    double   var;                       /*符記VAR的值*/
    funtype funptr;                     /*符記FUN的值*/
  } value;
  struct nodeTag *next; /*連結至下一個VAR符記節點指標*/
};
struct nodeTag *nodestackTop;              /*堆疊頂端*/
struct nodeTag *putsym(char const *, int);     /*加入*/
struct nodeTag *getsym(char const *);          /*取得*/
char * nodeToString(struct nodeTag *p);    /*顯示節點*/
char * nodestackToString();                /*顯示堆疊*/
