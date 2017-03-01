module Main exposing (..)

import Html
import Models exposing (Model, Route(AboutRoute))
import Navigation
import Routing
import View exposing (..)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = \location -> ( { route = Routing.parseLocation location }, Cmd.none )
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = View.root
        }


type Msg
    = NoOp
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | route = Routing.parseLocation location }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
