{-# LANGUAGE FlexibleInstances, TupleSections #-}
module A03
  ( interpInstr
  , interpStep
  , runInstr
  , runStep
  ) where
import           GHC.Generics                   ( Generic )
import           Generic.Random
import           Test.Tasty.QuickCheck         as QC
                                         hiding ( (.&.) )
import           Control.Monad.State.Lazy
import           Data.Bits
import           Data.List
import           Data.Map                      as Map
import           Data.Maybe
import           Data.Word
import           Prelude                 hiding ( read )
import           A02
import           A02_Defs
import           A03_Defs

interpInstr :: CoreState m => Instr -> m InstrResult
interpInstr instr = case instr of
  Unary    (reg, op, src1) -> do 
    val <- interpOperand src1
    let res = interpUnaryOp op val
    regW reg res
    return Normal
  Binary   (reg, op, src1, src2) -> do
    val1 <- interpOperand src1
    val2 <- interpOperand src2
    let res = interpBinaryOp op val1 val2 
    regW reg res 
    return Normal
  Load     (reg , src1) -> do
    val <- interpOperand src1
    loadRes <- memL (Loc val)
    case loadRes of 
      Nothing -> do
        memS ctrlLoc (Val 0x20)
        return Fault 
      Just value -> do
        regW reg value
        return Normal
  Store    (src1, src2) -> do
    valToStore <- interpOperand src2
    memLocation <- interpOperand src1
    memS (Loc memLocation) valToStore
    return Normal
  Cas      (reg, src1, src2) -> do
    val <- regR reg 
    val1 <- interpOperand src1
    val2 <- interpOperand src2
    memcasRes <- memCas (Loc val) val1 val2
    case memcasRes of 
      Nothing -> do
        memS ctrlLoc (Val 0x20)
        return Fault
      Just (bool,oldval) -> do
        regW reg oldval
        return Normal
  Jump     src1  -> do
    val1 <- interpOperand src1
    return (JumpTo (Loc val1))
  CondJump (cond, src1, src2) -> do
    Val regVal <- regR cond
    val1 <- interpOperand src1
    val2 <- interpOperand src2
    case regVal of
      0 -> return (JumpTo (Loc val2))
      _ -> return (JumpTo (Loc val1))

interpStep :: CoreState m => m ()
interpStep = do
  Val pc <- regR pcReg
  loadRes <- memL (Loc (Val pc))
  case loadRes of
    Nothing -> do
      ctrlFault InvalidLoad
    Just (Val value) -> do
      let decodeRes = decodeInstr value
      case decodeRes of
        Nothing -> do
          ctrlFault InvalidInstr
        Just inst -> do
          interpRes <- interpInstr inst
          case interpRes of
            Normal -> do
              regW pcReg (Val (pc + 1))
            Fault -> return ()
            JumpTo (Loc loc) -> do
              regW pcReg (loc)

runInstr :: RegFile -> Mem -> Instr -> (InstrResult, (RegFile, Mem))
runInstr regFile mem instr = runState (interpInstr instr) (regFile, mem)

runStep :: RegFile -> Mem -> (RegFile, Mem)
runStep regFile mem = runState interpStep (regFile, mem) |> snd
