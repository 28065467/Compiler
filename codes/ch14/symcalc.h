/***************** symcalc.h *****************/
struct nodeTag
{
  int  sym;                 /*才癘VAR俱计絪腹*/
  char name[36];                /*才癘VAR嘿*/
  union
  {
    double   var;             /*才癘VAR粂種*/
  } value;
  struct nodeTag *next;          /*竊翴*/
};
char *nodeToString(struct nodeTag *p);
char *nodestackToString();
struct nodeTag *putsym(char const *, int);
struct nodeTag *getsym(char const *);
