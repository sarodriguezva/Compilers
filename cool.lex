/*
 *  The scanner definition for COOL.
 *  Santiago Rodriguez Vallejo and Jose Ignacio Suarez Montiel
 *  Universidad Nacional de Colombia, Bogota. 2023-II
 */

import java_cup.runtime.Symbol;

%%

%{

/*  Stuff enclosed in %{ %} is copied verbatim to the lexer class
 *  definition, all the extra variables/functions you want to use in the
 *  lexer actions should go here.  Don't remove or modify anything that
 *  was there initially.  */

  // Max size of string constants
  static int MAX_STR_CONST = 1025;

  // For assembling string constants
  StringBuffer string_buf = new StringBuffer();

  private int comment_level = 0;

  private int curr_lineno = 1;
  int get_curr_lineno() {
    return curr_lineno;
  }

  private AbstractSymbol filename;

  void set_filename(String fname) {
    filename = AbstractTable.stringtable.addString(fname);
  }

  AbstractSymbol curr_filename() {
    return filename;
  }
%}

%init{

/*  Stuff enclosed in %init{ %init} is copied verbatim to the lexer
 *  class constructor, all the extra initialization you want to do should
 *  go here.  Don't remove or modify anything that was there initially. */

  // empty for now
%init}

%eofval{

/*  Stuff enclosed in %eofval{ %eofval} specifies java code that is
 *  executed when end-of-file is reached.  If you use multiple lexical
 *  states and want to do something special if an EOF is encountered in
 *  one of those states, place your code in the switch statement.
 *  Ultimately, you should return the EOF symbol, or your lexer won't
 *  work.  */

  switch(yy_lexical_state) {
    case YYINITIAL:
      break;
    case COMMENT:
      yybegin(YYINITIAL);
      return new Symbol(TokenConstants.ERROR, "EOF in comment");
    case STRING:
      yybegin(YYINITIAL);
      return new Symbol(TokenConstants.ERROR, "EOF in string constant");
    case ERROR:
      yybegin(YYINITIAL);
      return new Symbol(TokenConstants.ERROR, "EOF in String");
    case BACKSLASH:
      yybegin(YYINITIAL);
      return new Symbol(TokenConstants.ERROR, "EOF in String");
  }
  return new Symbol(TokenConstants.EOF);
%eofval}

%class CoolLexer
%cup


%state STRING
%state COMMENT
%state LINECOMMENT
%state BACKSLASH
%state ERROR

A = [aA]
B = [bB]
C = [cC]
D = [dD]
E = [eE]
F = [fF]
G = [gG]
H = [hH]
I = [iI]
J = [jJ]
K = [kK]
L = [lL]
M = [mM]
N = [nN]
O = [oO]
P = [pP]
Q = [qQ]
R = [rR]
S = [sS]
T = [tT]
U = [uU]
V = [vV]
W = [wW]
X = [xX]
Y = [yY]
Z = [zZ]
%%

<YYINITIAL>{C}{L}{A}{S}{S} { return new Symbol(TokenConstants.CLASS); }
<YYINITIAL>{E}{L}{S}{E} { return new Symbol(TokenConstants.ELSE); }
<YYINITIAL>{F}{I} { return new Symbol(TokenConstants.FI); }
<YYINITIAL>{I}{F} { return new Symbol(TokenConstants.IF); }
<YYINITIAL>{I}{N} { return new Symbol(TokenConstants.IN); }
<YYINITIAL>{I}{N}{H}{E}{R}{I}{T}{S} { return new Symbol(TokenConstants.INHERITS); }
<YYINITIAL>{L}{E}{T} { return new Symbol(TokenConstants.LET); }
<YYINITIAL>{L}{O}{O}{P} { return new Symbol(TokenConstants.LOOP); }
<YYINITIAL>{P}{O}{O}{L} { return new Symbol(TokenConstants.POOL); }
<YYINITIAL>{T}{H}{E}{N} { return new Symbol(TokenConstants.THEN); }
<YYINITIAL>{W}{H}{I}{L}{E} { return new Symbol(TokenConstants.WHILE); }
<YYINITIAL>{C}{A}{S}{E} { return new Symbol(TokenConstants.CASE); }
<YYINITIAL>{E}{S}{A}{C} { return new Symbol(TokenConstants.ESAC); }
<YYINITIAL>{O}{F} { return new Symbol(TokenConstants.OF); }
<YYINITIAL>{N}{E}{W} { return new Symbol(TokenConstants.NEW); }
<YYINITIAL>{I}{S}{V}{O}{I}{D} { return new Symbol(TokenConstants.ISVOID); }
<YYINITIAL>{N}{O}{T} { return new Symbol(TokenConstants.NOT); }

