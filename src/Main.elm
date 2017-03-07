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
    , contact =
        { email = ""
        , firstName = ""
        , lastName = ""
        , message = ""
        }
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

        ContactFormMsg msg_ ->
            { model | contact = (updateContact msg_ model.contact) } ! []

        Mdl msg_ ->
            Material.update Mdl msg_ model


updateContact : ContactMsg -> Contact -> Contact
updateContact msg contact =
    case msg of
        ContactEmailMsg email ->
            { contact | email = email }

        ContactFirstNameMsg firstName ->
            { contact | firstName = firstName }

        ContactLastNameMsg lastName ->
            { contact | lastName = lastName }

        ContactMessageMsg message ->
            { contact | message = message }
