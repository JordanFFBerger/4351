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
" "	        {}
\n	        { newline(); }
","	        { return tok(sym.COMMA, null); }
";"	        { return tok(sym.SEMICOLON, null); }
":"	        { return tok(sym.COLON, null); }
"~"         { return tok(sym.TILDE, null); }
"."         { return tok(sym.PERIOD, null); }
.           { err("Illegal character: " + yytext()); }
"if"        { return tok(sym.IF); }
"else"      { return tok(sym.ELSE); }
"while"     { return tok(sym.WHILE); }
"do"        { return tok(sym.DO); }
[a-zA-Z_][a-zA-Z0-9_]* { return tok(sym.STRING_LITERAL, yytext()); }
[0-9]+      { return tok(sym.INTEGER_LITERAL, yytext()); }
"+"         { return tok(sym.PLUS); }
"-"         { return tok(sym.MINUS); }
"*"         { return tok(sym.TIMES); }
"/"         { return tok(sym.DIVIDE); }
">"         { return tok(sym.GT); }
"<"         { return tok(sym.LT); }
"="         { return tok(sym.EQ); }
"!="        { return tok(sym.NEQ); }
">="        { return tok(sym.GE); }
"<="        { return tok(sym.LE); }
"&&"        { return tok(sym.AND); }
"||"        { return tok(sym.OR); }
"i++"       { return tok(sym.INCREMENT); }
"i--"       { return tok(sym.DECREMENT); }