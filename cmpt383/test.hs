half a=a/2
isBig a = a > 100
listify x y = [x, y]
myand False _=False
myand True  a=a 


mysum [] =0
mysum (x:xs) = x+ mysum xs

check (a:b:c:xs) --string
    |   a:b:c:[] == "520"   =True
    |   otherwise           =False