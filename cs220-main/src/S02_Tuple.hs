module S02_Tuple
  () where

ew :: (Integer, Float, Integer)
ew = (48, 98.0, 98)

add
  :: (Integer, Float, Integer)
  -> (Integer, Float, Integer)
  -> (Integer, Float, Integer)
add (x, y, z) (m, n, w) = (x + m, y + n, z + w)

v1 :: (Integer, Float)
v1 = (4, 2.1)

v2 :: (Integer, Float, ())
v2 = (42, 666.0, ())

data MaybeInteger = MyNothing | MyJust Integer

v3 :: MaybeInteger
v3 = MyNothing

v4 :: MaybeInteger
v4 = MyJust 42
