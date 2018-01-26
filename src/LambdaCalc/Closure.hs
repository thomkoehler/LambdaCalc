
module LambdaCalc.Closure where

import LambdaCalc.Expr
import LambdaCalc.Value

import Data.IORef


type ClosureRef = IORef Closure

data Env 
   = Env { parentEnv :: Env, bindings :: [(Name, ClosureRef)] }
   | EmptyEnv

data Closure
   = Fun { freeVariables :: [Name], funContent :: ClosureRef }
   | Thunk { freeVariables :: [Name], thunkContent :: ClosureRef }

evalFun :: Env -> IO Value
evalFun = undefined

eval :: Env -> Closure -> IO Value
eval = undefined