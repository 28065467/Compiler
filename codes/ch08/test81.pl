PROGRAM test81;
CONST
  msg1=" x=",
  msg2=" y=";
VAR
  x, y;
BEGIN
  x := 3;
  WHILE x>0 DO
    BEGIN
      y := x*3+6;
      WRITE(msg1,x);
      WRITE(msg2,y);
      x := x-1;
    END;
END.
