module Main exposing (..)

import Html
import View exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = ( {}, Cmd.none )
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = View.root
        }


type alias Model = {}
type Msg = NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update _ model = (model, Cmd.none)