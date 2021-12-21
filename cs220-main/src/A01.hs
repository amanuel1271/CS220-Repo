-- | Assignment 1: implementing various small functions
module A01
  ( Day(..)
  , nextWeekday
  , addTuple
  , productDot
  , maybeMap
  , maybeThen
  , Tree(..)
  , sumTree
  , rightRotateTree
  , listSum
  , productSeq
  , setMem
  , setEquiv
  , setUnion
  , setIntersection
  , setDiff
  , setSymDiff
  , relMem
  , relEquiv
  , relComp
  , relTrans
  , relFull
  , fibs
  , primes
  , fuzzySeq
  , funComp
  , curry2
  , uncurry2
  , myFilter
  , myFilterMap
  , myFoldL
  , myRev
  ) where

-- | TODO marker.
todo :: t
todo = error "todo"

-- | Days of week.
data Day = Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday deriving (Eq, Show)

-- | Returns the next weekday (excluding weekend, namely Saturday and Sunday).
nextWeekday :: Day -> Day
nextWeekday Monday    = Tuesday
nextWeekday Tuesday   = Wednesday
nextWeekday Wednesday = Thursday
nextWeekday Thursday  = Friday
nextWeekday _         = Monday


-- | Add tuples of the 2-dimensional plane.
addTuple :: (Integer, Integer) -> (Integer, Integer) -> (Integer, Integer)
addTuple (a, b) (c, d) = (a + c, b + d)

-- | Dot-products two integer (list) vectors: https://en.wikipedia.org/wiki/Dot_product
-- |
-- | If the two vectors have different number of elements, you can return anything.
productDot :: [Integer] -> [Integer] -> Integer
productDot []      _         = 0
productDot _       []        = 0
productDot (h : t) (h2 : t2) = (h * h2) + productDot t t2

-- | Maps the given value if it's Just.
maybeMap :: (Integer -> Integer) -> Maybe Integer -> Maybe Integer
maybeMap f Nothing  = Nothing
maybeMap f (Just x) = Just (f x)

-- | If the given value is Just, map it with the given function; otherwise, the result is Nothing.
maybeThen :: Maybe Integer -> (Integer -> Maybe Integer) -> Maybe Integer
maybeThen Nothing  _ = Nothing
maybeThen (Just x) f = f x

-- | Trees of integers.
data Tree = Leaf Integer | Branch Integer Tree Tree deriving (Eq, Show) -- Integer is value, Trees are left/right subtrees.

-- | Sums all the integers in the given tree.
sumTree :: Tree -> Integer
sumTree (Leaf n             ) = n
sumTree (Branch x left right) = x + (sumTree left + sumTree right)

-- | Right-rotate the given tree. See https://en.wikipedia.org/wiki/Tree_rotation for more detail.
-- |
-- | Returns Nothing if there are not enough nodes.
rightRotateTree :: Tree -> Maybe Tree
rightRotateTree (Leaf x             ) = Nothing
rightRotateTree (Branch y left right) = case (left, right) of
  (Leaf m, _) -> Nothing
  (Branch val s_left d_right, d) ->
    Just (Branch val s_left (Branch y d_right d))

-- | Maps the given list.
listMap = map

-- | Sums all the integers in the given list.
listSum :: [Integer] -> Integer
listSum []      = 0
listSum (h : t) = h + listSum t

-- | More compositional construction of sigma.
sumSeq :: (Integer -> Integer) -> Integer -> Integer -> Integer
sumSeq f from to = listSum (listMap f [from .. to])


-- | product of a sequence. See https://en.wikipedia.org/wiki/Multiplication#Product_of_a_sequence for more detail.
productSeq :: (Integer -> Integer) -> Integer -> Integer -> Integer
productSeq f x y = if x > y then 0 else productSeqMain f x y
 where
  productSeqMain f x y = if x > y then 1 else f x * productSeqMain f (x + 1) y


-- | Returns if the given value is in the (list) set.
setMem :: Integer -> [Integer] -> Bool
setMem _   []      = False
setMem val (h : t) = (val == h) || setMem val t

onesidedEqui :: [Integer] -> [Integer] -> Bool
onesidedEqui []      [] = True
onesidedEqui _       [] = False
onesidedEqui []      _  = True
onesidedEqui (h : t) b  = setMem h b && onesidedEqui t b

-- | Returns the two sets contain the same elements.
setEquiv :: [Integer] -> [Integer] -> Bool
setEquiv s1 s2 = onesidedEqui s1 s2 && onesidedEqui s2 s1

-- | Returns the set union.
setUnion :: [Integer] -> [Integer] -> [Integer]
setUnion s1 s2 = s1 ++ s2

-- | Returns the set intersection
setIntersection :: [Integer] -> [Integer] -> [Integer]
setIntersection [] [] = []
setIntersection _  [] = []
setIntersection [] _  = []
setIntersection (h : t) b =
  if setMem h b then h : setIntersection t b else setIntersection t b

-- | Returns the set diff, i.e., setDiff a b = $a - b$.
setDiff :: [Integer] -> [Integer] -> [Integer]
setDiff []      [] = []
setDiff a       [] = a
setDiff []      _  = []
setDiff (h : t) b  = if setMem h b then setDiff t b else h : setDiff t b

-- | Returns the set symmetric diff.
setSymDiff :: [Integer] -> [Integer] -> [Integer]
setSymDiff s1 s2 = setDiff s1 s2 ++ setDiff s2 s1

-- | Returns if the given pair is in the (list) relation.
relMem :: [(Integer, Integer)] -> Integer -> Integer -> Bool
relMem []      _  _  = False
relMem (h : t) v1 v2 = ((v1, v2) == h) || relMem t v1 v2

