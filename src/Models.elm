module Models exposing (Route(..), Model, Msg(..), ContactMsg(..), Contact, ProjectType(..))

import Material
import Navigation


type alias Model =
    { route : Route
    , mdl : Material.Model
    , contact : Contact
    , projectType : ProjectType
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
    | ContactSubmit


type Route
    = AboutRoute
    | ContactRoute
    | ThanksRoute
    | NotFoundRoute

type ProjectType
    = NewProject
    | ExistingProject
    | OutOfHand
    | Sentient
    | InitialProjectType


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | Mdl (Material.Msg Msg)
    | SelectTab Int
    | ContactFormMsg ContactMsg
    | ChangeProjectType ProjectType
