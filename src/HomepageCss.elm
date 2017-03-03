module HomepageCss exposing (css, CssClasses(..))

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements exposing (a, body, h3, input)


type CssClasses
    = HeaderLinks
    | PageWrapper
    | Header
    | PageContent
    | LutraLogo
    | ContactForm


css =
    (stylesheet << namespace "lutra")
        [ class Header
            [--            backgroundColor (hex "CC8888")
             --            , displayFlex
             --            , flexDirection row
             --            , children
             --                [ class LutraLogo
             --                    [ flexGrow (num 0)
             --                    ]
             --                ]
            ]
        , class HeaderLinks
            [ displayFlex
            , children
                [ a
                    [ padding (px 20)
                    , verticalAlign middle
                    ]
                ]
            ]
        , class LutraLogo
            [ maxHeight (px 100)
            ]
        , class PageWrapper []
        , class PageContent
            [ padding (px 30)
            ]
        , class ContactForm
            [ boxShadow5 zero zero (px 15) (px 10) (rgba 0 0 0 0.1)
            , maxWidth (px 660)
            , padding (px 30)
            , flexGrow (num 0)
            , margin2 zero auto
            ]
        , input
            [ margin (px 15)
            , backgroundColor (rgb 245 245 245)
            , boxShadow none
            , border3 (px 1) solid (rgb 200 200 200)
            , height (px 40)
            , width (px 260)
            , padding (px 10)
            ]
        , body
            [ margin (px 0)
            , fontFamilies [ qt ("Quicksand"), "Helvetica", .value sansSerif ]
            ]
        , h3
            [ fontFamilies [ qt ("Rubik"), "Helvetica", .value sansSerif ]
            ]
        ]
