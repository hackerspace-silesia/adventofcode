import Data.Char (digitToInt)

compute xs@(h:xs') = aux 0 h xs where
    add_if_eq acc x y = acc + (if x == y then x else 0)
    aux sum h [x] = add_if_eq sum h x
    aux sum h (x:x':xs) = aux (add_if_eq sum x x') h (x':xs)

main = getLine >>= print . compute . (map digitToInt)

