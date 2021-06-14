--Buit-in funciton

myIterate :: (a -> a) -> a -> [a]
myIterate f n = n: myIterate f (f n)

mySplitAt :: Int -> [a] -> ([a], [a])
mySplitAt 0 (y:ys) = ([],(y:ys))
mySplitAt x (y:ys) = let (a,b) = mySplitAt (x-1) ys
                    in ([y] ++ a, b)

