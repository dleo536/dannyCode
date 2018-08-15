module BullsAndCows where

import Data.List(foldl', scanl', group)
import GHC.Exts(sortWith)
import Data.Bits(testBit)
import System.Random.Shuffle(shuffleM)
import System.Environment(getArgs)



bulls:: String -> String -> String
bulls num numWord = filter (/= ' ') (zipWith (\a b-> if a == b then a else ' ') num numWord)


notTheSame::(Char,Char) -> Bool
notTheSame (a,b) 
	| a /= b = True
	| otherwise = False
	      
nonbulls:: String -> String -> (String, String)
nonbulls target guess = unzip (filter notTheSame (zip target guess)) 
--nonbulls target guess = unzip (filter (\a b-> if a /= b then True else False) (zip target guess))

--elems:: String -> String -> String
--elems [] list = ""
--elems str list
--	| head str `elem` list = head str ++ elems tail(str) list
--	| otherwise = "" ++ elems tail(str) list

cows:: String -> String -> String
--cows target guess = filter ((head(fst(nonbulls target guess))) elem (snd(nonbulls target guess))) guess
--cows target guess = filter (`elem` (head(fst(nonbulls target guess)))) guess	
--cows target guess = filter (`elem` snd (nonbulls target guess)) (fst (nonbulls target guess))
cows target guess = filter (`elem` fst(nonbulls target guess)) (snd (nonbulls target guess))

score:: String -> String -> (Int, Int)
score target guess = ((length (bulls target guess)), (length (cows target guess)))

game:: String -> IO()
game target = do
	putStr "Guess: "
	guess<-getLine
--	let guess = read gess :: String
--	putStrLn ("target:" ++ target)
--	putStrLn ("guess:" ++ guess)
	putStrLn ("Bulls: " ++ (show(fst(score target guess))) ++ " | Cows: " ++ (show(snd(score target guess))))
	if fst(score target guess) == length(target) then 
		return ()
	else 
		game target

randomTarget:: Int -> IO String
randomTarget leng = do
        let xs = "0123456789"
        ys <- shuffleM xs
        let myList = take leng ys
        return  myList


main = do
	args <- getArgs
  	let arg0 = head args
  	let n = read arg0 :: Int
        targ <- randomTarget n
	game targ
