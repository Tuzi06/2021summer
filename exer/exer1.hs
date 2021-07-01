--First Haskell Code
det a b c = b^2 - 4*a*c
quadsol1 a b c = (-b - sqrt (det a b c))/2*a
quadsol2 a b c = (-b + sqrt (det a b c))/2*a
--Writing Your First Code
third_a x = x!!2
third_b (x:y:z:xs) = z 
--Factorial
fact 0 = 1
fact a = a* fact (a-1)
--Hailstone Function
hailstone n
    |   even n      =div n 2
    |   otherwise   =3*n+1
--Hailstone Length
hailLen 1 =  0
hailLen n =  hailLen(hailstone n)+1