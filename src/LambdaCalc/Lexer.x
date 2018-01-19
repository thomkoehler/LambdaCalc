
{

module LambdaCalc.Lexer (Token(..),scanTokens) where

}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$eol   = [\n]

tokens :-

  $eol                          ;
  $white+                       ;
  "#".*                         ;
  let                           { \s -> TokenLet }
  in                            { \s -> TokenIn }
  if                            { \s -> TokenIf }
  then                          { \s -> TokenThen }
  else                          { \s -> TokenElse }
  $digit+                       { \s -> TokenNum (read s) }
  "->"                          { \s -> TokenArrow }
  "True"                        { \s -> TokenBool True }
  "False"                       { \s -> TokenBool False }
  \=                            { \s -> TokenEq }
  \\                            { \s -> TokenLambda }
  \;                            { \s -> TokenSemicolon }
  [\+]                          { \s -> TokenAdd }
  [\-]                          { \s -> TokenSub }
  [\*]                          { \s -> TokenMul }
  \(                            { \s -> TokenLParen }
  \)                            { \s -> TokenRParen }
  $alpha [$alpha $digit \_ \']* { \s -> TokenSym s }

{

data Token = TokenLet
           | TokenIn
           | TokenIf
           | TokenThen
           | TokenElse
           | TokenLambda
           | TokenNum Int
           | TokenBool Bool
           | TokenSym String
           | TokenArrow
           | TokenEq
           | TokenAdd
           | TokenSub
           | TokenMul
           | TokenLParen
           | TokenRParen
           | TokenSemicolon
           deriving (Eq,Show)

scanTokens = alexScanTokens

}
