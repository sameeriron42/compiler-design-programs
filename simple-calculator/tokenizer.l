%{
    #include<stdlib.h>
    #include "y.tab.h"
    void yyerror(char *);
%}

digit [0-9]+
float [0-9]+([.])([0-9])+
id    [a-z]

%%

{digit} {yylval = atoi(yytext);return NUM;}
{float} {yylval = atof(yytext);return NUM;}
{id}    {yylval = *yytext - 'a'; return ID;}
[ \t]+
[-+*/()=]   {return *yytext;}
[\n]    {return END;}
.       {yyerror("invalid character");}

%%

int yywrap(){
    return 1;
}