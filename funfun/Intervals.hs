module Intervals where


within:: Int->(Int,Int)->Bool
within num (x,y) = (x <= num) && (num <= y)


withins:: Int -> [(Int,Int)] -> [(Int, Int)]
withins  = filter .  within 


isFree:: Int -> [(Int,Int)] -> Bool
--isFree [] = True
isFree x  = (== 0) . length . (withins x)

getSeconds:: [(Int, Int)] -> [Int]
getSeconds [] = []
getSeconds (x:xs) = [snd(x)] ++ getSeconds xs


freeBeyond:: [(Int,Int)] -> Int
freeBeyond = (+1) . maximum . getSeconds 


firstFree:: Int -> [(Int,Int)] -> Int
firstFree check list 
	| isFree (check) list == True = check
	| otherwise = firstFree (check + 1) list
	where checkk = check + 1
