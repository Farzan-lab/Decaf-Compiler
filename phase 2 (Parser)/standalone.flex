
import java.io.*;
import java_cup.runtime.*;

// import parser.sym;
%%
// %implements sym
%public
%class Lexer
%standalone
%unicode
%type Symbol
%cup



%{

    private Symbol symbol(int type) {
    System.out.println(yytext());
		return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
      System.out.println(yytext());
    	return new Symbol(type, yyline, yycolumn, value);
    }

  StringBuilder string;
  StringBuilder character;
public String text = new String();
  

%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
Float = {DecInt}.{DecInt}
SciFloat = (({DecInt} | {Float}) ("e" | "E") ("+" | "-")? {DecInt})

EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*
Identifier = [:jletter:] [:jletterdigit:]*
DecIntegerLiteral = [0-9][0-9]*

Float = {DecIntegerLiteral}.{DecIntegerLiteral}
SciFloat = (({DecIntegerLiteral} | {Float}) ("e" | "E") ("+" | "-")? {DecIntegerLiteral})

HexIntegerLiteral = [0][xX][0-9a-fA-F]+ 
DOUBLELITERAL = [0-9]+\.[0-9]*[Ee][-+]?[0-9]+
// OPERATOR = (":")
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
"true" { return symbol(sym.True); }
"false" { return symbol(sym.False); }
"new" {return symbol(sym.NEW); }
"float" { return symbol(sym.FLOAT);  }
"const" { return symbol(sym.CONST); }
"NewArray" { return symbol(sym.NEWARRAY); }
"repeat"   { return symbol(sym.REPEAT); }
"Print" { return symbol(sym.PRINT); }
"ReadInteger" { return symbol(sym.READINTEGER); }
"ReadLine" { return symbol(sym.READLINE); }
"void" { return symbol (sym.VOID); }
"class" { return symbol(sym.CLASS); }
"interface" { return symbol(sym.INTERFACE); }
"null" { return symbol(sym.NULL); }
"long" { return symbol(sym.LONG); }
"NULL" { return symbol(sym.NULL); }
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
"bool" { return symbol(sym.BOOLEAN); }
"double" { return symbol(sym.DOUBLE); }
"string" { return  symbol(sym.STRING); }
"until"  { return  symbol(sym.UNTIL); }
"import "     {  return symbol(sym.IMPORT);}
"__line__"    { return symbol(sym.__LINE__);}
"function"			 { return symbol(sym.FUNCTION); }
"__func__"    { return symbol(sym.__FUNC__);}
"begin"				 { return symbol(sym.BEGIN); }
"record"			 { return symbol(sym.RECORD); }
"end"				   { return symbol(sym.END); }
"of"           { return symbol(sym.OF); }
"extern"       { return symbol(sym.EXTERND); }
"char"         { return symbol(sym.CHAR); }
"sizeof"       { return symbol(sym.SIZEOF); }
"default"      { return symbol(sym.DEFAULT); }
"case"         {return symbol(sym.CASE);}
"switch"       {return symbol(sym.SWITCH);}
"auto"         {return symbol(sym.AUTO);} 
/*******Define method*********/
// "Define "[:jletter:] [:jletterdigit:]* {methode = yytext().substring(5);}


/******BOOLEANLITERAL********/
// {BOOLEANLITERAL} {return token( Sym.T_BOOLEANLITERAL, yytext() );}


/*******Identification*******/
{Identifier} { return symbol(sym.ID, new String(yytext())); }


/*******DOUBLELITERAL*******/
{DOUBLELITERAL} { return symbol(sym.DOUBLECONST, yytext()); }
[0-9]+\.[0-9]* { return symbol(sym.DOUBLECONST, yytext()); }

/********INTLITERAL*********/
{DecIntegerLiteral} { return symbol(sym.INTCONST, new Integer(yytext())); }
{HexIntegerLiteral} { return symbol (sym.INTCONST, yytext()); }

/**********FLOAT***********/
{Float} { return symbol(sym.FLOATCONST, new Double(yytext())); }
{SciFloat} { return symbol(sym.FLOATCONST, new Double(yytext())); }

/********OPERATOR***********/
"+"   { return symbol(sym.PLUS); }
"-"   { return symbol(sym.MINUS); }
"*"   { return symbol(sym.MULT); }
"/"   { return symbol(sym.DIV); }
"%"   { return symbol(sym.MOD); }
"="   { return symbol(sym.ASSIGN); }
"=="  { return symbol(sym.EQEQ); }
"!="  { return symbol(sym.NOTEQ); }
"<"   { return symbol(sym.LT); }
"<="  { return symbol (sym.LTEQ); }
">"   { return symbol(sym.GT); }
">="  { return symbol(sym.GTEQ); }
"&&"  { return symbol (sym.ANDAND); }
"|"	  { return symbol(sym.ARITHOR); }
"or"  { return symbol(sym.LOGICOR); }
"||"  { return symbol (sym.OROR);}
"!"   { return symbol (sym.LOGICSIGHN); }
";"   { return symbol(sym.SEMICOLON); }
","   { return symbol(sym.COMMA); }
"."   {return symbol (sym.DOT); }
"["   { return symbol (sym.LEFTBRACK); }
"]"   { return symbol (sym.RIGHTBRACK); }
"("   { return symbol (sym.LEFTPAREN); }
")"   { return symbol (sym.RIGHTPAREN); }
"{"   { return symbol (sym.LEFTAKULAD); }
"}"   { return symbol (sym.RIGHTAKULAD); }
"++"  { return symbol(sym.INC); } //increase
"--"  { return symbol(sym.DEC); } //decrease
"+="  { return symbol(sym.ADDASS); }
"-="  { return symbol(sym.SUBASS); } 
"*="  { return symbol(sym.MULTASS); }
"/="  { return symbol(sym.DIVASS); }
"not" { return symbol(sym.NOT); }
"~"	  { return symbol(sym.BITNEG); }
"&"	  { return symbol(sym.ARITHAND); }
"and" { return symbol(sym.LOGICAND); }
"^"   { return symbol(sym.XOR); }
":"   { return symbol(sym.COLON); }

/*********STRING***********/
\"  { string = new StringBuilder("\""); yybegin(STRING);}
// "dsfdg"
}

<STRING> {
\" {  string.append("\"");
	    yybegin(YYINITIAL);
	    return symbol(sym.STRINGCONST, new String(string.toString()));
      }

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