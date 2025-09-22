package Parse;
import ErrorMsg.ErrorMsg;

%% 

%implements Lexer
%function nextToken
%type java_cup.runtime.Symbol
%char

%{
private void newline() {
  errorMsg.newline(yychar);
}

private void err(int pos, String s) {
  errorMsg.error(pos,s);
}

private void err(String s) {
  err(yychar,s);
}

private java_cup.runtime.Symbol tok(int kind) {
    return tok(kind, null);
}

private java_cup.runtime.Symbol tok(int kind, Object value) {
    return new java_cup.runtime.Symbol(kind, yychar, yychar+yylength(), value);
}

private ErrorMsg errorMsg;

Yylex(java.io.InputStream s, ErrorMsg e) {
  this(s);
  errorMsg=e;
}

%}

%eofval{
	{
	 return tok(sym.EOF, null);
        }
%eofval}       


%%
" "	                   {}
"\n"	                   { newline(); }
.                      { err("Illegal character: " + yytext()); }

","	                   { return tok(sym.COMMA, null); }
";"	                   { return tok(sym.SEMICOLON, null); }
":"	                   { return tok(sym.COLON, null); }
"~"                    { return tok(sym.TILDE, null); }
"."                    { return tok(sym.PERIOD, null); }
"..."                  { return tok(sym.ELIPSES, null); }

"{"                    { return tok(sym.LBRACE); }
"}"                    { return tok(sym.RBRACE); }
"("                    { return tok(sym.LPAREN); }
")"                    { return tok(sym.RPAREN); }
"["                    { return tok(sym.LBRACK); }
"]"                    { return tok(sym.RBRACK); }

"if"                   { return tok(sym.IF); }
"else"                 { return tok(sym.ELSE); }
"while"                { return tok(sym.WHILE); }
"do"                   { return tok(sym.DO); }
"for"                  { return tok(sym.FOR); }
"break"                { return tok(sym.BREAK); }
"continue"             { return tok(sym.CONTINUE); }

[a-zA-Z_][a-zA-Z0-9_]* { return tok(sym.ID, yytext()); }
[0-9]*\\.[0-9]+([eE][+-]?[0-9]+)? { return tok(sym.FLOAT, yytext()); }
"0x"[0-9a-fA-F]+       {  return tok(sym.HEX_LITERAL, yytext()); }
"0"[0-7]*          {  return tok(sym.OCTAL_LITERAL, Integer.parseInt(yytext(), 8)); }
[0-9]+("."[0-9]*)?    { return tok(sym.DECIMAL_LITERAL, yytext()); }
[+-]?[0-9]+         { return tok(sym.INTEGER_LITERAL, yytext()); }
\"([^\"\\]|\\.)*\"     { return tok(sym.STRING_LITERAL, yytext()); }
"//".*            { /*skip single line comments*/}
"/*"([^*]*\*+)*"/"     { /*skip multi line comments*/}

"+"                    { return tok(sym.PLUS); }
"-"                    { return tok(sym.MINUS); }
"*"                    { return tok(sym.TIMES); }
"/"                    { return tok(sym.DIVIDE); }
"%"                    { return tok(sym.MODULUS); }
"="                    { return tok(sym.ASSIGN); }
"+="                   { return tok(sym.ADDASSIGN); }
"-="                   { return tok(sym.SUBASSIGN); }
"*="                   { return tok(sym.MULASSIGN); }
"/="                   { return tok(sym.DIVASSIGN); }
"%="                   { return tok(sym.MODASSIGN); }

"=="                   { return tok(sym.EQ); }
"!="                   { return tok(sym.NEQ); }
">"                    { return tok(sym.GT); }
"<"                    { return tok(sym.LT); }
">="                   { return tok(sym.GE); }
"<="                   { return tok(sym.LE); }

"&&"                   { return tok(sym.AND); }
"||"                   { return tok(sym.OR); }
"&"                    { return tok(sym.BITWISEAND); }
"|"                    { return tok(sym.BWISEOR); }
"^"                    { return tok(sym.BWISEXOR); }
"|="                   { return tok(sym.BWISEORASSIGN); }
"^="                   { return tok(sym.BWISEXORASSIGN); }
"++"                   { return tok(sym.INCREMENT); }
"--"                   { return tok(sym.DECREMENT); }
">>"                   { return tok(sym.RSHIFT); }
"<<"                   { return tok(sym.LSHIFT); }
">>="                  { return tok(sym.RSHIFTASSIGN); }
"<<="                  { return tok(sym.LSHIFTASSIGN); }
"->"                   { return tok(sym.ARROW); }