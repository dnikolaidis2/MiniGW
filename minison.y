%{
#include <stdio.h>
#include "cgen.h"
#include <string.h>

extern void yyset_in  ( FILE * _in_str  );
extern int yylex(void);
extern int yylineno;

char * filename;
%}

%union
{
    char * crepr;
}


%define parse.trace
%define parse.error verbose
%define parse.lac full


%token 			KEYWORD_NUMBER	"number"    KEYWORD_BOOLEAN     "boolean"   KEYWORD_VOID 	    "void" 		KEYWORD_STRING 	"string"
%token 			KEYWORD_VAR 	"var"  	    KEYWORD_IF          "if" 	    KEYWORD_ELSE 	    "else"		KEYWORD_FOR 	"for"
%token 			KEYWORD_WHILE 	"while"     KEYWORD_FUNCTION    "function"	KEYWORD_CONTINUE    "continue"
%token 			KEYWORD_CONST	"const"	    KEYWORD_BREAK 	    "break"     KEYWORD_NULL        "null"
%token 			KEYWORD_START 	"start"	    KEYWORD_RETURN 	    "return"

%token  <crepr> IDENTIFIER CONST_INT CONST_FLOAT CONST_TRUE CONST_FALSE CONST_STRING

%token 			PLUS_OP		"+"     MINUS_OP		"-" MULTIPLICATION_OP	"*"  DIVISION_OP	"/"  MODULO_OP 	"%"
%token			EQUALS_OP 	"=="    LESS_THAN_OP 	"<" LESS_THAN_EQUALS_OP "<=" NOT_EQUALS_OP  "!=" POWER_OP   "**"

%token			AND_OP "and" OR_OP "or"	NOT_OP "not"

%token 			ASSIGNMENT_OP	"="

%token 			SEMICOLON ";" COMMA "," COLON ":"
%token 			LEFT_PARENTHESIS "(" RIGHT_PARENTHESIS ")" LEFT_BRACKET "[" 
%token 			RIGHT_BRACKET "]" LEFT_CURLY_BRACKET "{" RIGHT_CURLY_BRACKET "}"



%start begin

%type   <crepr> program
%type   <crepr> functions
%type   <crepr> statements
%type   <crepr> main
%type   <crepr> function_decl
%type   <crepr> statement
%type   <crepr> open_statement
%type   <crepr> closed_statement
%type   <crepr> simple_statement
%type   <crepr> var_const_decl
%type   <crepr> const_decl
%type   <crepr> var_decl
%type   <crepr> var_not_req
%type   <crepr> var_req
%type   <crepr> type_decl
%type   <crepr> function_call_delim
%type   <crepr> function_call_param
%type   <crepr> param_decl
%type   <crepr> param_delim
%type   <crepr> function_param_decl
%type   <crepr> expression

%left   "or"
%left   "and"
%left   "==" "!=" "<" "<="
%left   "-"
%left   "*" "/" "%"
%right  "**"
%right  "+"
%right  "not"

%%


begin:                  program
                        {
                            if (yyerror_count == 0) {
                                FILE * outfp = fopen(filename, "w");
                                fprintf(outfp, "%s\n%s\n", c_prologue, $1);
                                fclose(outfp);
                                printf("%s\n%s\n", c_prologue, $1);
                            }
                        }
|                       %empty;

program:                statements functions main
                        {$$ = template("%s\n%s\n%s", $1, $2, $3);};

main:                   "function" "start" "(" ")" ":" "void" "{" statements "}"
                        {$$ = template("void main()\n{%s\n}\n", $8);};

functions:              functions function_decl
                        {$$ = template("%s\n%s", $1, $2);}
|                       %empty
                        {$$ = template("");};

// TODO: add array return type
function_decl:          "function" IDENTIFIER "(" function_param_decl ")" ":" type_decl "{" statements "}"
                        {$$ = template("%s %s(%s)\n{%s\n}", $7, $2, $4, $9);};

statements:             statements statement
                        {$$ = template("%s\n%s", $1, $2);}
|                       %empty
                        {$$ = template("");};

statement:              open_statement
                        {$$ = $1;}
|                       closed_statement
                        {$$ = $1;};

// TODO: fixa da fora itsa broken
open_statement:         "if" "(" expression ")" statement
                        {$$ = template("if(%s)\n%s", $3, $5);}
|                       "if" "(" expression ")" closed_statement "else" open_statement
                        {$$ = template("if(%s)\n%s\nelse\n%s", $3, $5, $7);}
|                       "while" "(" expression ")" open_statement
                        {$$ = template("while(%s)\n%s", $3, $5);}
|                       "for" "(" simple_statement ";" expression ";" simple_statement ")" open_statement
                        {$$ = template("for(%s;%s;%s)\n%s", $3, $5, $7, $9);};

closed_statement:       simple_statement
                        {$$ = $1;}
|                       "if" "(" expression ")" closed_statement "else" closed_statement
                        {$$ = template("if(%s)\n%s\nelse\n%s", $3, $5, $7);}
|                       "while" "(" expression ")" closed_statement
                        {$$ = template("while(%s)\n%s", $3, $5);}
|                       "for" "(" simple_statement ";" expression ";" simple_statement ")" closed_statement
                        {$$ = template("for(%s;%s;%s)\n%s", $3, $5, $7, $9);};

simple_statement:       "{" statements "}"
                        {$$ = template("{\n%s\n}", $2);}
