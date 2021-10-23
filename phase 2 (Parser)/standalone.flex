
import java.io.*;
import java_cup.runtime.*;

%%

%public
%class lexer
// %standalone
%unicode
%type Symbol
%cup



%{

public Symbol token(int tokentype){
  System.out.println(yytext());
  return new Symbol (tokentype,yytext());
}



StringBuffer string = new StringBuffer();
public String text = new String();
  

%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.

EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*
Identifier = [:jletter:] [:jletterdigit:]*
DecIntegerLiteral = [0-9][0-9]*
HexIntegerLiteral = [0][xX][0-9a-fA-F]+ 
DOUBLELITERAL = [0-9]+\.[0-9]*[Ee][-+]?[0-9]+
OPERATOR = ("not"|"~"|"&"|"and"|"|"|"or"|"^"|"+="|"-"|"++"|"--"|"-="|"*="|"/="|":")
BOOLEANLITERAL = ("true" | "false")

StringLiteral = \"[^(\\n|\\r)]~\"
// comments = CommentContent|DocumentationCommen|EndOfLineComment|TraditionalComment
%state STRING

%%
<YYINITIAL> {
/*******Keywords************/
"this" { return symbol(sym.THIS); }
"extends" {return symbol (sym.EXTENDS); }
"implements" { return symbol(sym.IMPLEMENTS); }
"for" { return symbol(sym.FOR);}
"continue" { return symbol(sym.CONTINUE); }
"true" { return symbol(sym.BOOLCONSTANT, yytext()); }
"false" { return symbol(sym.BOOLCONSTANT, yytext()); }
"new" {return symbol(sym.NEW); }
"NewArray" { return symbol(sym.NEWARRAY); }
"Print" { return symbol(sym.PRINT); }
"ReadInteger" { return symbol(sym.READINTEGER); }
"ReadLine" { return symbol(sym.READLINE); }
"void" { return symbol (sym.VOID); }
"class" { return symbol(sym.CLASS); }
"interface" { return symbol(sym.INTERFACE); }
"null" { return symbol(sym.NULL); }
"dtoi" { return symbol(sym.DTOI); }
"itod" { return symbol(sym.ITOD); }
"btoi" { return symbol(sym.BTOI); }
"itob" { return symbol(sym.ITOB); }
"private" { return symbol (sym.PRIVATE); }
"protected" { return symbol(sym.PROTECTED); }
"while" { return symbol(sym.WHILE); }
"if" { return symbol (sym.IF);}
"else" { return symbol(sym.ELSE) ;}
"return" { return symbol(sym.RETURN); }
"break" { return symbol(sym.BREAK); }
"public" { return symbol(sym.PUBLIC); }
"int" { return symbol(sym.INT); }
"double" { return symbol(sym.DOUBLE); }
"bool" { return symbol(sym.BOOLEAN); }
"string" { return symbol(sym.STRING); }
"import "     {  return symbol(sym.IMPORT);}
"__line__"    { return symbol(sym.__LINE__);}
"__func__"    { return symbol(sym.__FUNC__);}

/*******Define method*********/
// "Define "[:jletter:] [:jletterdigit:]* {methode = yytext().substring(5);}


/******BOOLEANLITERAL********/
{BOOLEANLITERAL} {text = text.concat("T_BOOLEANLITERAL "+yytext()+"\n");}


/*******Identification*******/
{Identifier} { text = text.concat("T_ID "+yytext()+"\n");}


/*******DOUBLELITERAL*******/
{DOUBLELITERAL} { text = text.concat("T_DOUBLELITERAL "+yytext()+"\n");}
[0-9]+\.[0-9]* { text = text.concat("T_DOUBLELITERAL "+yytext()+"\n");}

/********INTLITERAL*********/
{DecIntegerLiteral} { text = text.concat("T_INTLITERAL "+yytext()+"\n");}
{HexIntegerLiteral} { text = text.concat("T_INTLITERAL "+yytext()+"\n");}


/********OPERATOR***********/

"+" { return symbol(sym.PLUS); }
"-" { return symbol(sym.MINUS); }
"*" { return symbol(sym.MULT); }
"/" { return symbol(sym.DIV); }
"%" { return symbol(sym.MOD); }
"=" { return symbol(sym.ASSIGN); }
"==" { return symbol(sym.EQEQ); }
"!=" { return symbol(sym.NOTEQ); }
"<" { return symbol(sym.LT); }
"<=" { return symbol (sym.LTEQ); }
">" { return symbol(sym.GT); }
">=" { return symbol(sym.GTEQ); }
"&&" { return symbol (sym.ANDAND); }
"||" { return symbol (sym.OROR);}
"!" { return symbol (sym.NOT); }
";" { return symbol(sym.SEMICOLON); }
"," { return symbol(sym.COMMA); }
"." {return symbol (sym.DOT); }
"[" { return symbol (sym.LEFTBRACK); }
"]" { return symbol (sym.RIGHTBRACK); }
"(" { return symbol (sym.LEFTPAREN); }
")" { return symbol (sym.RIGHTPAREN); }
"{" { return symbol (sym.LEFTAKULAD); }
"}" { return symbol (sym.RIGHTAKULAD); }


/******BOOLEANLITERAL******/

/*********STRING***********/
\"  {string.setLength(0); yybegin(STRING);}
// "dsfdg"
}

<STRING> {
\" {  text = text.concat("T_STRINGLITERAL "+'"'+string.toString()+yytext()+"\n"); yybegin(YYINITIAL); }

  \\\' { string.append("\\\'"); }
    \\t { string.append("\\t"); }
    \\n { string.append("\\n"); }
    \\r { string.append("\\r"); }
    \\\" { string.append("\\\""); }
    \\ { string.append("\\"); }
    \\b { string.append("\\b"); }
    \\v { string.append("\\v"); }
    \\f { string.append("\\f"); }
    \\0 { string.append("\\0"); }
    [^\n\r\"\\]* { string.append( yytext() ); }
}

{WhiteSpace}      {/* Ignore*/}

{Comment} {/*Ingnore*/}

[^] { throw new Error("Illegal character <"+yytext()+">"); }