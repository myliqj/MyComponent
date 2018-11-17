path=%path%;E:\Tools\Develop\Others\dyacclex-1.4\src\lex
path=%path%;E:\Tools\Develop\Others\dyacclex-1.4\src\yacc
cls
dlex sqlLex.txt
dyacc sqlYacc.txt HoSqlYacc.dpr 
dcc32 -E..\ -I..\..\src\DGL -U..\..\src\DGL HoSqlYacc
pause