<YYINITIAL>"=>" { return new Symbol(TokenConstants.DARROW); }
<YYINITIAL>"<-" { return new Symbol(TokenConstants.ASSIGN); }
<YYINITIAL>"<=" { return new Symbol(TokenConstants.LE); }
<YYINITIAL>"+" { return new Symbol(TokenConstants.PLUS); }
<YYINITIAL>"/" { return new Symbol(TokenConstants.DIV); }
<YYINITIAL>"-" { return new Symbol(TokenConstants.MINUS); }
<YYINITIAL>"*" { return new Symbol(TokenConstants.MULT); }
<YYINITIAL>"=" { return new Symbol(TokenConstants.EQ); }
<YYINITIAL>"<" { return new Symbol(TokenConstants.LT); }
<YYINITIAL>"." { return new Symbol(TokenConstants.DOT); }
<YYINITIAL>"~" { return new Symbol(TokenConstants.NEG); }
<YYINITIAL>"," { return new Symbol(TokenConstants.COMMA); }
<YYINITIAL>";" { return new Symbol(TokenConstants.SEMI); }
<YYINITIAL>":" { return new Symbol(TokenConstants.COLON); }
<YYINITIAL>"(" { return new Symbol(TokenConstants.LPAREN); }
<YYINITIAL>")" { return new Symbol(TokenConstants.RPAREN); }
<YYINITIAL>"@" { return new Symbol(TokenConstants.AT); }
<YYINITIAL>"{" { return new Symbol(TokenConstants.LBRACE); }
<YYINITIAL>"}" { return new Symbol(TokenConstants.RBRACE); }

<YYINITIAL>[0-9]+ { return new Symbol(TokenConstants.INT_CONST, AbstractTable.inttable.addString(yytext())); }
<YYINITIAL>t{R}{U}{E} { return new Symbol(TokenConstants.BOOL_CONST, true); }
<YYINITIAL>f{A}{L}{S}{E} { return new Symbol(TokenConstants.BOOL_CONST, false); }
<YYINITIAL>[a-z][a-zA-Z0-9_]* { return new Symbol(TokenConstants.OBJECTID, AbstractTable.idtable.addString(yytext())); }
<YYINITIAL>[A-Z][a-zA-Z0-9_]* { return new Symbol(TokenConstants.TYPEID, AbstractTable.idtable.addString(yytext())); }

<YYINITIAL>\" { yybegin(STRING); string_buf.setLength(0); }
<YYINITIAL>-- { yybegin(LINECOMMENT); }
<YYINITIAL>"(*" { ++comment_level; yybegin(COMMENT); }
<YYINITIAL>"*)" { return new Symbol(TokenConstants.ERROR, "Unmatched *)"); }

<YYINITIAL>\n { curr_lineno++; }
<YYINITIAL>[ \t\f\v\r\x0B] { /* Whitespaces, do nothing */ }

<STRING>\" { yybegin(YYINITIAL); return new Symbol(TokenConstants.STR_CONST, AbstractTable.stringtable.addString(string_buf.toString())); }
<STRING>\000 { yybegin(ERROR); return new Symbol(TokenConstants.ERROR, "String contains null character"); }
<STRING>"\b" { string_buf.append('\b'); }
<STRING>"\t" { string_buf.append('\t'); }
<STRING>"\n"|\\\n { string_buf.append('\n'); }
<STRING>"\f" { string_buf.append('\f'); }
<STRING>\\\n { curr_lineno++; string_buf.append('\n'); }
<STRING>\\[^\0] { string_buf.append(yytext().charAt(1)); }
<STRING>\n { curr_lineno++; yybegin(YYINITIAL); return new Symbol(TokenConstants.ERROR, "Unterminated string constant"); }
<STRING>[^\0] {string_buf.append(yytext()); if(string_buf.length() > MAX_STR_CONST) return new Symbol(TokenConstants.ERROR, "String constant too long"); }
<STRING>\\ { yybegin(BACKSLASH); }

<BACKSLASH>\0 { yybegin(ERROR); return new Symbol(TokenConstants.ERROR, "String contains null character"); }
<BACKSLASH>[^\0] { yybegin(STRING); string_buf.append(yytext()); }

<ERROR>\n|\" { yybegin(YYINITIAL); }
<ERROR>[^\0] { /* Do nothing */ }

<COMMENT>"(*" { ++comment_level; }
<COMMENT>"*)" { if(--comment_level == 0) yybegin(YYINITIAL); }
<COMMENT>\n { curr_lineno++; }
<COMMENT>. { /* Do nothing */ }

<LINECOMMENT>\n { curr_lineno++; yybegin(YYINITIAL); }
<LINECOMMENT>. { /* Do nothing */ }

<YYINITIAL>. { return new Symbol(TokenConstants.ERROR, yytext()); }
