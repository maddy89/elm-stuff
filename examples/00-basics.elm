-- Functions


-- In this case the signature is saying: Given an integer (Int) as argument return another integer.
addOne : Int -> Int --signature
addOne x = --definition
  x + 1
addOne 3 --call


-- A function that takes no arguments is a constant in Elm:
name =
  "Sam"

 String.length
-- <function> : String -> Int, must take a string arg and return int

-- in Elm all functions take exactly one argument and return a result. This result can be another function. Let's explain this using the function above.
-- When we do:

divide 5 2

-- This is evaluated as:

((divide 5) 2)

-- First `divide 5` is evaluated.
-- The argument `5` is applied to `divide`, resulting in an intermediate function.

divide 5 -- -> intermediate function

-- Let's call this intermediate function `divide5`.
-- If we could see the signature and body of this intermediate function, it would look like:

divide5 : Float -> Float
divide5 y =
  5 / y

-- So we have a function that has the `5` already applied.

-- Then the next argument is applied i.e. `2`

divide5 2

-- And this returns the final result



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


add 1 (multiply 2 3)
sum (filter (isOver 100) (map getCost records))

3
    |> multiply 2
    |> add 1

records
    |> map getCost
    |> filter (isOver 100)
    |> sum

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


-- type variables - like generics - can pass any type

indexOf : String -> List String -> Int -- enforces to pass a list of strings only

indexOf : a -> List a -> Int -- can pass any list as long as types match








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


-- Union Types - Whenever you have weird shaped data in Elm, you want to reach for a union type

type Visibility = All | Active | Completed

keep : Visibility -> List Task -> List Task
keep visibility tasks =
  case visibility of
    All ->
      tasks

    Active ->
      List.filter (\task -> not task.complete) tasks

    Completed ->
      List.filter (\task -> task.complete) tasks

-- to enforce a value but keep an unassigned value as well:
type User = Anonymous | Named String

> Anonymous
Anonymous : User

> Named
<function> : String -> User

-- usage:
Anonymous
Named "AzureDiamond"
Named "abraham-lincoln"


-- Reuseable views

view : Model -> Html Msg
view model =
  fieldset []
    [ label []
        [ input [ type_ "checkbox", onClick ToggleNotifications ] []
        , text "Email Notifications"
        ]
    , label []
        [ input [ type_ "checkbox", onClick ToggleAutoplay ] [] -- repeating
        , text "Video Autoplay"
        ]
    , label []
        [ input [ type_ "checkbox", onClick ToggleLocation ] [] -- repeating
        , text "Use Location"
        ]
    ]

-- after converting into a reusable checkbox:
checkbox: msg -> String -> Html msg

checkbox msg name = 
label []
        [ input [ type_ "checkbox", onClick msg ] []
        , text name
        ]

view model =
  fieldset []
    [ label []
        [ checkbox ToggleNotifications "Email Notifications"]
    , label []
        [ checkbox ToggleAutoplay "Video Autoplay"]
    , label []
        [ checkbox ToggleLocation "Use Location"]
    ]


-- Modules

-- defining module
module Optional exposing (..) 
-- module code

-- importing module
import Optional


import Optional as Opt


