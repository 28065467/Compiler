/******************** scandays.c *******************/
#include <stdio.h>
int main()
{
  float days;
  int months;
  double daysPerMonth;
  printf("叫块ぱ计: ");
  scanf("%f", &days);
  printf("叫块る计: ");
  scanf("%d", &months);
  daysPerMonth = days / months;
  printf("ぱ计=%6.2f る计=%d –るキАぱ计=%lf\n",
         days, months, daysPerMonth);
  return 0;
}
