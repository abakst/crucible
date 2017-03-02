{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lang.Crucible.Go.Translation
import Language.Go.Parser
import Language.Go.AST
import Control.Monad.ST
import Lang.Crucible.Core

main :: IO ()
main = case runST $ translateFunction (Id undefined undefined "f") undefined undefined [] of
         AnyCFG cfg -> putStrLn $ show cfg

