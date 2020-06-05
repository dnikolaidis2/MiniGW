%option yylineno

%{
	#include <stdio.h>
	#include <string.h>
	#include "minison.tab.h"
	#include "cgen.h"

	// Moved to cgen.h for use in error reporting
	// typedef struct string
	// {
	//     char * str;
	//     int available_size;
	// } string;

	string yyline;
	int line_read = 0;

	void reset_line(string *line) 
    {
        if (line->available_size)
            *(line->str) = 0;
    }

	void append_text(string* dst, char* src);
%}

ESCAPE_CHAR			"\\n"|"\\t"|"\\r"|"\\\\"|"\\\""|"\\'"
ALLOWED_CHAR		[., a-zA-Z0-9/:_$!#@&~\^()\-\+\*]

IDENTIFIER			[a-zA-Z][a-zA-Z0-9_]*
INTEGER_POS			([1-9][0-9]*)|(0)
FLOAT_POS			{INTEGER_POS}\.[0-9]+([eE][+-]?{INTEGER_POS})?

STR_DOUBLE_QUOTE	("'")(({ALLOWED_CHAR}|{ESCAPE_CHAR})*)("'")
STR_SINGLE_QUOTE	("\"")(({ALLOWED_CHAR}|{ESCAPE_CHAR})*)("\"")
STRING_CONST        {STR_DOUBLE_QUOTE}|{STR_SINGLE_QUOTE}
LINE_COMMENT		("//")(.*)
BLOCK_COMMENT		("/*")((.|\n)*)("*/")


%%


[^\r\t\n ].*		{	if(line_read == 0)
						{	
							// printf("%s\n", yytext);
							append_text(&yyline, yytext);
							line_read = 1;
							yyless(0);
						}
						else
						{
							REJECT;
						}
					}


number				{printf("Token KEYWORD_NUMBER:      %s\n", yytext);
					return KEYWORD_NUMBER;}
boolean				{printf("Token KEYWORD_BOOLEAN:     %s\n", yytext);
					return KEYWORD_BOOLEAN;}
string				{printf("Token KEYWORD_STRING:      %s\n", yytext);
					return KEYWORD_STRING;}
void                {printf("Toekn KEYWORD_VOID:        %s\n", yytext);
                    return KEYWORD_VOID;}
var                 {printf("Token KEYWORD_VAR:         %s\n", yytext);
                    return KEYWORD_VAR;}
const               {printf("Token KEYWORD_CONST:       %s\n", yytext);
                    return KEYWORD_CONST;}
if 					{printf("Token KEYWORD_IF:          %s\n", yytext);
					return KEYWORD_IF;}
else				{printf("Token KEYWORD_ELSE:        %s\n", yytext);
					return KEYWORD_ELSE;}
while				{printf("Token KEYWORD_WHILE:       %s\n", yytext);
					return KEYWORD_WHILE;}
for				    {printf("Token KEYWORD_FOR:         %s\n", yytext);
					return KEYWORD_FOR;}
function			{printf("Token KEYWORDFUNCTION:     %s\n", yytext);
                    return KEYWORD_FUNCTION;}
break				{printf("Token KEYWORD_BREAK:       %s\n", yytext);
					return KEYWORD_BREAK;}
continue			{printf("Token KEYWORD_CONTINUE:    %s\n", yytext);
					return KEYWORD_CONTINUE;}
return				{printf("Token KEYWORD_RETURN:      %s\n", yytext);
					return KEYWORD_RETURN;}
null				{printf("Token KEYWORD_NULL:        %s\n", yytext);
					return KEYWORD_NULL;}
start				{printf("Token KEYWORD_START:       %s\n", yytext);
					return KEYWORD_START;}
and					{printf("Token AND_OP:              %s\n", yytext);
					return AND_OP;}
or					{printf("Token OR_OP:               %s\n", yytext);
					return OR_OP;}
not 				{printf("Token NOT_OP:              %s\n", yytext);
					return NOT_OP;}
true				{printf("Token CONST_TRUE:          %s\n", yytext);
					yylval.crepr = strdup(yytext);
					return CONST_TRUE;}
false				{printf("Token CONST_FALSE:         %s\n", yytext);
					yylval.crepr = strdup(yytext);
					return CONST_FALSE;}


{IDENTIFIER}		{printf("Token IDENTIFIER:          %s\n", yytext);
					yylval.crepr = strdup(yytext);
					return IDENTIFIER;}
{INTEGER_POS}		{printf("Token CONST_INT:           %s\n", yytext);
					yylval.crepr = strdup(yytext);
					return CONST_INT;}
{FLOAT_POS}			{printf("Token CONST_FLOAT:         %s\n", yytext);
					yylval.crepr = strdup(yytext);
					return CONST_FLOAT;}
{STRING_CONST}		{printf("Token CONST_STRING:        %s\n", yytext);
					yylval.crepr = strdup(yytext);
					return CONST_STRING;}


"+"					{printf("Token PLUS_OP:             %s\n", yytext);
					return PLUS_OP;}
"-"					{printf("Token MINUS_OP:            %s\n", yytext);
					return MINUS_OP;}
"*"					{printf("Token MULTIPLICATION_OP:   %s\n", yytext);
					return MULTIPLICATION_OP;}
"/"					{printf("Token DIVISION_OP:         %s\n", yytext);
					return DIVISION_OP;}
"%"					{printf("Token MODULO_OP:           %s\n", yytext);
					return MODULO_OP;}
"**"				{printf("Token POWER_OP:            %s\n", yytext);
					return POWER_OP;}
"=="				{printf("Token EQUALS_OP:           %s\n", yytext);
					return EQUALS_OP;}
"<"					{printf("Token LESS_THAN_OP:        %s\n", yytext);
					return LESS_THAN_OP;}
"<="				{printf("Token LESS_THAN_EQUALS_OP: %s\n", yytext);
					return LESS_THAN_EQUALS_OP;}
"!="				{printf("Token NOT_EQUALS_OP:       %s\n", yytext);
					return NOT_EQUALS_OP;}
"=" 				{printf("Token ASSIGNMENT_OP:       %s\n", yytext);
					return ASSIGNMENT_OP;}


";"					{printf("Token SEMICOLON:           %s\n", yytext);
					return SEMICOLON;}
"("					{printf("Token LEFT_PARENTHESIS:    %s\n", yytext);
					return LEFT_PARENTHESIS;}
")"					{printf("Token RIGHT_PARENTHESIS:   %s\n", yytext);
					return RIGHT_PARENTHESIS;}
","					{printf("Token COMMA:               %s\n", yytext);
					return COMMA;}
"["					{printf("Token LEFT_BRACKET:        %s\n", yytext);
					return LEFT_BRACKET;}
"]"					{printf("Token RIGHT_BRACKET:       %s\n", yytext);
					return RIGHT_BRACKET;}
"{"					{printf("Token LEFT_CURLY_BRACKET:  %s\n", yytext);
					return LEFT_CURLY_BRACKET;}
"}"					{printf("Token RIGHT_CURLY_BRACKET: %s\n", yytext);
					return RIGHT_CURLY_BRACKET;}
":"					{printf("Token COLON:               %s\n", yytext);
					return COLON;}

{LINE_COMMENT}		
{BLOCK_COMMENT}


(" "|"\t"|"\r")
\n 					{reset_line(&yyline);
					line_read = 0;}

.					{printf("Unrecognized token %s near line %d: %s\n",
							yytext, yylineno, yyline.str);}

%%

void append_text(string *dst, char* src)
{
    int new_size = (dst->str == NULL) ? strlen(src) + 1 : strlen(dst->str) + strlen(src) + 2;
    if (dst->available_size < new_size) {
        dst->str = realloc(dst->str, new_size);
        dst->available_size = new_size;
    }
    
    strncat(dst->str, src, strlen(src));
}