PROGRAM test83;
CONST
  msg1=" x=",
  msg2=" y=",
  msg3="hcf=";
VAR
  x,y,hcf;
  PROCEDURE gcd;
  VAR
    q,r;
  BEGIN
    WHILE y > 0 DO
      BEGIN
        q := x/y;
        r := x-y*q;
        x := y;
        y := r;
      END;
    hcf := x;
    WRITE(msg3,hcf);
  END;
BEGIN
  x := 12;
  y := 9;
  WRITE(msg1,x);
  WRITE(msg2,y);
  CALL gcd;
END.
