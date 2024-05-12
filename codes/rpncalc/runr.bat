bison -r itemset -d calr.y
flex calc.l
gcc lex.yy.c calr.tab.c -o calr.exe
calr %1
