module A05
  ( ShrMem (..)
  , newShrMem
  , loadShrMem
  , storeShrMem
  , casShrMem
  ) where

import           Control.Concurrent.MVar
import           Data.Map                      as Map

import           A02_Defs
import           A03_Defs
import           A05_Defs

-- | TODO marker.
todo :: t
todo = error "todo"

newShrMem :: IO ShrMem
newShrMem = do
  newvar <- newMVar Map.empty
  return  (ShrMem newvar)

loadShrMem :: Loc -> ShrMem -> IO (Maybe Val)
loadShrMem loc (ShrMem mem) = do
  memmap <- readMVar mem
  case (Map.lookup loc memmap) of
    Nothing -> do
      return Nothing
    Just mvar -> do
      val <- takeMVar mvar 
      putMVar mvar val
      return (Just val)

storeShrMem :: Loc -> Val -> ShrMem -> IO ()
storeShrMem loc val (ShrMem mem) = do
  newvar <- newMVar val
  x <- takeMVar mem
  putMVar mem (Map.insert loc newvar x)
  

casShrMem :: Loc -> Val -> Val -> ShrMem -> IO (Maybe (Bool, Val))
casShrMem loc val1 val2 (ShrMem mem) = do
  memMap <- readMVar mem
  case Map.lookup loc memMap of
    Nothing  -> do
      return Nothing
    Just mvar -> do
      val <- takeMVar mvar
      if val /= val1
      then do
        putMVar mvar val
        return (Just(False,val))
      else do
          putMVar mvar val2
          return (Just(True,val))


