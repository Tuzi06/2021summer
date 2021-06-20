
import RainbowAssign
import qualified Data.Map as Map
import Data.Maybe
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












searchInTable :: Map.Map Hash Passwd -> Int -> Hash -> [Passwd]
searchInTable table (-1) hash = []
searchInTable table x hash
    |   isNothing (Map.lookup hash table)   = searchInTable table (x-1) (pwHash(pwReduce hash))
    |   otherwise                           = maybeToList(Map.lookup hash table)

findPassword :: Map.Map Hash Passwd -> Int -> Hash -> Maybe Passwd
findPassword table x hash =
    if null (searchInTable table x hash) then Nothing else
    let [y] = searchInTable table x hash
    in getCorrespondingPassword y x hash
            where
                getCorrespondingPassword:: Passwd -> Int ->Hash ->Maybe Passwd
                getCorrespondingPassword y (-1) hash = Nothing
                getCorrespondingPassword y x hash
                    |  pwHash y ==hash      = listToMaybe [y]
                    |  otherwise            =  getCorrespondingPassword (pwReduce(pwHash y)) (x-1) hash
