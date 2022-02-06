/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 1998-2018  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


/**
   This is a small example of a standalone text substitution scanner 
   It reads a name after the keyword name and substitutes all occurences 
   of "hello" with "hello <name>!". There is a sample input file 
   "sample.inp" provided in this directory 
*/

// package de.jflex.example.standalone;
import java.io.*;

%%

%class mn
%standalone
%unicode

%{

//   enum TokenName 
//   {
//     VOID, CLASS, INTERFACE, NULL, THIS, EXTENDS, IMPLEMENTS,
//     FOR, WHILE, IF, ELSE, RETURN, BREAK, CONTINUE,
//     TRUE, FALSE, NEW, NEWARRAY, PRINT, READINTEGER, READLINE,
//     DTOI, ITOD, BTOI, ITOB, PRIVATE, PROTECTED, PUBLIC, 
//     T_INTLITERAL, T_DOUBLELITERAL, T_STRINGLITERAL, T_BOOLEANLITERAL, T_ID,
//     ADD, SUB, MUL, DIV, MOD, LT, LTE, ASSIGN, EQ, NEQ, GT, GTE,
//     NOT, OR, AND, SEMICOLON, COMMA, DOT,
//     OPENBRACE, CLOSEBRACE, OPENPARENTHESES, CLOSEPARENTHESES, OPENCURLYBRACET, CLOSECURLYBRACET,
//     COMMENT, MULTILINECOMMENT 
//   };
StringBuffer string = new StringBuffer();
public static String text = new String();
  // public static Writer writer;

  // public void getToken(String value) throws IOException
  // {
	//   writer.write(value + "\n");
  // }

  // public void getToken(TokenName token, String value) throws IOException
  // {
  //   writer.write(token.toString() + " " + value + "\n");
  // }

%}
// %%

// %public
// %class Subst
// %standalone

// // %unicode
// // %cup
// // %line
// // %column

// %{
//    public static Writer writer;

//    StringBuffer string = new StringBuffer();
   
//   public void getToken(String value) throws IOException
//   {
// 	  writer.write(value + "\n");
//   }

//   public void getToken(TokenName token, String value) throws IOException
//   {
//     writer.write(token.toString() + " " + value + "\n");
//   }
// %}

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
DOUBLELITERAL = [0-9]+"."[0-9]*[[[eE] [-+]]? [0-9]*[0-9]+]?
OPERATOR = ("+"|"-"|"*"|"/"|"%"|"="|"<"|">"|"."|","|";"|"!"|"("|")"|"["|"]"|"{"|"}"|"<="|"!="|">="|"&&"|"=="|"||")
BOOLEANLITERAL = ("true" | "false")
// comments = CommentContent|DocumentationCommen|EndOfLineComment|TraditionalComment
%state STRING

%%
<YYINITIAL> {
/*******Keywords************/
void         { text = text.concat("void\n");}
int         { text = text.concat("int\n");}
double         { text = text.concat("double\n");}
bool       { text = text.concat("bool\n");}
string       { text = text.concat("string\n");}
class       { text = text.concat("class\n");}
null       { text = text.concat("null\n");}
for       { text = text.concat("for\n");}
while       { text = text.concat("while\n");}
if       { text = text.concat("if\n");}
else       {text = text.concat("else\n");}
return       {text = text.concat("return\n");}
break       { text = text.concat("break\n");}
new       { text = text.concat("new\n");}
this       { text = text.concat("this\n");}
NewArray       { text = text.concat("NewArray\n");}
Print       {text = text.concat("Print\n");}
ReadInteger      { text = text.concat("ReadInteger\n");}
ReadLine     { text = text.concat("ReadLine\n");}
import     { text = text.concat("import\n");}

/*******Define method*********/
// "Define "[:jletter:] [:jletterdigit:]* {methode = yytext().substring(5);}


/******BOOLEANLITERAL********/
{BOOLEANLITERAL} {text = text.concat("T_BOOLEANLITERAL "+yytext()+"\n");}


/*******Identification*******/
{Identifier} { text = text.concat("T_ID "+yytext()+"\n");}


/*******DOUBLELITERAL*******/
{DOUBLELITERAL} { text = text.concat("T_DOUBLELITERAL "+yytext()+"\n");}


/********INTLITERAL*********/
{DecIntegerLiteral} { text = text.concat("T_INTLITERAL "+yytext()+"\n");}
{HexIntegerLiteral} { text = text.concat("T_INTLITERAL "+yytext()+"\n");}


/********OPERATOR***********/
{OPERATOR} { text = text.concat(yytext()+"\n");} 


/******BOOLEANLITERAL******/

/*********STRING***********/
\"  {string.setLength(0); yybegin(STRING);}
// "dsfdg"
}
<STRING>{
\" {  text = text.concat("T_STRINGLITERAL "+'"'+string.toString()+'"'+"\n"); yybegin(YYINITIAL);}

[^]+ { string.append( yytext() ); }
}
// {LineTerminator}  {/* Ignore*/}
{WhiteSpace}      {/* Ignore*/}
// {EndOfLineComment} {/* Ignore*/}
// {TraditionalComment} {/*Ignore*/}
{Comment} {/*Ingnore*/}
// {Comment} {/*Ignore*/}
// {Identifier} { System.out.println("T_id");}

// [^] { throw new Error("Illegal character <"+yytext()+">"); }