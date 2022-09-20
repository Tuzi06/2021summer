import Data.Maybe
pascal :: Int->[Int]
pascal 0 = [1]
pascal n = [1] ++ map add (zip prev (tail prev)) ++[1]
    where   prev = pascal (n-1)
            add :: (Int, Int)-> Int
            add (x,y) = x+y

--pointfree addition
addPair :: (Integer ,Integer )-> Integer 
addPair = uncurry (+)

--pointfree filtering
withoutZeros :: (Eq a,Num a)=> [a]->[a]
withoutZeros = filter ( /=0)

--search? maybe?
findElt :: (Eq t, Num a) => t -> [t] -> Maybe a
findElt x [] = Nothing
findElt x (y:ys)=  listToMaybe (search 0  x (y:ys))
                        where 
                            search :: (Eq t, Num a) => a -> t-> [t] ->[a] 
                            search index x [] = []
                            search index x (y:ys)
                                |   x==y          = [index]
                                |   otherwise     = search (index+1) x ys