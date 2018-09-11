module Main exposing (Model, Msg(..), main, model, update, view)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = updatex
        }



-- MODEL
-- create an alias Model for type Int


type alias Model =
    Int


model : Model
model =
    0



-- UPDATE
-- messages we get from the UI


type Msg
    = Increment
    | Decrement
    | Reset



-- B) if I want to increment by whatever number?


type Msg
    = Increment Int
    | Decrement Int
    | Reset



-- what to do when you receive those messages


updatex :
    Msg
    -> Model
    -> Model -- definition of signature, when inputting msg and model, return a model



-- function definition. function_name - update, input_params - msg, model, what to do and return


update msg model =
    case msg of
        Increment ->
            model

        -- B) Increment + value -> model
        Decrement ->
            model - 1

        Reset ->
            0



-- VIEW
-- html DOM
-- func signature name : input -> output  - when input something of type Model, Html chunk that takes in a Msg and out put html


view : Model -> Html Msg
view model =
    -- htmlnode [attributes] [child nodes]
    div []
        [ button [ onClick Decrement ] [ text "-" ]

        -- B)[ button [ onClick <| Decrement 23 ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , Html.br [] []
        , button [ onClick Reset ] [ text "reset" ]
        ]



--B) represents the another scenario of declaring a type with a param