|                       IDENTIFIER "=" expression ";"
                        {$$ = template("%s = %s;", $1, $3);}
|                       "break" ";"
                        {$$ = template("break;");}
|                       "continue" ";"
                        {$$ = template("continue;");}
|                       "return" ";"
                        {$$ = template("return;");}
|                       "return" expression ";"
                        {$$ = template("return %s;", $2);}
|                       IDENTIFIER "(" function_call_param ")"";"
                        {$$ = template("%s(%s);", $1, $3);}
|                       var_const_decl ";"
                        {$$ = template("%s;", $1);};

// TODO: Array type
var_const_decl:         var_decl ":" type_decl
                        {$$ = template("%s %s", $3, $1);}
|                       const_decl ":" type_decl
                        {$$ = template("const %s %s", $3, $1);};

const_decl:             "const" var_req
                        {$$ = template("%s", $2);}
|                       const_decl "," var_req
                        {$$ = template("%s, %s", $1, $3);};

var_decl:               "var" var_not_req
                        {$$ = template("%s", $2);}
|                       var_decl "," var_not_req
                        {$$ = template("%s, %s", $1, $3);};

var_not_req:            IDENTIFIER "=" expression
                        {$$ = template("%s = %s", $1, $3);}
|                       IDENTIFIER
                        {$$ = template("%s", $1);}
|                       IDENTIFIER "[" CONST_INT "]"
                        {$$ = template("%s[%s]", $1, $3);};

var_req:                IDENTIFIER "=" expression
                        {$$ = template("%s = %s", $1, $3);};

type_decl:              "number"
                        {$$ = template("double");}
|                       "boolean"
                        {$$ = template("int");}
|                       "string"
                        {$$ = template("char *");}
|                       "void"
                        {$$ = template("void");};

function_call_delim:    function_call_delim "," expression
                        {$$ = template("%s, %s", $1, $3);}
|                       expression
                        {$$ = template("%s", $1);};

function_call_param:    function_call_delim
                        {$$ = template("%s", $1);}
|                       %empty
                        {$$ = template("");};

param_decl:             IDENTIFIER ":" type_decl
                        {$$ = template("%s %s", $3, $1);}
|                       IDENTIFIER "[" "]" ":" type_decl
                        {$$ = template("%s %s[]", $5, $1);};

param_delim:            param_delim "," param_decl
                        {$$ = template("%s, %s", $1, $3);}
|                       param_decl
                        {$$ = template("%s", $1);};

function_param_decl:    param_delim
                        {$$ = template("%s", $1);}
|                       %empty
                        {$$ = template("");};

expression:             CONST_INT
                        {$$ = template("%s", $1);}
|                       CONST_FLOAT
                        {$$ = template("%s", $1);}
|                       CONST_FALSE
                        {$$ = template("%s", $1);}
|                       CONST_TRUE
                        {$$ = template("%s", $1);}
|                       CONST_STRING
                        {$$ = template("%s", $1);}
|                       IDENTIFIER
                        {$$ = template("%s", $1);}
|                       IDENTIFIER "[" expression "]"
                        {$$ = template("%s[%s]", $1, $3);}
|                       "(" expression ")"
                        {$$ = template("(%s)", $2);}
|                       "not" expression
                        {$$ = template("!%s", $2);}
|                       "+" expression
                        {$$ = template("+%s", $2);}
|                       "-" expression                  %prec "+"
                        {$$ = template("-%s", $2);}
|                       expression "**" expression
                        {$$ = template("pow(%s, %s)", $1, $3);}
|                       expression "*" expression
                        {$$ = template("%s*%s", $1, $3);}
|                       expression "/" expression
                        {$$ = template("%s/%s", $1, $3);}
|                       expression "%" expression
                        {$$ = template("%s\%%s", $1, $3);}
|                       expression "+" expression       %prec "-"
                        {$$ = template("%s+%s", $1, $3);}
|                       expression "-" expression
                        {$$ = template("%s-%s", $1, $3);}
|                       expression "==" expression
                        {$$ = template("%s==%s", $1, $3);}
|                       expression "!=" expression
                        {$$ = template("%s!=%s", $1, $3);}
|                       expression "<" expression
                        {$$ = template("%s<%s", $1, $3);}
|                       expression "<=" expression
                        {$$ = template("%s<=%s", $1, $3);}
|                       expression "and" expression
                        {$$ = template("%s&&%s", $1, $3);}
|                       expression "or" expression
                        {$$ = template("%s||%s", $1, $3);}
|                       IDENTIFIER "(" function_call_param ")"
                        {$$ = template("%s(%s)", $1, $3);};

%%


int main (int argc, char * argv[]) {
    FILE *fd;
    
    if (argc == 2)
    {
        char * start = strrchr(argv[1], '/') + 1;
        char * end = strrchr(argv[1], '.');
        int size = end - start;
        filename = malloc(((size) + 3)*sizeof(char));
        strncpy(filename, start, size);
        strcpy(filename + size, ".c");

        if(!(fd = fopen(argv[1], "r")))
        {
            perror("Error: could not read file.");
        }

        yyset_in(fd);
        if (yyparse() == 0)
        {
            printf("Its working!\n");
        }
        else
        {
            printf("I did a boo boo\n");
        }

        fclose(fd);
    }
    else
    {
        printf("Usage: minigw filename\n");
    }
}