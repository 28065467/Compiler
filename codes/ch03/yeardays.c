/*********************** yeardays.c ********************/
#include <stdio.h>
int main()
{
  float days = 365.25;
  int months = 12;
  double daysPerMonth = days / months;
  char title[13] = "–るキАぱ计";
  printf("%s\nぱ计=%6.2f る计=%d –るキАぱ计=%lf\n",
    title, days, months, daysPerMonth);
  return 0;
}
