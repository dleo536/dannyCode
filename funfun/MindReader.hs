module MindReader where

import Data.List(foldl', scanl', group)
import GHC.Exts(sortWith)
import Data.Bits(testBit)
import System.Random.Shuffle(shuffleM)
import System.Environment(getArgs)
import Data.Char 



testsBits:: Int -> [Int] -> [Int]
testsBits base [] = []
testsBits base (x:xs)
	| testBit x base = x : testsBits base xs
	| otherwise = testsBits base xs

intsWithBit:: Int -> Int -> [Int]
intsWithBit max base = testsBits base [1..max]


binaryToDecimal:: String -> Int
binaryToDecimal = foldl' (\var x -> var * 2 + digitToInt x) 0

decimalToBinary':: Int -> String
decimalToBinary' num 
	|((num /= 0) && ((num `mod` 2) == 0)) = "0" ++ decimalToBinary' (num`div`2)
	|((num /= 0) && ((num `mod` 2) == 1)) = "1" ++ decimalToBinary' (num`div`2)
	|otherwise = ""

decimalToBinary:: Int -> String
decimalToBinary 0 = "0"
decimalToBinary num = reverse(decimalToBinary' num)

nbits:: Int -> Int
nbits num  = length(decimalToBinary num)

promptForBit:: Int -> Int -> IO Int
promptForBit max index = do
--	putStrLn ""
	putStrLn (show(intsWithBit max index))
	putStrLn "Is your number in this list? y/[n]? "
	answer <- getLine
	if answer == "y" then 
		return 1
	else 
		return 0
  
intArrToString:: [Int] -> String
intArrToString [] = []
intArrToString (x:xs) = [intToDigit x] ++ intArrToString (xs)


main:: IO()
main = do
   putStrLn "What's your favorite upper bound? "
   bound <- getLine
  -- putStrLn ""
   putStrLn ("Think of a number in [1, " ++ bound ++ "]. But don't tell me. I will read your mind!")	
   putStrLn ""
   binary<- mapM (promptForBit (read bound)) [0..((nbits (read bound))-1)]
   let binStr = intArrToString (reverse binary) 
   let num = binaryToDecimal binStr
   putStrLn ("Your number is " ++ (show num) ++ ".")
  -- putStrLn ""
   return ()
   
