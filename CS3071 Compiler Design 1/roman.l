%{
# include "roman.tab.h"

void yyerror(char *s);
int yylex();


%}

%option noyywrap
%%
"I" { return ONE; }
"V" { return FIVE; }
"X" { return TEN; }
"L"  { return FIFTY; }
"C" { return ONEH; }
"D" { return FIVEH; }
"M" { return THOUSAND; }
"\n" { return NEWLINE; }
%%

