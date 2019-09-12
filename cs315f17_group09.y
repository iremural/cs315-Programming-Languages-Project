%{
#include <stdio.h>
%}
%token IF NJOY END CONST NJOY_WHILE DO ELSE RETURN STOP_NJOY 
%token IMPLIES AND OR IFF NOT PROGRAM END_PROGRAM BOOL OUT IN 
%token TYPE_STRING TYPE_BOOL PROGRAM_IDENTIFIER IDENTIFIER 
%token CONST_IDENTIFIER ARRAY_IDENTIFIER COMMENT STRING 
%token ASSIGNMENT_OP LSB  RSB 
%token CLB CRB LP RP COMMA 
%token SEMICOLON COLON  

%left  IFF
%right IMPLIES
%left  OR
%left AND 
%left NOT
%right ASSIGNMENT_OP

%start program

%%
program: PROGRAM PROGRAM_IDENTIFIER NJOY program_statements END_PROGRAM {printf("Input program accepted! \n"); return 0;}
			;
program_statements: program_statements program_statement | program_statement  
			;
program_statement:  comment | declarative_statement | predicate_dec   
; 
predicate_dec : IDENTIFIER  LP parameters RP NJOY statements return_statement END 
               ;
statements: statements statement | statement 
          ; 
statement :  iteration_statement | comment | assignment_statement | 
             declarative_statement| predicate_call SEMICOLON | input_statement | output_statement |if_statement | return_statement
          ;
if_statement: IF LP logical_expression RP NJOY statements END| 
              IF LP logical_expression RP NJOY statements END ELSE NJOY statements END  
                   ;
iteration_statement:  while_statement | doWhile_statement 
                   ;

while_statement: NJOY_WHILE LP logical_expression RP NJOY loop_statements END  
                            ;


doWhile_statement: DO NJOY loop_statements END NJOY_WHILE LP logical_expression 
RP SEMICOLON  
                               ;
loop_statements: loop_statements loop_statement | loop_statement 
               ;

loop_statement : iteration_statement | comment | assignment_statement | return_statement |
                 declarative_statement| predicate_call SEMICOLON | input_statement | output_statement | break_statement | if_inside_while_statement
                ;
if_inside_while_statement: IF LP logical_expression RP NJOY loop_statements END| 
                    IF LP logical_expression RP NJOY loop_statements END ELSE NJOY loop_statements END  
                    ;

return_statement: RETURN logical_expression SEMICOLON  
     			;

predicate_call: IDENTIFIER LP arguments RP 
    			; 

parameters: parameters COMMA parameter | parameter 
          			;

parameter: |TYPE_STRING IDENTIFIER | TYPE_BOOL IDENTIFIER   
            ;
arguments: arguments COMMA argument | argument
         ;

argument: logical_expression | STRING 
                ;

logical_expression: logical_expression IFF implies_term | implies_term 
                               ;
implies_term : or_term IMPLIES implies_term| or_term 
                       ;
or_term : or_term OR and_term  |  and_term 
               ;
and_term: and_term AND not_term | not_term 
                 ;
not_term: NOT LP factor RP | factor 
                ;
factor: CONST_IDENTIFIER | IDENTIFIER | BOOL| array_item | predicate_call |LP logical_expression RP
           		; 
comment : COMMENT 
        ;

break_statement : STOP_NJOY SEMICOLON  
                             ;
declarative_statement : TYPE_STRING  IDENTIFIER  SEMICOLON  | TYPE_BOOL   IDENTIFIER  SEMICOLON  
                        |constant_declaration | TYPE_STRING assignment_statement|
                         TYPE_BOOL assignment_statement| array_declaration  
			;

constant_declaration: CONST TYPE_BOOL CONST_IDENTIFIER ASSIGNMENT_OP BOOL SEMICOLON   |
                      CONST TYPE_STRING CONST_IDENTIFIER ASSIGNMENT_OP STRING SEMICOLON  
                                ;
array_declaration: TYPE_STRING ARRAY_IDENTIFIER ASSIGNMENT_OP CLB 
array_string_declarations CRB SEMICOLON   | 
                   TYPE_BOOL ARRAY_IDENTIFIER ASSIGNMENT_OP CLB 
array_bool_declarations CRB SEMICOLON  
                   ;
array_string_declarations: array_string_declarations COMMA array_string_declaration|   
                           array_string_declaration  
                           ;

array_bool_declarations:  array_bool_declarations COMMA array_bool_declaration| 
   		          array_bool_declaration 
                          ;

array_bool_declaration: STRING COLON logical_expression 
			;

array_string_declaration: STRING COLON STRING | STRING COLON CONST_IDENTIFIER | STRING COLON IDENTIFIER 
      		        ;
assignment_statement : IDENTIFIER ASSIGNMENT_OP logical_expression SEMICOLON   |  
                       IDENTIFIER ASSIGNMENT_OP STRING SEMICOLON | 
                       IDENTIFIER ASSIGNMENT_OP array_item | array_item_assignment | 
                       IDENTIFIER ASSIGNMENT_OP input_statement
      				;

input_statement : IN LP RP SEMICOLON   
                  ;

output_statement : OUT LP STRING RP SEMICOLON   
                  |OUT LP IDENTIFIER RP SEMICOLON 
                  |OUT LP BOOL RP SEMICOLON | OUT LP array_item RP SEMICOLON  
                             ;

array_item_assignment:  ARRAY_IDENTIFIER LSB STRING RSB ASSIGNMENT_OP 
STRING SEMICOLON  |
   			ARRAY_IDENTIFIER LSB STRING RSB ASSIGNMENT_OP logical_expression SEMICOLON  
                        ;



array_item: ARRAY_IDENTIFIER LSB STRING RSB
                   ;
%%
#include "lex.yy.c"
int lineno = 1;
void yyerror(char *s) {
     printf("Syntax error on line %d \n", lineno);
}
main(){
return yyparse();
}