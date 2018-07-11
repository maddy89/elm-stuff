import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode



main =
  Html.program
    { init = init "cats"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { topic : String
  , gifUrl : String
  }


init : String -> (Model, Cmd Msg)
init topic =
  ( Model topic "waiting.gif"
  , getRandomGif topic
  )



-- UPDATE


type Msg
  = MorePlease
  | NewGif (Result Http.Error String) -- "Result" can be either http error or a string


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getRandomGif model.topic)

    NewGif (Ok newUrl) ->
      (Model model.topic newUrl, Cmd.none)

    NewGif (Err _) ->
      (model, Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , br [] []
    , img [src model.gifUrl] []
    ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
      
      request = Http.get decodeGifUrl url -- Http.get : String -> Decode.Decoder value -> Http.Request value - 
  in
  -- can be replaced by (Http.get url decodeGifUrl)
    Http.send NewGif request -- Http.send : (Result Error value -> msg) -> Http.Request value -> Cmd msg



decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string


-- Commands — A Cmd lets you do stuff: generate a random number, send an HTTP request, etc.

-- Subscriptions — A Sub lets you register that you are interested in something: tell me about location changes, listen for web socket messages, etc.


--The update function now returns more than just a new model. 
--It returns a new model and some commands you want to run. 
--These commands are all going to produce Msg values that will get fed right back into our update function.

--There is a subscriptions function. 
--This function lets you declare any event sources you need to subscribe to given the current model. 
--Just like with Html Msg and Cmd Msg, these subscriptions will produce Msg values that get fed right back into our update function.

--So far init has just been the initial model. 
--Now it produces both a model and some commands, just like the new update. 
--This lets us provide a starting value and kick off any HTTP requests or whatever that are needed for initialization.