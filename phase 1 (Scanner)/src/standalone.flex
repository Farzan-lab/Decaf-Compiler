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

// %unicode
// %cup
// %line
// %column

%{
   StringBuffer string = new StringBuffer();
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
HexIntegerLiteral = [0][xX][0-9a-fA-F]+ 
DOUBLELITERAL = [0-9]+"."[0-9]*[[[eE] [-+]]? [0-9]*[0-9]+]?
OPERATOR = ("+"|"-"|"*"|"/"|"%"|"="|"<"|">"|"."|","|";"|"!"|"("|")"|"["|"]"|"{"|"}"|"<="|"!="|">="|"&&"|"=="|"||")
BOOLEANLITERAL = ("true" | "false")
// comments = CommentContent|DocumentationCommen|EndOfLineComment|TraditionalComment
%state STRING

%%
<YYINITIAL> {
/*******Keywords************/
void         { System.out.println("void");}
int         { System.out.println("int");}
double         { System.out.println("double");}
bool       { System.out.println("bool");}
string       { System.out.println("string");}
class       { System.out.println("class");}
null       { System.out.println("null");}
for       { System.out.println("for");}
while       { System.out.println("while");}
if       { System.out.println("if");}
else       { System.out.println("else");}
return       { System.out.println("return");}
break       { System.out.println("break");}
new       { System.out.println("new");}
this       { System.out.println("this");}
NewArray       { System.out.println("NewArray");}
Print       { System.out.println("Print");}
ReadInteger      { System.out.println("ReadInteger");}
ReadLine     { System.out.println("ReadLine");}

/******BOOLEANLITERAL********/
{BOOLEANLITERAL} {System.out.println("T_BOOLEANLITERAL "+yytext());}


/*******Identification*******/
{Identifier} { System.out.println("T_ID "+yytext());}


/*******DOUBLELITERAL*******/
{DOUBLELITERAL} { System.out.println("T_DOUBLELITERAL "+yytext());}


/********INTLITERAL*********/
{DecIntegerLiteral} { System.out.println("T_INTLITERAL "+yytext());}
{HexIntegerLiteral} { System.out.println("T_INTLITERAL "+yytext());}


/********OPERATOR***********/
{OPERATOR} { System.out.println(yytext());} 


/******BOOLEANLITERAL******/

/*********STRING***********/
\"  {string.setLength(0); yybegin(STRING);}

}
<STRING>{
\" { System.out.println("I_STRINGLITERAL "+'"'+string.toString()+'"'); yybegin(YYINITIAL);}

[^\n\r\"\\]+ { string.append( yytext() ); }
}
// {LineTerminator}  {/* Ignore*/}
{WhiteSpace}      {/* Ignore*/}
// {EndOfLineComment} {/* Ignore*/}
// {TraditionalComment} {/*Ignore*/}
{Comment} {/*Ingnore*/}
// {Comment} {/*Ignore*/}
// {Identifier} { System.out.println("T_id");}

// [^] { throw new Error("Illegal character <"+yytext()+">"); }