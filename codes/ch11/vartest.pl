PROGRAM vartest;
CONST
  msg1=" b from PROCEDURE is ",
  msg2=" b from PROGRAM   is ";
VAR
  a;
PROCEDURE proc;
  VAR
    b;
  BEGIN
    b := 123;
    WRITE(msg1,b);
  END;
BEGIN
  CALL proc;
  WRITE(msg2,b);
END.
