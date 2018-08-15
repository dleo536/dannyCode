

module Utilities
( froto
, compair
, frotoByNearness
, nearestPair
, mapButLast
, intToChar
, implode
, normspace
, removeSpace
, Direction(..)
, move1
, moveN
, intermoves)
where

import Data.List(foldl', scanl', group)
import GHC.Exts(sortWith)
import Data.Bits(testBit)
import System.Random.Shuffle(shuffleM)
import System.Environment(getArgs)
import Data.Char



froto::[a]->[(a, a)]
froto [] = []
froto [x] = []
froto (x:xs) = [(x, head (xs))] ++ froto xs

compair::(Int, Int)->Int
compair (x,xs) = abs(x - xs)
	
frotoByNearness::[Int]->[(Int, Int)]
frotoByNearness = sortWith  compair . froto 

nearestPair:: [Int] -> (Int, Int)
nearestPair  = head . frotoByNearness 

mapButLast:: (a->a)->[a]->[a]
mapButLast _[] = []
mapButLast f [a] = [a]
mapButLast f (x:xs) = [f(x)] ++ mapButLast f xs

intToChar:: Show a => [a] -> [String]
intToChar [] = []
intToChar (x:xs) = [show x] ++ intToChar(xs)

implode::Show a => String->[a]->[Char]
implode str = concat . mapButLast (++ str) . intToChar
--implode str (x:xs) = concat(mapButLast(++ str) (intToChar(x:xs)))



removeSpace :: String -> String
removeSpace [] = []
removeSpace (x:xs) |x == ' '= [x]
                     |otherwise = [x]++xs

normspace :: String -> String
normspace [] = []
--normspace = (++) (removeSpace . head . group) ( normspace . concat . tail . group)
normspace (x:xs) =  ((removeSpace . head . group)(x:xs)) ++ (((normspace . concat . tail . group)(x:xs)))
	

data Direction = North | East | South | West deriving (Show)

move1:: (Int, Int) -> Direction -> (Int, Int)
move1 (x,y) North = (x,(y + 1))
move1 (x,y) South = (x,(y - 1))
move1 (x,y) East = ((x + 1), y)
move1 (x,y) West  = ((x - 1), y)

moveN::(Int, Int) -> [Direction] -> (Int, Int)
moveN  =  foldl'  move1

intermoves:: (Int, Int) -> [Direction] -> [(Int, Int)]
intermoves = scanl move1 

