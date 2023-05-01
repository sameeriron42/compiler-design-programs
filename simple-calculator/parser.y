%{
    #include<stdio.h>
    int sym[26];
    void yyerror(char *);
%}

%token NUM ID END
%start Program
/* the ordering(reverse) of these determines the operation precedence */
%left '+' '-'
%left '*' '/'

%%

Program     : Program Stmt END
            |
            ;

Stmt        : Expr {printf("The answer is %d\n",$1);}
            | ID '=' Expr {printf("storing the value of %c\n",$1+'a');sym[$1] = $3;}

Expr        : NUM           {$$= $1;}
            | ID {$$=sym[$1];}
            | Expr '+' Expr {$$ = $1 + $3;}
            | Expr '-' Expr {$$ = $1 - $3;}
            | Expr '*' Expr {$$ = $1 * $3;}
            | Expr '/' Expr {$$ = $1 / $3;}
            | '(' Expr ')'  
%%

void yyerror(char *msg){
    printf("Error occured: %s",msg);
}

int main(){
    yyparse();
    return 0;
}
