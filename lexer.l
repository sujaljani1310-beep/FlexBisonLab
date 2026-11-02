
%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}

%option noyywrap

%%

[0-9]+    {
    yylval = atoi(yytext);
    return NUMBER;
}


"+"    { return '+'; }
"-"    { return '-'; }
"*"    { return '*'; }
"/"    { return '/'; }
"("    { return '('; }
")"    { return ')'; }
[ \t\n]+  { /* Ignore whitespace */ }

.         { return yytext[0]; }

%%

