module Models exposing (Route(..), Model, Msg(..), ContactMsg(..), Contact)

import Material
import Navigation


type alias Model =
    { route : Route
    , mdl : Material.Model
    , contact : Contact
    }


type alias Contact =
    { email : String
    , firstName : String
    , lastName : String
    , message : String
    }


type ContactMsg
    = ContactEmailMsg String
    | ContactFirstNameMsg String
    | ContactLastNameMsg String
    | ContactMessageMsg String


type Route
    = AboutRoute
    | ContactRoute
    | NotFoundRoute


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | Mdl (Material.Msg Msg)
    | SelectTab Int
    | ContactFormMsg ContactMsg
