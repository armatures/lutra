module Main exposing (..)

import Html
import Material
import Models exposing (Model, Route(AboutRoute))
import Navigation
import Routing exposing (routeByIndex)
import Models exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = View.root
        }


init location =
    { route = Routing.parseLocation location
    , mdl = Material.model
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            { model | route = Routing.parseLocation location } ! []

        NoOp ->
            model ! []

        SelectTab num ->
            let
                _ =
                    Debug.log "SelectTab: " num
            in
                { model | route = routeByIndex num } ! []

        Mdl msg_ ->
            Material.update Mdl msg_ model
