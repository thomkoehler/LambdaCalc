
{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -F -pgmF htfpp #-}

module CallByNeedTest where

import           Test.Framework

import           LambdaCalc

{-# ANN module ("HLint: ignore Use camelCase" :: String) #-}

test_simpleLet :: IO ()
test_simpleLet = do
  value <- eval [] $ ELet [("x", EInt 1)] $ EVar "x"
  assertEqual (VInt 1) value
