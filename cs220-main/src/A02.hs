-- | Assignment 2: CPU core actions
module A02
  ( Reg
  , UnaryOp
  , BinaryOp
  , Operand
  , Instr
  , encodeReg
  , encodeUnaryOp
  , encodeBinaryOp
  , encodeOperand
  , encodeInstr
  , decodeReg
  , decodeUnaryOp
  , decodeBinaryOp
  , decodeOperand
  , decodeInstr
  ) where

import           GHC.Generics                   ( Generic )
import           Generic.Random
import           Test.Tasty.QuickCheck         as QC
                                         hiding ( (.&.) )
import           Data.Bits
import           Data.Word
import           Data.Maybe
import           A02_Defs

unplace :: Word32 -> Int -> Int -> Word32
unplace w from size = (shiftR w from) .&. (shiftL 1 size - 1)

decodeReg :: Word32 -> Maybe Reg
decodeReg w = if w < 32 then Just (Reg w) else Nothing

decodeUnaryOp :: Word32 -> Maybe UnaryOp
decodeUnaryOp 0 = Just Move
decodeUnaryOp 1 = Just Negate
decodeUnaryOp 2 = Just Complement
decodeUnaryOp 3 = Just Not
decodeUnaryOp _ = Nothing

decodeBinaryOp :: Word32 -> Maybe BinaryOp
decodeBinaryOp 0 = Just Add
decodeBinaryOp 1 = Just Sub
decodeBinaryOp 2 = Just Mul
decodeBinaryOp 3 = Just Or
decodeBinaryOp 4 = Just And
decodeBinaryOp 5 = Just Xor
decodeBinaryOp 6 = Just Lt
decodeBinaryOp 7 = Just Gt
decodeBinaryOp 8 = Just Eq
decodeBinaryOp _ = Nothing

decodeOperand :: Word32 -> Maybe Operand
decodeOperand w = case (unplace w 0 1) of
  0 -> Just (OperandReg (Reg (unplace w 1 5)))
  1 -> Just (OperandVal (Val (unplace w 1 9)))
  _ -> Nothing

decodeInstr :: Word32 -> Maybe Instr
decodeInstr w = case (unplace w 0 3) of
  0 -> do
    x <- decodeReg (unplace w 3 5)
    y <- decodeUnaryOp (unplace w 8 4)
    z <- decodeOperand (unplace w 12 10)
    return (Unary (x,y,z))
  1 -> do
    x <- decodeReg (unplace w 3 5)
    y <- decodeBinaryOp (unplace w 8 4)
    z <- decodeOperand (unplace w 12 10)
    a <- decodeOperand (unplace w 22 10)
    return (Binary (x,y,z,a))
  2 -> do
    x <- decodeReg (unplace w 3 5)
    y <- decodeOperand (unplace w 12 10)
    return (Load (x,y))
  3 -> do
    x <- decodeOperand (unplace w 12 10)
    y <- decodeOperand (unplace w 22 10)
    return (Store (x,y))
  4 -> do
    x <- decodeReg (unplace w 3 5)
    y <- decodeOperand (unplace w 12 10)
    z <- decodeOperand (unplace w 22 10)
    return (Cas (x,y,z))
  5 -> do
    x <- decodeOperand (unplace w 12 10)
    return (Jump x)
  6 -> do
    x <- decodeReg (unplace w 3 5)
    y <- decodeOperand (unplace w 12 10)
    z <- decodeOperand (unplace w 22 10)
    return (CondJump (x,y,z))
  _ -> Nothing
