%{ 
#  include <stdio.h>
#  include <stdlib.h>
void yyerror(char *s);
int yylex();
int yyparse();
%}
%output "romcalc.tab.c"
%token ZERO ONE FIVE TEN FIFTY ONEH FIVEH THOUSAND NEWLINE
%token ADD SUB MUL DIV ABS
%token NEXT
%%
calclist: /* nothing */
 | calclist exp NEWLINE {if ($2 == 0) printf("Z\n"); else {
	int number = $2;
	while (number > 0)
    {
        if (number >= 1000)
        {
            printf("M");
            number = number - 1000;
        }
        else if (number >= 500)
        {
            if (number < (500 + 4 * 100))
            {
                printf("D");
                number = number - 500;
            }
            else
            {
                printf("CM");
                number = number - (1000-100);
            }
        }
        else if (number >= 100)
        {
            if (number < (100 + 3 * 100)) 
            {
                printf("C");
                number = number - 100;
            }
            else
            {
                printf("LD");
                number = number - (500 - 100);
            }
        }
        else if (number >= 50 )
        {
            if (number < (50 + 4 * 10))
            {
                printf("L");
                number = number - 50;
            }
            else
            {
                printf("XC");
                number = number - (100-10);
            }
        }
        else if (number >= 10)
        {
            if (number < (10 + 3 * 10))
            {
                printf("X");
                number = number - 10;
            }
            else
            {
                printf("XL");
                number = number - (50 - 10);
            }
        }
        else if (number >= 5)
        {
            if (number < (5 + 4 * 1))
            {
                printf("V");
                number = number - 5;
            }
            else
            {
                printf("IX");
                number = number - (10 - 1);
            }
        }
        else if (number >= 1)
        {
            if (number < 4)
            {
                printf("I");
                number = number - (1);
            }
            else
            {
                printf("IV");
                number = number - (5 - 1);
            }
        }
	}
	printf("\n");
 } }
 ; 

term: 
	|term simp {if ($2 != -1) $$ = $2; else {yyerror("1"); return 0;}}
	;

exp: factor 
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term 
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

simp:  	evalNum {$$ = $1;}
	|simp evalNum {$$ = $1 >= $2? $1 + $2: -1; }
	;
evalNum:ZERO {$$ = 0;}
	|ONE {$$ = 1;}
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


int
main()
{

//  yydebug = $1 + 1;
  yyparse();
  return 0;
}

