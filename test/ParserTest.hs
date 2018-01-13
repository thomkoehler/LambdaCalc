
{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -F -pgmF htfpp #-}
{-# LANGUAGE OverloadedStrings #-}

module ParserTest where

import Test.Framework
import Text.RawString.QQ

import LambdaCalc


strSimpleLet :: String
strSimpleLet = [r|

  let
    x = 1;
  in
    x

|]


prop_simpleLet :: Bool
prop_simpleLet = (parseExpr strSimpleLet) == (ELet [("x", EInt 1)] (EVar "x"))