setMemRel :: (Integer, Integer) -> [(Integer, Integer)] -> Bool
setMemRel _   []      = False
setMemRel val (h : t) = (val == h) || setMemRel val t

onesidedEquiRel :: [(Integer, Integer)] -> [(Integer, Integer)] -> Bool
onesidedEquiRel []      [] = True
onesidedEquiRel _       [] = False
onesidedEquiRel []      _  = True
onesidedEquiRel (h : t) b  = setMemRel h b && onesidedEquiRel t b

-- | Returns the two relations contain the same elements.
relEquiv :: [(Integer, Integer)] -> [(Integer, Integer)] -> Bool
relEquiv r1 r2 = onesidedEquiRel r1 r2 && onesidedEquiRel r2 r1

compOne :: (Integer, Integer) -> [(Integer, Integer)] -> [(Integer, Integer)]
compOne _ [] = []
compOne (a, b) ((c, d) : t) =
  if b == c then (a, d) : compOne (a, b) t else compOne (a, b) t


-- | Composes two relations, i.e., {(a,c) | exists b, (a,b) in r1 and (b,c) in r2}.
relComp :: [(Integer, Integer)] -> [(Integer, Integer)] -> [(Integer, Integer)]
relComp []      _ = []
relComp (h : t) l = compOne h l ++ relComp t l

anotherRelTrans
  :: [(Integer, Integer)] -> [(Integer, Integer)] -> [(Integer, Integer)]
anotherRelTrans []      _ = []
anotherRelTrans ((a,c) : t) b 
  | relMem b a c = anotherRelTrans t b
  | otherwise = ((a,c) : helperRelTrans (a,c) ((a,c):b)) ++ anotherRelTrans t b

helperRelTrans
  :: (Integer, Integer) -> [(Integer, Integer)] -> [(Integer, Integer)]
helperRelTrans _ [] = []
helperRelTrans a b  = if (onesidedEquiRel y b) then [] else anotherRelTrans y b
  where y = relComp [a] b

-- | Returns the transitive closure of the given relation: https://en.wikipedia.org/wiki/Transitive_closure
relTrans :: [(Integer, Integer)] -> [(Integer, Integer)]
relTrans w = anoTrans w w
  where anoTrans []   []     =    []
        anoTrans []    _     =    []
        anoTrans _     []    =    []
        anoTrans (h:t) whole =    h : (helperRelTrans h whole) ++ anoTrans t whole

-- | Returns the relation [0..n] * [0..n] = {(0,0), (0,1), ..., (0,n), (1,0), (1,1), ..., (1,n), ..., (n,n)}.
relFull :: Integer -> [(Integer, Integer)]
relFull n = buzzer 0 where
  buzzer a =
    if a <= n then [ (a, x) | x <- [0 .. n] ] ++ buzzer (a + 1) else []

-- | The Fibonacci sequence, starting with 0, 1, 1, 2, 3, ...
fibs :: [Integer]
fibs = fibgen 0 1 where fibgen a b = a : fibgen b (a + b)



generateNextPrime :: Integer -> Integer
generateNextPrime a = if isprime (a + 1) then a + 1
  else generateNextPrime (a + 1) where isprime n = [ x | x <- [1 .. n], n `rem` x == 0 ] == [1, n]



-- | The primes, starting with 2, 3, 5, 7, ...
primes :: [Integer]
primes = generatePrime 2
  where generatePrime n = n : generatePrime (generateNextPrime n)


fuzop :: Integer -> [Integer]
fuzop a | a == 1    = [1]
        | otherwise = a : fuzop (a - 1)


-- | The sequence of 1, 2, 1, 3, 2, 1, 4, 3, 2, 1, 5, 4, 3, 2, 1, ...
fuzzySeq :: [Integer]
fuzzySeq = buz 1 where buz a = fuzop a ++ buz (a + 1)


-- | Composes two functions, i.e., applies f1 and then f2 to the given argument
funComp :: (Integer -> Integer) -> (Integer -> Integer) -> (Integer -> Integer)
funComp f1 f2 i = f2 (f1 i)

-- | Transforms a function that gets single pair into a function that gets two arguments, i.e., curry2 f a1 a2 = f (a1, a2)
curry2 :: ((Integer, Integer) -> Integer) -> Integer -> Integer -> Integer
curry2 f a1 a2 = f (a1, a2)

-- | Transforms a function that gets two arguments into a function that gets single pair, i.e., uncurry2 f (a1, a2) = f a1 a2
uncurry2 :: (Integer -> Integer -> Integer) -> (Integer, Integer) -> Integer
uncurry2 f (a1, a2) = f a1 a2

-- | Filters the given list so that the the filter function returns True for the remaining elements.
myFilter :: (Integer -> Bool) -> [Integer] -> [Integer]
myFilter f []      = []
myFilter f (h : t) = if f h then h : myFilter f t else myFilter f t

-- | Maps the given list. If the map function returns Nothing, just drop it.
myFilterMap :: (Integer -> Maybe Integer) -> [Integer] -> [Integer]
myFilterMap f []      = []
myFilterMap f (h : t) = case f h of
  Just x  -> x : myFilterMap f t
  Nothing -> myFilterMap f t

-- | Folds the list from the left, i.e., myFoldL init f [l1, l2, ..., ln] = (f (f (f (f init l1) l2) ...) ln).
myFoldL :: Integer -> (Integer -> Integer -> Integer) -> [Integer] -> Integer
myFoldL output _ []      = output
myFoldL x      f (h : t) = myFoldL (f x h) f t

-- | Reverses the given list.
myRev :: [Integer] -> [Integer]
myRev []      = []
myRev (h : t) = myRev t ++ [h]
