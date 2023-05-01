%{
#include<stdio.h>
#include "y.tab.h"
int lineNum = 0;
%}
id [a-zA-Z_][a-zA-Z_0-9]* 
digit [0-9]
mulop [*/%]
addop [-+]

%%
"main"  {return MAIN;}
"if"    {return COND;}
"else"  {return COND;}
"while" {return COND;}

{id}    {return ID;}
{digit} {return NUM;}
"=="|">="|"<="|">"|"<"|"!="		{return RELOP;}
{addop} {return ADDOP;}
{mulop} {return MULOP;}
"="		{return ASSIGN;}
";"		{return END;}
"!"		{return NOT;}
"["		{return SQRBO;}
"]"		{return SQRBC;}
"("		{return STRBO;}
")"		{return STRBC;}
"{"		{return CRBO;}
"}"		{return CRBC;}
"\n"	{lineNum++;}
[._]+	{yyerror("Invalid character");}
[ \t]+
%%
