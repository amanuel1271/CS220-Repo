{-# LANGUAGE ExistentialQuantification, StandaloneDeriving #-}

module S06_OpaqueType
  () where

data Any = forall a . Any a


_ = (Any 3, Any (+ 1))

data Showable = forall a . Show a => Showable a
deriving instance Show Showable

b :: [Showable]
b = [Showable 0,Showable 0.0]

_ = (Showable 132, Showable "132")
