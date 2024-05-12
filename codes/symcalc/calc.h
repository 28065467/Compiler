/************************ calc.h ************************/
struct nodeTag
{
  int  sym;                            /*符記VAR整數編號*/
  char name[36];                              /*符記名稱*/
  union
  {
    double   var;                          /*符記VAR的值*/
  } value;
  struct nodeTag *next;    /*連結至下一個VAR符記節點指標*/
};
struct nodeTag *nodestackTop;                 /*堆疊頂端*/
struct nodeTag *putsym(char const *, int);        /*疊入*/
struct nodeTag *getsym(char const *);       /*從堆疊取得*/
char * nodeToString(struct nodeTag *p);      /*p節點內容*/
char * nodestackToString();               /*節點堆疊內容*/
