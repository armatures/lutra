module View exposing (root)

import Css exposing (class, padding, px)
import HomepageCss exposing (CssClasses(..))
import Html exposing (Html, a, div, h3, img, p, span, text)
import Html.Attributes exposing (attribute)
import Stylesheets exposing (..)
import Html.CssHelpers


{ id, class, classList } =
    Html.CssHelpers.withNamespace "lutra"


styles =
    Css.asPairs >> Html.Attributes.style


root model =
    div [ class [ PageWrapper ] ]
        [ div [ class [ Header ] ]
            [ img
                [ attribute "src" "assets/lutra-logo.svg"
                , styles [ padding (px 10) ]
                , class [ LutraLogo ]
                ]
                []
            , div [ styles [ Css.flexGrow (Css.num 1) ] ] []
            , div [ class [ HeaderLinks ] ]
                [ a [] [ text "about" ]
                , a [] [ text "contact" ]
                ]
            ]
        , div [ class [ PageContent ] ]
            [ p [] [ text """
                Lutra is a software consultancy that aims to enable clients as they improve their software development
                process. If you own a software product you need help building, have an idea you'd like to make reality,
                or have a team of developers that aren't delivering reliably, we can help you build your team and your product.
                Using modern agile practices, features will be predictably delivered on time, with no surprises for
                developers or product owners.
                """ ]
            , h3 [] [ text "About Charlie:" ]
            , p [] [ text """
                Charlie has experience consulting in Ruby on Rails,
                C#, Java, and many flavors of JavaScript, and has been writing software for clients ranging from startups to
                Fortune 500 players for over 5 years.
                In his spare time, Charlie develops applications in opinionated languages like Elm and Haskell,
                but is interested in helping you develop and deliver your project on schedule and in a sustainable way
                for your team.
                """ ]
            ]
        ]
