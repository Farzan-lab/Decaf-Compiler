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

%class mainn
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
class Token {
String text;
Token(String t){text = t;}
}
  public static Writer writer;
  StringBuffer string = new StringBuffer();

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
DecIntegerLiteral = 0 | [1-9][0-9]*
HexIntegerLiteral = [0][xX][0-9a-fA-F]+ 
DOUBLELITERAL = [0-9]+"."[0-9]*[[[eE] [-+]]? [0-9]*[0-9]+]?
OPERATOR = ("+"|"-"|"*"|"/"|"%"|"="|"<"|">"|"."|","|";"|"!"|"("|")"|"["|"]"|"{"|"}"|"<="|"!="|">="|"&&"|"=="|"||")
BOOLEANLITERAL = ("true" | "false")
// comments = CommentContent|DocumentationCommen|EndOfLineComment|TraditionalComment
%state STRING

%%
// <YYINITIAL> {
/*******Keywords************/
void         { return new Token(yytext());}
// int         { writer.write(yytext() + "\n");}
// double         { writer.write(yytext() + "\n");}
// bool       { writer.write(yytext() + "\n");}
// string       { writer.write(yytext() + "\n");}
// class       { writer.write(yytext() + "\n");}
// null       { writer.write(yytext() + "\n");}
// for       { writer.write(yytext() + "\n");}
// while       { writer.write(yytext() + "\n");}
// if       { writer.write(yytext() + "\n");}
// else       { writer.write(yytext() + "\n");}
// return       { writer.write(yytext() + "\n");}
// break       { writer.write(yytext() + "\n");}
// new       { writer.write(yytext() + "\n");}
// this       { writer.write(yytext() + "\n");}
// NewArray       { writer.write(yytext() + "\n");}
// Print       { writer.write(yytext() + "\n");}
// ReadInteger      { writer.write(yytext() + "\n");}
// ReadLine     { writer.write(yytext() + "\n");}

// /******BOOLEANLITERAL********/
// {BOOLEANLITERAL} { writer.write("T_BOOLEANLITERAL " + yytext() + "\n");}


// /*******Identification*******/
// {Identifier} { writer.write("T_ID " + yytext() + "\n");}


// /*******DOUBLELITERAL*******/
// {DOUBLELITERAL} { writer.write("T_DOUBLELITERAL " + yytext() + "\n");}


// /********INTLITERAL*********/
// {DecIntegerLiteral} { writer.write("T_INTLITERAL " + yytext() + "\n");}
// {HexIntegerLiteral} {writer.write("T_INTLITERAL " + yytext() + "\n"); System.out.println(" "+yytext());}

// //writer.write(" " + yytext() + "\n");
// /********OPERATOR***********/
// {OPERATOR} { writer.write(yytext() + "\n");} 


// /******BOOLEANLITERAL******/

// /*********STRING***********/
// \"  {string.setLength(0); yybegin(STRING);}

// }
// <STRING>{
// \" { writer.write("I_STRINGLITERAL "+'"'+string.toString()+'"'+ "\n"); yybegin(YYINITIAL);}

// [^\n\r\"\\]+ { string.append( yytext() ); }
// }
// // {LineTerminator}  {/* Ignore*/}
// {WhiteSpace}      {/* Ignore*/}
// // {EndOfLineComment} {/* Ignore*/}
// // {TraditionalComment} {/*Ignore*/}
// {Comment} {/*Ingnore*/}
// // {Comment} {/*Ignore*/}
// // {Identifier} { System.out.println("T_id");}

// // [^] { throw new Error("Illegal character <"+yytext()+">"); }