module HomepageCss exposing (css, CssClasses(..))

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements exposing (a, body, h3, input)


type CssClasses
    = HeaderLinks
    | PageWrapper
    | Header
    | SideMargins
    | CardBackground
    | LandingImage
    | LandingImageContent
    | LutraLogo
    | ContactForm
    | CenteredCard
    | DrawerIcon
    | CustomerTypeContentNotPhone
    | CustomerTypeContentPhone
    | CustomerTypeContent
    | Caption
    | ColoredListItem
    | CustomerIcon


css =
    (stylesheet << namespace "lutra") <|
        [ class Header []
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
            , padding (px 10)
            ]
        , class PageWrapper
            [ backgroundColor (rgb 155 0 0)
            ]
        , class SideMargins
            [ padding2 zero (px 30) ]
        , phoneOnly [ class CenteredCard [ margin auto ] ]
        , notAPhone
            [ class CenteredCard
                [ margin2 (px 10) auto
                , minWidth (px 400)
                , padding (px 20)
                ]
            ]
        , class ContactForm
            [ boxShadow5 zero zero (px 15) (px 10) (rgba 0 0 0 0.1)
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
        , class CardBackground
            [ padding2 (px 10) zero
            , boxSizing borderBox
            , minHeight <| pct 100
            ]
        , class LandingImage
            [ backgroundSize cover
            , minHeight (pct 50)
            , marginBottom (px 40)
            , backgroundPosition center
            ]
        , class LandingImageContent
            [ textAlign center
            , padding2 (px 100) (px 100)
            , color white
            ]
        , class CustomerTypeContent
            [ verticalAlign center
            , textAlign center
            ]
        , phoneOnly [ class CustomerTypeContentNotPhone [ display none, padding2 (pct 10) (pct 10) ] ]
        , notAPhone [ class CustomerTypeContentPhone [ display none ] ]
        , class DrawerIcon
            [ maxWidth (px 100)
            , flex auto
            , borderRight3 (px 3) solid (rgb 255 255 255)
            ]
        , notAPhone [ class CustomerIcon [ width (pct 70), margin2 (px 10) zero ] ]
        , phoneOnly [ class CustomerIcon [ width (pct 100), margin2 (px 10) zero ] ]
        , class Caption
            [ padding (px 10)
            , textAlign center
            , fontSize (px 18)
            , flex auto
            ]
        , class ColoredListItem
            [ backgroundColor primary
            , color white
            , displayFlex
            , margin <| px 10
            , cursor pointer
            ]
        , selector "ul"
            [ padding zero
            ]
        ]
            ++ (scaledBackgroundImage CardBackground "city1")
            ++ (scaledBackgroundImage LandingImage "landing")


primary =
    rgb 0 188 212


white =
    rgb 255 255 255


lightGrey =
    rgb 200 200 200


scaledBackgroundImage class_ imageName =
    [ notAPhone [ class class_ [ backgroundSize cover ] ]
    , small [ class class_ [ backgroundImage <| url <| "assets/" ++ imageName ++ "-1500-1000.jpg" ] ]
    , medium [ class class_ [ backgroundImage <| url <| "assets/" ++ imageName ++ "-2400-1600.jpg" ] ]
    , largest [ class class_ [ backgroundImage <| url <| "assets/" ++ imageName ++ "-3600-2400.jpg" ] ]
    ]


phoneOnly =
    mediaQuery "screen and ( max-width: 600px )"


notAPhone =
    mediaQuery "screen and ( min-width: 600px )"


small =
    mediaQuery "screen and ( max-width: 1500px )"


medium =
    mediaQuery "screen and ( min-width: 1501px ) and ( max-width: 2400px )"


largest =
    mediaQuery "screen and ( min-width: 2401px )"
