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
OPERATOR = ("+"|"-"|"*"|"/"|"%"|"="|"<"|">"|"."|","|";"|"!"|"("|")"|"["|"]"|"{"|"}"|"<="|"!="|">="|"&&"|"=="|"||"|"+"|"-"|"*"|"/"|"%"|"<"|"<="|">"|">="|"="|"=="|"!="|"&&"|"||"|"!"|";"|","|"."|"["|"]"|"("|")"|"{"|"}"|"=="|"!="|"<="|"<"|">"|">="|"="|"not"|"~"|"&"|"and"|"|"|"or"|"^"|"*"|"+"|"+="|"-"|"++"|"--"|"-="|"*="|"/="|"/"|"%"|"{"|"}"|"("|")"|"."|","|":"|";"|"["|"]")
BOOLEANLITERAL = ("true" | "false")

StringLiteral = \"[^(\\n|\\r)]~\"
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
import      { text = text.concat("import\n");}
__line__    {text = text.concat("__line__\n");}
__func__    {text = text.concat("__func__\n");}
btoi        {text = text.concat("btoi\n");}
continue    {text = text.concat("continue\n");}
dtoi      {text = text.concat("dtoi\n");}
itob    {text = text.concat("itob\n");}
itod    {text = text.concat("itod\n");}
private {text = text.concat("private\n");}
public {text = text.concat("public\n");}

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
{OPERATOR} { text = text.concat(yytext()+"\n");} 


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