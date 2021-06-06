module Main exposing (..)

import Material
import Models exposing (..)
import Navigation exposing (modifyUrl)
import Routing exposing (routeAsString, routeAsUrlFragment, routeByIndex)
import View exposing (..)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = View.root
        }


init : Navigation.Location -> ( Model, Cmd msg )
init location =
    { route = Routing.parseLocation location
    , mdl = Material.model
    , contact =
        { email = ""
        , firstName = ""
        , lastName = ""
        , message = ""
        }
    , projectType = InitialProjectType
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
                newRoute =
                    routeByIndex num
            in
            { model | route = newRoute }
                ! [ modifyUrl <|
                        routeAsUrlFragment newRoute
                  ]

        ContactFormMsg msg_ ->
            { model | contact = updateContact msg_ model.contact } ! []

        ChangeProjectType t ->
            { model | projectType = t } ! []

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

        ContactSubmit ->
            Contact "" "" "" ""
