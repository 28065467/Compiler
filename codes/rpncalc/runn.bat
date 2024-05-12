bison -d caln.y
flex caln.l
gcc lex.yy.c caln.tab.c -o caln.exe
caln %1
