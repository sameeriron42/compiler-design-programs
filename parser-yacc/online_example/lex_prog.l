%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
void yyerror(char *);

char identifier[50][50];
int total_id = 0;
int lineNum = 0;
%}

digit  [0-9]
letter [a-zA-Z]
mulop	[*/%]
addop	[+-]


/*
"main" {yyerror("No rules for main");}
"if" {yyerror("No rules for if");}
"else" {yyerror("No rules for else");}
"while" {yyerror("No rules for while");}
*/
%%
"main" {printf("read main\n");return MAIN;}
"if" 	{return COND;}
"else" {return COND;}
"while" {return COND;}
"for" {yyerror("No rules for 'for'");}
"repeat" {yyerror("No rules for repeat");}
"until" {yyerror("No rules for until");}
"return" {yyerror("No rules for return");}
{letter}({letter}|{digit}|"_")({letter}|{digit}|"_")({letter}|{digit}|"_")({letter}|{digit}|"_")({letter}|{digit}|"_")+ {

{yyerror("Identifier greater than 5 characters");}

}
	
{letter}({letter}|{digit}|"_")?({letter}|{digit}|"_")?({letter}|{digit}|"_")?({letter}|{digit}|"_")?		{
	    int i;
	    int flag=0; 
	    for (i = 0; i<total_id; i++) {
		if (strcmp(identifier[i], yytext)==0)
		 {
		     flag=1;
		     break;
		 }
	    }
	        	 
	    if(flag==0)	
	     {
			if(total_id==0) puts("");
			printf("\r%s\n", yytext);
			strcpy(identifier[total_id++],yytext);
		
	     } 
		return ID;
		
    }


{digit}+|({digit}+("."){digit}+)   	{return NUM;} 
"=="|">="|"<="|">"|"<"|"!="		{return RELOP;}
{addop}|("||") 				{return ADDOP;}
{mulop}|("&&") 				{return MULOP;}
"="					{return ASSIGN;}
";"					{return END;}
"!"					{return NOT;}
"["					{return SQRBO;}
"]"					{return SQRBC;}
"("					{printf("(\n");return STRBO;}
")"					{printf(")\n");return STRBC;}
"{"				   	{printf("{\n");return CRBO;}
"}"					{return CRBC;}
"\n"				{lineNum++;}
[._]+				{yyerror("Invalid character");}
[ \t]+
[ ]* {}
%%

