
import RainbowAssign
import qualified Data.Map as Map
filename :: FilePath
pwLength = 8            -- length of each password
nLetters = 5            -- number of letters to use in passwords: 5 -> a-e
width = 40              -- length of each chain in the table
height = 1000           -- number of "rows" in the table
filename = "table.txt"  -- filename to store the table

--hashing and reducing
modular :: Int -> Int
modular hash =hash `mod` nLetters

divide:: Int->Int
divide hash  = hash`div` nLetters

getList:: Int -> Int ->[Int]->[Int]
getList hash time []= getList (divide hash) (time-1) [modular hash]
getList hash time (y:ys)
    |   time >= 0     = getList(divide hash) (time -1) [modular hash]++(y:ys)
    |   otherwise     = []

pwReduce :: Hash  -> Passwd 
pwReduce hash = map toLetter (getList (fromEnum hash) pwLength [])

convert :: Int -> Passwd->Hash
convert 0 password = pwHash password
convert x password = pwHash(pwReduce(convert (x-1) password))


makeList ::Int ->[Passwd]->[(Hash,Passwd)]
makeList x [] = []
makeList x (y:ys) = [((convert x y),y)] ++ (makeList x ys)

rainbowTable:: Int -> [Passwd] -> Map.Map Hash Passwd
rainbowTable x [] = Map.fromList ([])
rainbowTable x (y:ys)= Map.fromList (makeList x (y:ys))