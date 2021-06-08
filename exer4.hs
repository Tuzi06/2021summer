pascal :: Int ->[Int]
pascal 0 = [1]
pascal n = [1] ++ map add (zip prev (tail prev)) ++[1]
    where   prev = pascal (n-1)
            add :: (Int, Int)-> Int
            add (x,y) = x+y
--pointfree addition
