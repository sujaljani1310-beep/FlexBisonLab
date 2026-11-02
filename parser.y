
%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *message);
%}

%token NUMBER
%left '+''-'
%left '*''/'

%%

input:
    expression { printf("Result: %d\n", $1); }
;

expression:
      NUMBER
    | expression '+' expression
        { $$ = $1 + $3; }
    | expression '-' expression
	{ $$ = $1 - $3; }
    | expression '*' expression
	{ $$ = $1 * $3; }
    | '('expression')' 
	{$$ = $2;}
    | expression '/' expression
    {
        if ($3 == 0) {
            yyerror("division by zero");
            YYABORT;
        }

        $$ = $1 / $3;
    }
;

%%

int main(void)
{
    printf("Enter an expression: ");

    int result = yyparse();

    return result;
}

void yyerror(const char *message)
{
    fprintf(stderr, "Syntax error: %s\n", message);
}

