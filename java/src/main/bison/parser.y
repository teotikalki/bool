%{
package bool;

import java.io.IOException;
%}

%language "Java"
%name-prefix ""
%define public
%define api.value.type {Union}
%error-verbose
%define lex_throws {SyntaxError}
%locations

%code {
    private Node expr;

    public Node buildAst() throws SyntaxError {
        parse();
        return expr;
    }
}

%token <Token> TOKEN_VAR
%token <Token> TOKEN_AND
%token <Token> TOKEN_OR
%token <Token> TOKEN_NOT
%token <Token> TOKEN_LPAREN
%token <Token> TOKEN_RPAREN

%left TOKEN_OR
%left TOKEN_AND 
%left UNOT

%type <Node> expr

%%

input
    : expr  { expr = $1; }
    ;

expr
    : TOKEN_VAR                       { $$ = new Var($1); }
    | expr TOKEN_AND expr             { $$ = new And($2, $1, $3); }
    | expr TOKEN_OR expr              { $$ = new Or($2, $1, $3); }
    | TOKEN_NOT expr %prec UNOT       { $$ = new Not($1, $2); }
    | TOKEN_LPAREN expr TOKEN_RPAREN  { $$ = $2; }
    ;

%%
