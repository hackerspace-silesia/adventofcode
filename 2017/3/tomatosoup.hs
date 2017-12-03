fst_odd_pow = aux (map (^2) [1,3..]) 0 where
    aux (x:xs) i n = if x >= n then i else aux xs (i+1) n

path_len n = let (size, side) = (fst_odd_pow n * 2 + 1, size `quot` 2) in
             let pos = mod (size^2 - n) (size-1) in side + abs (side - pos)

-- More elegant version:
path_len_v2 n = side + abs (side - pos) where
    size = fst_odd_pow n * 2 + 1
    side = size `quot` 2
    pos = mod (size^2 - n) (size-1)

main = getLine >>= (print . path_len . read)

