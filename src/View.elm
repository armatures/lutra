module View exposing (root)

import Css exposing (class)
import HomepageCss exposing (CssClasses(FlexContainer))
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (attribute)
import Stylesheets exposing (..)
import Html.CssHelpers


{ id, class, classList } =
    Html.CssHelpers.withNamespace "lutra"


root model =
    div [ class [ FlexContainer ] ]
        [ img
            [ attribute "src" "assets/lutra-logo.svg"
            ]
            []
        , text "hello"
        ]
