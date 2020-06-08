/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_MYANALYZER_TAB_H_INCLUDED
# define YY_YY_MYANALYZER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KEYWORD_NUMBER = 258,
    KEYWORD_BOOLEAN = 259,
    KEYWORD_VOID = 260,
    KEYWORD_STRING = 261,
    KEYWORD_VAR = 262,
    KEYWORD_IF = 263,
    KEYWORD_ELSE = 264,
    KEYWORD_FOR = 265,
    KEYWORD_WHILE = 266,
    KEYWORD_FUNCTION = 267,
    KEYWORD_CONTINUE = 268,
    KEYWORD_CONST = 269,
    KEYWORD_BREAK = 270,
    KEYWORD_NULL = 271,
    KEYWORD_START = 272,
    KEYWORD_RETURN = 273,
    IDENTIFIER = 274,
    CONST_INT = 275,
    CONST_FLOAT = 276,
    CONST_TRUE = 277,
    CONST_FALSE = 278,
    CONST_STRING = 279,
    PLUS_OP = 280,
    MINUS_OP = 281,
    MULTIPLICATION_OP = 282,
    DIVISION_OP = 283,
    MODULO_OP = 284,
    EQUALS_OP = 285,
    LESS_THAN_OP = 286,
    LESS_THAN_EQUALS_OP = 287,
    NOT_EQUALS_OP = 288,
    POWER_OP = 289,
    AND_OP = 290,
    OR_OP = 291,
    NOT_OP = 292,
    ASSIGNMENT_OP = 293,
    SEMICOLON = 294,
    COMMA = 295,
    COLON = 296,
    LEFT_PARENTHESIS = 297,
    RIGHT_PARENTHESIS = 298,
    LEFT_BRACKET = 299,
    RIGHT_BRACKET = 300,
    LEFT_CURLY_BRACKET = 301,
    RIGHT_CURLY_BRACKET = 302,
    UMINUS = 303,
    UPLUS = 304
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 14 "myanalyzer.y" /* yacc.c:1909  */

    char * crepr;

#line 108 "myanalyzer.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MYANALYZER_TAB_H_INCLUDED  */
