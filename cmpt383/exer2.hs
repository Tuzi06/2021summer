--prime and divisors
divisors :: Int -> [Int]
divisors n = [i | i <- [2..(n`div` 2)], n `mod` i == 0]
primes :: Int -> [Int]
primes n = [i | i <- [2..n], divisors i == []]
--pythagorean triples
pythagorean :: Int -> [(Int, Int, Int)]
pythagorean n = [(a,b,c) |c<-[1..n],b<-[1..n],a<-[1..n],(a*a +b*b) == c*c, a<b]
--joining string
join (x:xs) [] = [] 
join (x:xs) [y] = y
join (x:xs) (y:ys) = y ++ (x:xs) ++ join (x:xs) ys
--factorial with fold
fact' n = foldl (*) 1 [1..n]
--Tail reusive Hailstone
hailstone n
    |   even n      =div n 2
    |   otherwise   =3*n+1
hailLen n = hailTail 0 n
  where
    hailTail a 1 = a
    hailTail a n = hailTail (a+1) (hailstone n)