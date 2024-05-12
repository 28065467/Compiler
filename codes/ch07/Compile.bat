@echo off
gcc followsym.h
IF ERRORLEVEL 1 (
    echo Compile failure on followsym！
) ELSE (
    echo Compile followsym DONE !
)
gcc resword.h
IF ERRORLEVEL 1 (
    echo Compile failure on resword！
) ELSE (
    echo Compile resword DONE !
)
gcc sym.h
IF ERRORLEVEL 1 (
    echo Compile failure on sym！
) ELSE (
    echo Compile sym DONE !
)
gcc symbol.h
IF ERRORLEVEL 1 (
    echo Compile failure on symbol！
) ELSE (
    echo Compile symbol DONE !
)
gcc parser.c
IF ERRORLEVEL 1 (
    echo Compile failure on parser！
) ELSE (
    echo Compile parser DONE !
)
