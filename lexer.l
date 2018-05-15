%{
  int yylval = 0; int yyline = 1; int yycolumn = 0;
%}

inttoken ([1-9][0-9]*)|0

%%
[(][*].*[*][)]			{yycolumn += yyleng;}
"\n"				{yyline++; yycolumn = 0;}
" "				{yycolumn++;}
{inttoken}			{yycolumn+= yyleng; yylval = atoi(yytext); return ICONSTnumber;}
";"				{yycolumn++; return SEMInumber;}
"("				{yycolumn++; return LPARENnumber;}
")"				{yycolumn++; return RPARENnumber;}
"begin"				{yycolumn+=5; return BEGINnumber;}
"program"			{yycolumn+=7; return PROGRAMnumber;}
"-"				{yycolumn++; return MINUSnumber;}
"*"				{yycolumn++; return TIMESnumber;}
"var"				{yycolumn+=3; return VARnumber;}
","				{yycolumn++; return COMMAnumber;}
"end"				{yycolumn+=3; return ENDnumber;}
"is"				{yycolumn+=2; return ISnumber;}
"+"				{yycolumn++; return PLUSnumber;}
"div"				{yycolumn+=3; return DIVnumber;}
"print"				{yycolumn+=5; return PRINTnumber;}
"="				{yycolumn++; return EQnumber;}
"<<EOF>>"			{yycolumn+=7; return EOFnumber;}
[a-zA-Z]+[0-9]*     		{yycolumn+= yyleng; func(yytext);}
.				{yycolumn++; printf("Unknown character: %s. Line %d, column %d. \n",yytext,yyline,yycolumn);}
%%

int func(char * text)
{
  char temp[50];

  sscanf(text,"%s",temp);
  printf("Found identifier. Image: %s \n",temp);
}

