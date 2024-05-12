PROGRAM test1101;
CONST
  msg1=" keyin a number to n please: ",
  msg2=" n=",
  msg3=" 1+2+3+...+n=";
VAR
  n, sum;
BEGIN
  WRITE(msg1);
  READ(n);
  WRITE(msg2,n);
  sum := 0;
  WHILE n>0 DO
    BEGIN
      sum := sum+n;
      n := n-1;
    END;
  WRITE(msg3, sum);
END.
