{
#include<stdio.h>
#include<string.h>
extern FILE *yyin;
char message[100];
extern int lineNum;
int valid = 1;
%}

%start StartSymbol
%token ID NUM RELOP ADDOP MULOP ASSIGN NOT SQRBO SQRBC STRBO STRBC CRBO CRBC MAIN COND END NEWLINE

%%

StartSymbol :   Global_stmt
            ;

Global_stmt	: MAIN STRBO STRBC CRBO Stmt_list CRBC {}
			| Stmt_list {}
			;

Stmt_list   : Stmt {}
            | Stmt_list Stmt {}
            ;
Stmt	  		: Variable ASSIGN Expression END {strcpy(message,"Variable or expression missing. Cannot assign anything!");}
				| COND STRBO Expression STRBC CRBO Stmt_list CRBC {}
				| COND CRBO Stmt_list CRBC {}
				; 				
Variable  		: ID {strcpy(message,"Expecting something else!");}
				| ID SQRBO Expression SQRBC {strcpy(message,"'[' or ']' missing OR expression not found!");}
				;               

Expression		: Simple_expression {strcpy(message,"Missing expression!");}
				| Simple_expression RELOP Simple_expression  {strcpy(message,"Conditional operation cannot be done");}
				;

Simple_expression	: Term {}
				| Simple_expression ADDOP Term {strcpy(message,"Additive operation cannot be done");}
				;

Term			: Factor {}
				| Term MULOP Factor {strcpy(message,"Multiplicative operation cannot be done!");}
				; 

Factor			: ID {strcpy(message,"Expecting something else!");}
				| NUM {strcpy(message,"Unrecognized number format!");}
				| STRBO Expression STRBC {strcpy(message,"'(' or ')' missing OR expression not found!");}
				| ID SQRBO Expression SQRBC {strcpy(message,"'[' or ']' missing OR ID not found!");}
				| NOT Factor 
				; 				

%%

int yywrap()
{
    return 1;
}
int yyerror()
{
    valid=0;
    printf("\nInvalid expression!\n");
    return 0;
}

int main(){
    yyin = fopen("sample.txt","r");
    yyparse();
    fclose(yyin);
    if(valid == 0)
    {
        printf("Cannot Parse Error!!!");
        return 1;
    }
    printf("Successfull parsing");
    return 0;
}
