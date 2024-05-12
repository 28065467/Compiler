bison -d calc.y
flex calc.l
gcc lex.yy.c calc.tab.c -o calc.exe
calc.exe %1 %2
