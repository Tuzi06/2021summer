import Data.Ratio

--Buit-in funciton
myIterate :: (a -> a) -> a -> [a]
myIterate f n = n: myIterate f (f n)

mySplitAt :: Int -> [a] -> ([a], [a])
mySplitAt x [] = ([],[])
mySplitAt 0 (y:ys) = ([],(y:ys))
mySplitAt x (y:ys) = let (i,j) = mySplitAt (x-1) ys
                    in ([y] ++ i,j)

--Rational Numbers
rationalSum :: Int -> [Ratio Int]
rationalSum n = getRatio 1 (n-1)
                where
                    getRatio :: Int -> Int -> [Ratio Int]
                    getRatio x 1 = [x % 1]
                    getRatio x y = [x % y] ++ getRatio (x+1) (y-1)

--Lowest Terms Only
rationalSumLowest :: Int -> [Ratio Int]
rationalSumLowest n = getRatio 1 (n-1)
                where
                    getRatio :: Int -> Int -> [Ratio Int]
                    getRatio x 1 = [x % 1]
                    getRatio x y
                        |   gcd x y == 1    =[x % y] ++ getRatio (x+1) (y-1)
                        |   otherwise       = getRatio (x+1) (y-1)

-- All Rational Numbers
rationals :: [Ratio Int]
rationals = rationals' 2
            where   rationals' :: Int -> [Ratio Int]
                    rationals' n = rationalSumLowest n ++ rationals' (n+1)

--Input/Output

-- split a list around a given separator value
splitAtSeparator :: Eq a => a -> [a] -> [[a]]
splitAtSeparator sep [] = []
splitAtSeparator sep content = first : splitAtSeparator sep rest
    where
    first = takeWhile (/= sep) content
    firstlen = length first
    rest = drop (firstlen+1) content

-- convert an integer-like string to an integer
readInt :: String -> Int
readInt = read

--sum File
sumFile :: IO Int
sumFile = do
    text<- readFile "input.txt"
    let (y:ys) = map readInt (splitAtSeparator '\n' text)
    let result = sum (y:ys)
    return result


