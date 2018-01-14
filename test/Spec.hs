
{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Main where


import Test.Framework

import {-@ HTF_TESTS @-} ParserTest
import {-@ HTF_TESTS @-} CallByNeedTest


main :: IO()
main = htfMain htf_importedTests
