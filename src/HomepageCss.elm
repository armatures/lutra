module HomepageCss exposing (css, CssClasses(..))

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements exposing (a, body)


type CssClasses
    = HeaderLinks
    | PageWrapper
    | Header
    | PageContent
    | LutraLogo


css =
    (stylesheet << namespace "lutra")
        [ class Header
            [ backgroundColor (hex "CC8888")
            , displayFlex
            , flexDirection row
            , children
                [ class LutraLogo
                    [ flexGrow (num 0)
                    ]
                ]
            ]
        , class HeaderLinks
            [ backgroundColor (rgb 255 0 200)
            , verticalAlign top
            , displayFlex
            , children
                [ a
                    [ padding (px 20)
                    , flex auto
                    ]
                ]
            ]
        , class PageWrapper []
        , class PageContent
            [ padding (px 30)
            ]
        , body
            [ margin (px 0)
            , fontFamilies [ "Helvetica", .value sansSerif ]
            ]
        ]
