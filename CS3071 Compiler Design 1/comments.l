%{

%}

%%


\"(\\.|[^"\\])*\" 	{printf("%s", yytext);}

"**".*	{}
[{][^}]*[}]

[{][^}*]			{printf("syntax error\n"); return 0;}
"}"					{printf("syntax error\n"); return 0;}
.					{printf("%s", yytext);}

%%

int main()
{
  yylex();
  return 0;
}