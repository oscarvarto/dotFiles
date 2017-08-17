{-# LANGUAGE FlexibleInstances #-}

module Main where

{-
import Data.Char
-- import qualified Data.Map.Strict as Map

{-
import Data.List (intersperse)

mc91 :: Real a => a -> a
mc91 n 
  | n > 100   = n - 10
  | otherwise = mc91 . mc91 . (+11) $ n 

vals = map mc91 [95..110]

digitToWord :: Int -> String
digitToWord n =
  case n of
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    _ -> "ERROR"

digits :: Int -> [Int]
digits = go []
  where go ns n
          | n < 10  = n : ns
          | n >= 10 = go (mod n 10 : ns) (div n 10)

wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . map digitToWord . digits
-}

-- myWords "all i wanna do is have some fun"
-- ["all","i","wanna","do","is","have","some","fun"]

-- Compare with the actual definition of Data.String.words
{-
myWords :: String -> [String]
myWords = go []
  where
    go ws [] = ws
    go ws xs = go (ws ++ [takeWhile (/= ' ') xs]) (dropWhile isSpace (dropWhile (/= ' ') xs))

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myZip :: [a] -> [b] -> [(a, b)]
myZip as       []       = []
myZip []       bs       = []
myZip (a : as) (b : bs) = (a, b) : myZip as bs

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ as [] = []
myZipWith _ [] bs = []
myZipWith f (a : as) (b : bs) = (f a b) : myZipWith f as bs

-- alternative myZip using myZipWith
myZip2 = myZipWith (,)
-}

pascalCase :: String -> String
pascalCase [] = []
pascalCase (x:xs) = toUpper x : pascalCase xs

headUpper :: String -> Char
headUpper = toUpper . head 

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x : xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f (a : as) = (f a) || myAny f as

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (a : as) = (x == a) || myElem x as

myElem2 :: Eq a => a -> [a] -> Bool
myElem2 a as = any (== a) as

myReverse :: [a] -> [a]
myReverse = go []
  where
    go accum [] = accum
    go accum (a: as) = go (a : accum) as

squish :: [[a]] -> [a]
squish [] = []
squish (a: as) = a ++ squish as

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (a : as) = f a ++ squishMap f as

squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [a] = a
myMaximumBy f (a1 : a2 : as) =
  let m = case f a1 a2 of
          LT -> a2
          EQ -> a1
          GT -> a1
  in myMaximumBy f (m : as)
-}

{- Ch. 10, Folding Lists -}

{-
import Data.Time

data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate UTCTime
                  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
  [ DbDate (UTCTime
             (fromGregorian 1911 5 1)
             (secondsToDiffTime 34123))
  , DbNumber 9001
  , DbString "Hello, world!"
  , DbDate (UTCTime
            (fromGregorian 1921 5 1)
            (secondsToDiffTime 34123))
  ]

isDbDate :: DatabaseItem -> Bool
isDbDate (DbDate _) = True
isDbDate  _         = False

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate items = [t | DbDate t <- items]

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber items = [n | DbNumber n <- items]

mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = maximum . filterDbDate

sumDb :: [DatabaseItem] -> Integer
sumDb = sum . filterDbNumber

avgDb :: [DatabaseItem] -> Double
avgDb items = let numbers = filterDbNumber items
                  num = fromIntegral . sum $ numbers
                  den = fromIntegral . length $ numbers
              in num / den

stops = "pbtdkg"
vowels = "aeiou"

svsCombs = [[s1, v, s2] | s1 <- stops, v <- vowels, s2 <- stops]

nouns = ["ball", "car", "Joshua", "Alex"]
verbs = ["play", "buy", "borrow"]

type Noun = String
type Verb = String
possibleSentences :: [(Noun, Verb, Noun)]
possibleSentences = [(n1, v, n2) | n1 <- nouns, v <- verbs, n2 <- nouns]

class TooMany a where
  tooMany :: a -> Bool

instance TooMany (Int, String) where
  tooMany (n, s) = (n + length s) > 42
-}



main :: IO ()
main = do
  print "Hello, world!"
