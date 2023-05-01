%{
#include <stdio.h>
#include <string.h>
extern FILE *yyin;
extern int lineNum;
int ErrorRecovered = 0;
char message[100];
%}


%start Start
%token ID NUM RELOP ADDOP MULOP ASSIGN NOT SQRBO SQRBC STRBO STRBC CRBO CRBC MAIN COND END NEWLINE

%% 				
		
Start			: Global_stmt
				;			

Global_stmt		: MAIN STRBO STRBC CRBO Stmt_list CRBC {}
				| Stmt_list {}
				;
 	
Stmt_list 		: Stmt {strcpy(message, "Missing expression!");}
				| Stmt_list Stmt  {strcpy(message,"It's not the last line of the file!");}
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
  
int main()
{
    yyin=fopen("sample.txt","r");
    yyparse();
    fclose(yyin);
    if(ErrorRecovered==0) printf("Success!\n");
    return 0;
}


int yyerror(char *str)
{
				if(ErrorRecovered==0){
					{
					
					
						printf("Error Found @ line #%d: ", lineNum+1);
						if(strcmp(str,"Invalid character")==0 || strcmp(str,"Identifier greater than 5 characters")==0)						
							printf("%s!", str);
						else if(strlen(message))
						printf("%s\n",message);
						else printf("%s\n", str);
					}
					printf("\n");
					ErrorRecovered = 1;

				}
		        
}
 

