%{
# include "romcalc.tab.h"

void yyerror(char *s);
int yylex();


%}

%option noyywrap
%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"     { return ABS; }

"Z" { return ZERO; }
"I" { return ONE; }
"V" { return FIVE; }
"X" { return TEN; }
"L"  { return FIFTY; }
"C" { return ONEH; }
"D" { return FIVEH; }
"M" { return THOUSAND; }
"\n" { return NEWLINE; }
%%

