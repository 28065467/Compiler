PROGRAM test73;
CONST
  msg1=" x=",
  msg2=" y=",
  msg3=" HCF=";
VAR
  x, y;
  PROCEDURE gcd;
  VAR r;
    PROCEDURE xDIVy;
    VAR r;
    BEGIN
      r  := x;
      WHILE x>y DO x := x-y;
    END;
    PROCEDURE yDIVx;
    VAR r;
    BEGIN
      r :=  y;
      WHILE y>x DO; y:=y-x;
    END;
  BEGIN
    WHILE x<>y DO
      BEGIN
        IF x>y THEN CALL xDIVy;
        IF y>x THEN CALL yDIVx;
      END;
    WRITE(msg3,x);
  END;
BEGIN
  x := 12;
  y := 9;
  WRITE(msg1,x);
  WRITE(msg2,y);
  CALL gcd;
END.
