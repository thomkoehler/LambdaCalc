
{-# OPTIONS_GHC -F -pgmF htfpp #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Main(main) where

import Test.Framework
import Text.RawString.QQ

main :: IO()
main = htfMain htf_thisModulesTests


strSimpleLet :: String
strSimpleLet = [r|
main =
   let
      x = 1
   in
      x
|]


prop_neqGpx :: Bool
prop_neqGpx = True