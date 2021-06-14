import Data.Ratio
--Buit-in funciton
myIterate :: (a -> a) -> a -> [a]
myIterate f n = n: myIterate f (f n)

mySplitAt :: Int -> [a] -> ([a], [a])
mySplitAt 0 (y:ys) = ([],(y:ys))
mySplitAt x (y:ys) = let (a,b) = mySplitAt (x-1) ys
                    in ([y] ++ a, b)

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