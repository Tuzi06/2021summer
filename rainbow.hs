{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import RainbowAssign
import qualified Data.Map as Map
import Data.Maybe as Maybe

pwLength, nLetters, width, height :: Int
filename :: FilePath
pwLength = 5
nLetters = 18
width = 60
height = 800
filename = "table.txt"  -- filename to store the table

--hashing and reducing
modular :: Int -> Int
modular hash  = hash `mod` nLetters

divide:: Int->Int
divide hash = hash `div` nLetters


getListInf:: Int ->[Int]
getListInf intHash = modular intHash : getListInf (divide intHash)

pwReduce :: Hash -> Passwd
pwReduce hash = map toLetter (reverse(take pwLength (getListInf (fromEnum hash))))

--The Map Data Structure
convert :: Int -> Passwd->Hash
convert 0 password = pwHash password
convert x password = pwHash(pwReduce(convert (x-1) password))

makeList ::Int ->[Passwd]->[(Hash,Passwd)]
makeList x = foldr (\y -> (++) [(convert x y, y)]) []

rainbowTable:: Int -> [Passwd] -> Map.Map Hash Passwd
rainbowTable x [] = Map.empty
rainbowTable x (y:ys)= Map.fromList (makeList x (y:ys))

--creating, reading, and writing table
generateTable :: IO ()
generateTable = do
  table <- buildTable rainbowTable nLetters pwLength width height
  writeTable table filename

--reversing hashes
findInRow  :: Map.Map Hash Passwd -> Passwd -> Hash -> Hash -> Int -> Int -> Maybe Passwd
findInRow table orgPasswd orgHash foundHash x rowIndex
  | pwHash orgPasswd == orgHash       = Just orgPasswd 
  | rowIndex == x+1                   = findPassword newTable x orgHash          
  | otherwise                         = findInRow table (pwReduce (pwHash orgPasswd)) orgHash foundHash x (rowIndex+1)    
    where newTable= Map.fromList (filter compareHash (Map.toList table)) 
            where compareHash :: (Hash,Passwd) -> Bool
                  compareHash (qHash,qpasswd) = qHash/= foundHash

searchInTable :: Map.Map Hash Passwd -> Int -> Int -> Hash -> Hash -> Maybe Passwd
searchInTable table x y hash newHash 
  | isNothing (Map.lookup newHash table) && y == 0     = Nothing
  | isJust (Map.lookup newHash table)                  = findInRow table (Maybe.fromJust (Map.lookup newHash table)) hash newHash x 0
  | otherwise                                          = searchInTable table x (y-1) hash reHash 
  where reHash= pwHash (pwReduce newHash)

findPassword :: Map.Map Hash Passwd -> Int -> Hash -> Maybe Passwd
findPassword table x hash = searchInTable table x x hash hash

--test and compile
test2 :: Int -> IO ([Passwd], Int)
test2 n = do
  table <- readTable filename
  pws <- randomPasswords nLetters pwLength n
  let hs = map pwHash pws
  let result = Maybe.mapMaybe (findPassword table width) hs
  return (result, length result)

main :: IO ()
main = do
  generateTable
  res <- test2 10000
  print res