{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
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


getListInf:: Int ->[Int]
getListInf intHash = modular intHash : getListInf (divide intHash)

pwReduce :: Hash -> Passwd
pwReduce hash = map toLetter (reverse(take 8 (getListInf (fromEnum hash))))

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
findInRow  :: Passwd -> Hash ->  Int -> Hash -> Map.Map Hash Passwd -> Int -> Maybe Passwd
findInRow orgPasswd hashVal widthTable matchedHash rTable counter
    | counter == widthTable+1= findPassword newMapTable widthTable hashVal    --false positive: search again but on a new map excluding false positive rows
    | pwHash orgPasswd==hashVal= Just orgPasswd       --Hash the given password and compare it with given hash value.
    | otherwise= findInRow (pwReduce (pwHash orgPasswd)) hashVal widthTable matchedHash rTable (counter+1)    --hash and reduce, and compare again.
    where newMapTable= Map.fromList (filter (\(a, b) -> a /= matchedHash) (Map.toList rTable))  --New Map without false positive row


searchInTable :: Map.Map Hash Passwd -> [Int] -> [Hash] -> Int-> Maybe Passwd
searchInTable table [x,y] hash colIndex
  | isNothing (Map.lookup (hash!!colIndex) table) && y == 0     = Nothing
  | isJust (Map.lookup (hash!!colIndex) table)      = findInRow (Maybe.fromJust (Map.lookup (hash!!colIndex) table)) (head hash) x (hash !! colIndex) table rowIndex
  | otherwise                                                   =  searchInTable table [x,y-1] (hash ++ newHash) (colIndex +1)
  where   newHash= [pwHash (pwReduce p) | p <-hash, p == hash !! colIndex]
          rowIndex = 0





findPassword :: Map.Map Hash Passwd -> Int -> Hash -> Maybe Passwd
findPassword table x hash =
                  let index =0
                  in searchInTable table [x,x] [hash] index















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