
module LambdaCalc.Value where

type Thunk = () -> IO Value

data Value
   = VInt Int
   | VBool Bool
   | VClosure (Thunk -> IO Value)
   | VEffect (IO Value)
  
instance Show Value where
   show (VInt v) = "VInt " ++ show v
   show (VBool b) = "VBool " ++  show b
   show (VClosure _) = "VClosure"

instance Eq Value where
  (VInt x) == (VInt y) = x == y
  (VBool x) == (VBool y) = x == y


toInt :: Value -> Int
toInt (VInt i) = i
toInt _ = error "Int expected."

toBool :: Value -> Bool
toBool (VBool b) = b
toBool _ = error "Bool expected."
