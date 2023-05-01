%{
    #include<stdio.h>
%}
number [0-9]+
seperator [\{|\}|\[|\]|\(|\)|\<|\>|\;]

%%

"int"|"void"|"return" {printf("%s, is a keyword\n",yytext);}
"#include" | "#DEFINE" {printf("%s, is a preprocessor\n",yytext);}
[a-zA-Z][a-zA-Z0-9]* {printf("%s, is a identifier\n",yytext);}
\"[a-zA-Z |" "|\n]*\" {printf("%s, is a stinrg\n",yytext);}
{number} {printf("%s, is a number\n",yytext);}
{seperator} {printf("%s, is a seperator\n",yytext);}
.|\n|" "  {ECHO;}

%%

int yywrap()
{
    return 1;
}
int main(){
    FILE *fp;
    fp = fopen("sample.c", "r");
    yyin = fp;
    yylex();
    return 1;
}
