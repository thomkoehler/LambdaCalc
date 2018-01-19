
{-# LANGUAGE RankNTypes #-}

module LambdaCalc.CallByNeed(eval) where

import Data.IORef
import Data.Maybe
import Text.Printf
import Control.Monad

import LambdaCalc.Expr
import LambdaCalc.Value


type Env = [(String, IORef Thunk)]


update :: IORef Thunk -> Value -> IO ()
update ref v = do
  writeIORef ref (\() -> return v)
  return ()

force :: IORef Thunk -> IO Value
force ref = do
  th <- readIORef ref
  v <- th ()
  update ref v
  return v


mkThunk :: Env -> String -> Expr -> (Thunk -> IO Value)
mkThunk env name body th = do
  th' <- newIORef th
  eval ((name, th') : env) body


eval :: Env -> Expr -> IO Value
eval env ex = case ex of
  EUndefined -> error "undefined"

  EVar n -> do
    let ref = fromMaybe (error (printf "Var %s not found." n)) $ lookup n env
    force ref

  ELam x e -> return $ VClosure $ mkThunk env x e

  EApp a b -> do
    VClosure c <- eval env a
    c (\() -> eval env b)

  EBool b -> return $ VBool b
  EInt n  -> return $ VInt n
  EFix e  -> eval env (EApp e (EFix e))

  EPrim primOp expr0 expr1 -> do
    v0 <- eval env expr0
    v1 <- eval env expr1
    case primOp of
      Add -> return $ VInt $ toInt v0 + toInt v1
      Sub -> return $ VInt $ toInt v0 - toInt v1
      Mul -> return $ VInt $ toInt v0 * toInt v1

  EIf predExpr expr0 expr1 -> do
    predVal <- eval env predExpr
    if toBool predVal 
      then eval env expr0
      else eval env expr1

  ELet bs expr -> do
    env' <- foldM addEnvEntry env bs
    eval env' expr

  where 
    addEnvEntry e (name, body) = do
      bodyThunk <- newIORef (\() -> eval env body)
      return $ (name, bodyThunk) : e
    




