
{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -F -pgmF htfpp #-}

module CallByNeedTest where

import Test.Framework
import Text.RawString.QQ

import LambdaCalc


{-# ANN module ("HLint: ignore Use camelCase" :: String) #-}

test_simpleLet :: IO ()
test_simpleLet = testExpr "let x = 1; in x" $ VInt 1

strLet :: String
strLet = [r|

  let
    x = 1 + 2;
    y = 3 + 4;
  in
    x * y

|]

test_let :: IO ()
test_let = testExpr strLet $ VInt 21

test_then :: IO ()
test_then = testExpr "if True then 1 + 2 else 3 + 4" $ VInt 3

test_else :: IO ()
test_else = testExpr "if False then 1 + 2 else 3 + 4" $ VInt 7


testExpr :: String -> Value -> IO ()
testExpr text expectedValue = do
  let expr = parseExpr text
  value <- eval [] expr
  assertEqual expectedValue value