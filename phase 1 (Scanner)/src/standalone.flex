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

%%

%public
%class Subst
%standalone

%unicode

%{
  String name;
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
DecIntegerLiteral = 0 | [1-9][0-9]*

%%

"name " [a-zA-Z]+  { name = yytext().substring(5); }
[Hh] "ello"        { System.out.print(yytext()+" "+name+"!"); }
{LineTerminator} {/* Ignore*/}