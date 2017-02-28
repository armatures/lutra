module HomepageCss exposing (css, CssClasses(..))

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements exposing (body)


type CssClasses
    = FlexContainer


css =
    (stylesheet << namespace "lutra")
        [ class FlexContainer
            [ backgroundColor (hex "123") ]
        , body
            [ backgroundColor (hex "CC7777") ]
        ]
