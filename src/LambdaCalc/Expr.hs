
module LambdaCalc.Expr where

import LambdaCalc.Value

type Name = String

data Expr
   = EVar Name
   | ELam Name Expr
   | EApp Expr Expr
   | EInt Int
   | EBool Bool
   | EPrim PrimOp Expr Expr
   | EFix Expr
   | EEffect Value
   deriving(Show)

data PrimOp
   = Add
   | Mul
   deriving(Show)
