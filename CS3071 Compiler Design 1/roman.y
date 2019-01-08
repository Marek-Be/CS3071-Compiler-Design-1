%{ 
#  include <stdio.h>
#  include <stdlib.h>
void yyerror(char *s);
int yylex();
int yyparse();
%}
%output "roman.tab.c"
%token ONE FIVE TEN FIFTY ONEH FIVEH THOUSAND NEWLINE
%token NEXT
%%
calclist: 
	|calclist simp NEWLINE {if ($2 != -1) printf("%d\n", $2); else yyerror("1"); }
	;
simp:  	eval {$$ = $1;}
	|simp eval {$$ = $1 >= $2? $1 + $2: -1; }
	;
eval:   ONE {$$ = 1;}
	|ONE FIVE {$$ = 4;}
	|FIVE {$$ = 5;}
	|ONE FIVE ONE {$$ = -1;}
	|ONE TEN {$$ =  9;}
	|TEN {$$ =  10;}
	|ONE TEN ONE {$$ =  -1;}
	|TEN FIFTY {$$ = 40;}
	|FIFTY {$$ = 50;}
	|TEN FIFTY TEN {$$ = -1;}
	|TEN ONEH {$$ = 90;}
	|ONEH {$$ = 100;}
	|TEN ONEH TEN {$$ = -1;}
	|ONEH FIVEH {$$ = 400;}
	|FIVEH {$$ = 500;}
	|FIVEH ONEH {$$ = 600;}
	|ONEH FIVEH ONEH {$$ = -1;}
	|ONEH THOUSAND {$$ = 900;}
	|THOUSAND {$$ = 1000;}
	|ONEH THOUSAND ONEH {$$ = -1;}
	;
%%
void yyerror(char *s)
{
	printf("syntax error\n");
}


int main()
{

//  yydebug = $1 + 1;
  yyparse();
  return 0;
}

