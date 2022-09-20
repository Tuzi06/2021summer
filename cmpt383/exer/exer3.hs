import Data.Time.Calendar
import Data.Time.Calendar.OrdinalDate

--merging
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge [] (y:ys) =y: merge [] ys
merge (x:xs) [] = x:merge xs []
merge (x:xs)(y:ys) 
    | x <= y = x: merge xs (y:ys)
    | x > y  = y: merge (x:xs) ys

--merge sort
mergeSort:: Ord a => [a] -> [a]
mergeSort [x] = [x]
mergeSort (x:xs) = 
    let (y:ys) = take (length(x:xs) `div` 2) (x:xs)
        (z:zs) = drop(length(x:xs) `div` 2) (x:xs)
    in merge (mergeSort (y:ys))  (mergeSort (z:zs))

--Haskell library and dates
daysInYear :: Integer -> [Day]
daysInYear y = [jan1 .. dec31] 
  where jan1 = fromGregorian y 1 1
        dec31 =fromGregorian y 12 31

isFriday :: Day -> Bool 
isFriday x
    | snd(mondayStartWeek x)==5 = True 
    | otherwise  = False 

isPrimeDay :: Day-> Bool 
isPrimeDay x
    | divisors(getDay(toGregorian x)) ==[]   = True
    | otherwise                             = False 
    where 
        getDay :: (Integer,Int,Int) -> Int
        getDay (y,m,d) = d
        divisors :: Int-> [Int]
        divisors n = [i | i <- [2..(n`div` 2)], n `mod` i == 0]

primeFridays :: Integer -> [Day]
primeFridays x= filter isFriday (filter isPrimeDay(daysInYear x))