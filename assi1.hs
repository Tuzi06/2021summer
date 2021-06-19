import RainbowAssign
import qualified Data.Map as Map
import Data.Maybe as Maybe

pwLength, nLetters, width, height :: Int
filename :: FilePath
pwLength = 8            -- length of each password
nLetters = 5            -- number of letters to use in passwords: 5 -> a-e
width = 40              -- length of each chain in the table
height = 1000           -- number of "rows" in the table
filename = "table.txt"  -- filename to store the table

--hashing and reducing
modular :: Int -> Int
modular hash  = hash `mod` nLetters

divide:: Int->Int
divide hash = hash `div` nLetters


getList:: Int -> Int -> [Int] -> [Int]
getList hash time []= getList (divide hash) (time-1) [modular hash]
getList hash time (y:ys)
    |   time >= 0     = getList(divide hash) (time -1) [modular hash]++(y:ys)
    |   otherwise     = []

pwReduce :: Hash -> Passwd
pwReduce hash = map toLetter (getList (fromEnum hash) pwLength [])

--The Map Data Structure
convert :: Int -> Passwd->Hash
convert 0 password = pwHash password
convert x password = pwHash(pwReduce(convert (x-1) password))


makeList ::Int ->[Passwd]->[(Hash,Passwd)]
makeList x = foldr (\ y -> (++) [(convert x y, y)]) []

rainbowTable:: Int -> [Passwd] -> Map.Map Hash Passwd
rainbowTable x [] = Map.empty
rainbowTable x (y:ys)= Map.fromList (makeList x (y:ys))

--creating, reading, and writing table
generateTable :: IO ()
generateTable = do
  table <- buildTable rainbowTable nLetters pwLength width height
  writeTable table filename

--reversing hashes
dehash ::Int -> Hash-> Hash-> [Passwd]
dehash (-1) hash stand = []
dehash x hash stand
    |   pwHash(pwReduce hash)== stand     =[pwReduce hash]
    |   otherwise                           =dehash (x-1) (pwHash(pwReduce hash)) stand

findPassword :: Map.Map Hash Passwd -> Int ->Hash -> Maybe Passwd
findPassword table (-1) hash = Nothing
findPassword table x hash
    |   isNothing (Map.lookup hash table)   = findPassword table (x-1) (pwHash(pwReduce hash))
    |   otherwise                           = listToMaybe (dehash x hash hash)


table = rainbowTable 40 ["abcdeabc", "aabbccdd", "eeeeeeee"]

test2 :: Int -> IO ([Passwd], Int)
test2 n = do
  table <- readTable filename
  pws <- randomPasswords nLetters pwLength n
  let hs = map pwHash pws
  let result = Maybe.mapMaybe (findPassword table width) hs
  return (result, length result)


convert' ::Int-> Hash -> Passwd
convert' 0 hash = pwReduce hash
convert' x hash = pwReduce(pwHash(convert' (x-1) hash))

findPassword' :: Map.Map Hash Passwd -> Int ->Hash -> Int
findPassword' table 80 hash = 80
findPassword' table x hash
    |   isNothing (Map.lookup hash table)   = findPassword' table (x+1) (pwHash(pwReduce hash))
    |   otherwise                           = x




find :: Passwd -> Hash -> Passwd 
find [] hash = ""
find pw hash 
    |   pwHash pw == hash    = pw
    |   otherwise               =find (pwReduce(pwHash pw)) hash