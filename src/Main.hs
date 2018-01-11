
module Main where

import LambdaCalc.CallByNeed
import LambdaCalc.Parser
import LambdaCalc.Expr

omega :: Expr
omega = EApp (ELam "x" (EApp (EVar "x") (EVar "x")))
             (ELam "x" (EApp (EVar "x") (EVar "x")))

main :: IO ()
main = do
  content <- readFile "./examples/testLet.lc"
  let expr = parseExpr content
  print expr
  val <- eval [] expr
  print val
  return ()

