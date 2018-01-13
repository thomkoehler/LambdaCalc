
module LambdaCalc.Expr where

type Name = String

data Expr
   = EVar Name
   | ELam Name Expr
   | EApp Expr Expr
   | EInt Int
   | EBool Bool
   | EPrim PrimOp Expr Expr
   | EFix Expr
   | ELet [(Name, Expr)] Expr
   deriving(Show, Eq)

data PrimOp
   = Add
   | Mul
   deriving(Show, Eq)
