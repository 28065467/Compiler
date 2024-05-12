/************************ calc.h ************************/
struct nodeTag
{
  int  sym;                            /*才癘VAR俱计絪腹*/
  char name[36];                              /*才癘嘿*/
  union
  {
    double   var;                          /*才癘VAR*/
  } value;
  struct nodeTag *next;    /*硈挡VAR才癘竊翴夹*/
};
struct nodeTag *putsym(char const *, int);    /*才癘*/
struct nodeTag *getsym(char const *);         /*眔才癘*/
