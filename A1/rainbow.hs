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

--test1
test1 = do
  table <- readTable filename
  return (Map.lookup (-1942330076) table)

--reversing hashes
getCorrespondingPassword :: Map.Map Hash Passwd -> Int -> Int -> Passwd -> Hash -> Hash -> Maybe Passwd
getCorrespondingPassword table x (-1) orgPasswd orgHash foundHash = findPassword newTable x orgHash
  where newTable= Map.fromList (filter compareHash (Map.toList table)) 
            where compareHash :: (Hash,Passwd) -> Bool
                  compareHash (qHash,qpasswd) = qHash /= foundHash
getCorrespondingPassword table x rowIndex wPasswd orgHash foundHash 
  | pwHash wPasswd == orgHash       = Just wPasswd         
  | otherwise                         = getCorrespondingPassword table x (rowIndex-1)(pwReduce(pwHash wPasswd)) orgHash foundHash 

findPassword :: Map.Map Hash Passwd -> Int -> Hash -> Maybe Passwd
findPassword table x hash = searchInTable table x x hash hash
                            where searchInTable :: Map.Map Hash Passwd -> Int -> Int -> Hash -> Hash -> Maybe Passwd
                                  searchInTable table x (-1) hash newHash = Nothing 
                                  searchInTable table x y hash newHash
                                    | isNothing(Map.lookup newHash table)   = searchInTable table x (y-1) hash (pwHash(pwReduce newHash))
                                    | otherwise                             = getCorrespondingPassword table x x (Maybe.fromJust (Map.lookup newHash table)) hash newHash     

--test2 and compile
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