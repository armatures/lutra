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
    , contact = { email = "" }
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
            { model | route = routeByIndex num } ! []

        ContactEmailMsg email ->
            let
                contact =
                    model.contact

                newContact =
                    { contact | email = email }
            in
                { model | contact = newContact } ! []

        Mdl msg_ ->
            Material.update Mdl msg_ model
