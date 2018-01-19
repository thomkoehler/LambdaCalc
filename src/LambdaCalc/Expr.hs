
module LambdaCalc.Expr where

type Name = String

data Expr
   = EVar Name
   | ELam Name Expr
   | EApp Expr Expr
   | EInt Int
   | EBool Bool
   | EUndefined
   | EPrim PrimOp Expr Expr
   | EFix Expr
   | ELet [(Name, Expr)] Expr
   | EIf Expr Expr Expr
   deriving(Show, Eq)

data PrimOp
   = Add
   | Sub
   | Mul
   deriving(Show, Eq)
