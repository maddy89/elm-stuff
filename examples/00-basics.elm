-- Functions

 String.length
-- <function> : String -> Int, must take a string arg and return int


-- Annonymous functions
\n -> n / 2 
-- <function> : Float -> Float between \ and -> list the input params

 (\n -> n / 2) 128 -- parantehsis indicates the boundary, otherwise Elm reads everything after the arrow

 half =  \n -> n / 2 -- we can name an ann. function

{- Note:
 All functions are actually named ann. functions. 
 
half n = n / 2
  <function> : Float -> Float

is actually,

half = \n -> n / 2
  <function> : Float -> Float
-}


{- Note: Multiple args --}

divide x y = x / y
<function> : Float -> Float -> Float

-- **** Safe to say last paarm is the return type, others are input params. *****

-- Real case:
<function> : Int -> String -> String = Int -> (String -> String)

> divide x y = x / y
<function> : Float -> Float -> Float

> divide x = \y -> x / y
<function> : Float -> Float -> Float

> divide = \x -> (\y -> x / y)
<function> : Float -> Float -> Float
 {-
eval steps:
 divide 3 2
  (divide 3) 2                 -- Step 1 - Add the implicit parentheses
  ((\x -> (\y -> x / y)) 3) 2  -- Step 2 - Expand `divide`
  (\y -> 3 / y) 2              -- Step 3 - Replace x with 3
  3 / 2                        -- Step 4 - Replace y with 2
  1.5                          -- Step 5 - Do the math

-} 
-- Chaining 
-- e.g.
-- <|
f x == f <| x 
leftAligned (monospace (fromString "code")) == leftAligned <| monospace <| fromString "code"

-- |>
f x == x |> f 

scale 2 (move (10,10) (filled blue (ngon 5 30))) == 
ngon 5 30
  |> filled blue
  |> move (10,10)
  |> scale 2


-- Type aliasing - use an alias to represent complex data types

-- e.g.

hasBio : { name : String, bio : String, pic : String } -> Bool
hasBio user =
  String.length user.bio > 0

-- We can introduce an alias for user
type alias User =
  { name : String
  , bio : String
  , pic : String
  }
-- now nicer
hasBio : User -> Bool
hasBio user =
  String.length user.bio > 0