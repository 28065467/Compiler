/*********************** yeardays.c ********************/
#include <stdio.h>
int main()
{
  float days = 365.25;
  int months = 12;
  double daysPerMonth = days / months;
  char title[13] = "每月平均天數";
  printf("%s\n一年天數=%6.2f 月數=%d 每月平均天數=%lf\n",
    title, days, months, daysPerMonth);
  return 0;
}
