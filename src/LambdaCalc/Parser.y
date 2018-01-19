{
module LambdaCalc.Parser(parseExpr) where

import LambdaCalc.Lexer
import LambdaCalc.Expr
import LambdaCalc.Value

}

%name expr
%tokentype { Token }
%error { parseError }

%token
    let     { TokenLet }
    in      { TokenIn }
    if      { TokenIf }
    then    { TokenThen }
    else    { TokenElse }
    NUM     { TokenNum $$ }
    'True'  { TokenBool True }
    'False' { TokenBool False }
    VAR     { TokenSym $$ }
    '\\'    { TokenLambda }
    '->'    { TokenArrow }
    '='     { TokenEq }
    '+'     { TokenAdd }
    '-'     { TokenSub }
    '*'     { TokenMul }
    '('     { TokenLParen }
    ')'     { TokenRParen }
    ';'     { TokenSemicolon }

%left '+' '-'
%left '*'
%%

Expr : '\\' VAR '->' Expr                { ELam $2 $4 }
     | Form                              { $1 }
     | let Binds in Expr                 { ELet $2 $4 }
     | if Expr then Expr else Expr       { EIf $2 $4 $6 }

Bind : VAR '=' Expr ';'                  { ($1, $3) }

Binds : Bind                             {[$1]}
      | Binds Bind                       {$2 : $1}


Form : Form '+' Form                     { EPrim Add $1 $3 }
     | Form '-' Form                     { EPrim Mul $1 $3 }
     | App                               { $1 }

App : App Atom                           { EApp $1 $2 }
    | Atom                               { $1 }

Atom : '(' Expr ')'                      { $2 }
     | NUM                               { EInt $1 }
     | VAR                               { EVar $1 }
     | 'True'                            { EBool True }
     | 'False'                           { EBool False }
    

{

parseError :: [Token] -> a
parseError ts = error $ "Parse error: " ++ show ts


parseExpr :: String -> Expr
parseExpr = expr . scanTokens
}
