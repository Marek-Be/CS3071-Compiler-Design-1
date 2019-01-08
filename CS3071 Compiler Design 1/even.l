%{
int numCount = 0;
%}

%%

[0-9]+ {int i=atoi(yytext); if(i%2==0) numCount++; } 
.      {}
\n	   {}

%%

int main()
{
  yylex();
  printf("%d\n", numCount);
  return 0;
}