import Data.List.Split
import Data.Char

cross (f, g) xs = (f xs, g xs)

checksum xs = sum $ map amplitude xs where
    amplitude = (uncurry (-)) . (cross (maximum, minimum))

inputData = (map parse) . (filter (/="")) . (splitOn "\n") where
    parse = (map (\x -> read x::Int)) . filter (/="") . (splitOn " ")

main = getLine >>= readFile >>= (print . checksum . inputData) where

