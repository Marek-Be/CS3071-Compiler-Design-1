%{

%}

DIGIT [0-9]
BIANUAL [1-2]
COUNTYNEW C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
COUNTYOLD C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WH|WX|WW|WD
PLATE [0-9]|[0-9][0-9]|[0-9][0-9][0-9]|[0-9][0-9][0-9][0-9]|[0-9][0-9][0-9][0-9][0-9]|[0-9][0-9][0-9][0-9][0-9][0-9]

%%

{DIGIT}{DIGIT}{BIANUAL}(-){COUNTYNEW}(-){PLATE}		{
														char* yearN = yytext;
														char destN[2];
														strncpy(destN, yearN, 2);
														destN[2] = 0;
														int i=atoi(destN);
														if (i > 12)
															printf("%d\n", 18-i);
														else
															printf("INVALID\n");
													}
														
{DIGIT}{DIGIT}(-){COUNTYOLD}(-){PLATE}				{
														char* yearO = yytext;
														char destO[2];
														strncpy(destO, yearO, 2);
														destO[2] = 0;
														int i=atoi(destO);
														if (i <= 12)
															printf("%d\n", 18-i);
														else if (i >= 87)
															printf("%d\n", 100-i + 18);
														else
															printf("INVALID\n");
													}


\n		{}
. 		{}


%%

int main()
{
  yylex();
  return 0;
}