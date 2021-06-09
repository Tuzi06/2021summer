import Data.Maybe 
half :: Fractional a => a -> a
half a=a/2
isBig :: (Ord a, Num a) => a -> Bool
isBig a = a > 100
listify x y = [x, y]
myand False _=False
myand True  a=a


mysum [] =0
mysum (x:xs) = x+ mysum xs

check (a:b:c:xs) --string
    |   a:b:c:[] == "520"   =True
    |   otherwise           =False




search index x [] = []
search index x (y:ys)
    |   x==y            = [index]
    |   otherwise       = search (index+1) x ys

isNull (y:ys) = null [y]