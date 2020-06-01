//%token			END 0
%token 			KEYWORD_NUMBER	"number"    KEYWORD_BOOLEAN     "boolean"   KEYWORD_VOID 	    "void" 		KEYWORD_STRING 	"string"
%token 			KEYWORD_VAR 	"var"  	    KEYWORD_IF          "if" 	    KEYWORD_ELSE 	    "else"		KEYWORD_FOR 	"for"
%token 			KEYWORD_WHILE 	"while"     KEYWORD_FUNCTION    "function"	KEYWORD_CONTINUE    "continue"
%token 			KEYWORD_CONST	"const"	    KEYWORD_BREAK 	    "break"     KEYWORD_NULL        "null"
%token 			KEYWORD_START 	"start"	    KEYWORD_RETURN 	    "return"

%token			IDENTIFIER CONST_INT CONST_FLOAT CONST_TRUE CONST_FALSE CONST_STRING

%token 			PLUS_OP		"+"     MINUS_OP		"-" MULTIPLICATION_OP	"*"  DIVISION_OP	"/"  MODULO_OP 	"%"
%token			EQUALS_OP 	"=="    LESS_THAN_OP 	"<" LESS_THAN_EQUALS_OP "<=" NOT_EQUALS_OP  "!=" POWER_OP   "**"

%token			AND_OP "and" OR_OP "or"	NOT_OP "not"

%token 			ASSIGNMENT_OP	"="

%token 			SEMICOLON ";" COMMA "," COLON ":"
%token 			LEFT_PARENTHESIS "(" RIGHT_PARENTHESIS ")" LEFT_BRACKET "[" 
%token 			RIGHT_BRACKET "]" LEFT_CURLY_BRACKET "{" RIGHT_CURLY_BRACKET "}"
%%

program:	%empty;