lowercase               [a-z]
uppercase               [A-Z]
digit                   [0-9]
letter                  [A-Za-z]
alphanumeric            ({letter}|{digit})
identifier              ({letter}{alphanumeric}*)
constant_identifier     ((\#){identifier})
array_identifier        ((\@){identifier})
program_identifier      ((\~){uppercase}{alphanumeric}*)
characters              ((\!)|(\@)|(\#)|(\#)|(\$)|(\%)|(\^)|(\&)|(\*)|(\()|(\))|(\-)|(\_)|(\+)|(\=)|(\ )|(\,)|(\.)|(\/)|(\?)|(\>)|(\<)|(\})|(\{)|(\\)|(\`)|(\~))
elements_of_string      ({alphanumeric}|{digit}|{characters})
string                  ((\")({elements_of_string})*(\"))
comment                 ((\/)(\*)({elements_of_string})*(\*)(\/))
whitespace              ([ |\t|\n|\r]*)
%%
IF                      {return(IF);}
NJOY                    {return(NJOY);}
END                     {return(END);}
CONST                   {return(CONST);}
NJOY_WHILE              {return(NJOY_WHILE);}
DO                      {return(DO);}
ELSE                    {return(ELSE);}  
RETURN                  {return(RETURN);}
STOP_NJOY               {return(STOP_NJOY);}
IMPLIES                 {return(IMPLIES);}
AND	                {return(AND);}
OR                      {return(OR);}
IFF                     {return(IFF);}
NOT                     {return(NOT);}
PROGRAM                 {return(PROGRAM);}
END_PROGRAM             {return(END_PROGRAM);}
FALSE                   {return(BOOL);}
TRUE                    {return(BOOL);}
OUT                     {return(OUT);}
IN                      {return(IN);}
STRING                  {return(TYPE_STRING);}
BOOL                    {return(TYPE_BOOL);}
{program_identifier}    {return(PROGRAM_IDENTIFIER);}
{identifier}            {return(IDENTIFIER);}
{constant_identifier}   {return(CONST_IDENTIFIER);}
{array_identifier}      {return(ARRAY_IDENTIFIER);}
{comment}               {return(COMMENT);}
{string}                {return(STRING);}
\[                      {return(LSB);}
\]                      {return(RSB);}
\{                      {return(CLB);}
\}                      {return (CRB);}
\(                      {return(LP);}
\)                      {return (RP);}
\;                      {return (SEMICOLON);}
\,                      {return (COMMA);}
\:                      {return(COLON);}  
\=                      {return (ASSIGNMENT_OP);}
\n                      {extern int lineno; lineno++;}
%%
int yywrap() {return 1;}


