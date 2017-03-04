module View exposing (root)

import Css exposing (class, padding, px)
import HomepageCss exposing (CssClasses(..))
import Html exposing (Html, a, div, form, h1, h3, img, input, label, li, p, span, text)
import Html.Attributes exposing (attribute, for, href, placeholder, style)
import Material
import Material.Grid exposing (Device(All), cell, grid, maxWidth, size)
import Material.Options exposing (css)
import Stylesheets exposing (..)
import Html.CssHelpers
import Models exposing (Msg(..), Route(AboutRoute, ContactRoute, NotFoundRoute))
import Material.Layout as Layout
import Models
import Material.Card as Card
import Material.Elevation as Elevation
import Material.Textfield as Textfield
import Material.Options as Options
import Routing exposing (routeStrings)


{ id, class, classList } =
    Html.CssHelpers.withNamespace "lutra"


styles =
    Css.asPairs >> Html.Attributes.style


root model =
    Layout.render Models.Mdl
        model.mdl
        [ Layout.fixedHeader
        , Layout.onSelectTab SelectTab
          --        , Layout.fixedDrawer
          --        , Options.css "display" "flex !important"
          --        , Options.css "flex-direction" "row"
          --        , Options.css "align-items" "center"
        ]
        { header =
            [ viewHeader model ]
        , drawer =
            []
            --            [ drawerHeader model, viewDrawer model ]
        , tabs = ( List.map text routeStrings, [] )
        , main =
            [ viewPageContent model
            ]
        }


viewHeader model =
    div []
        [ img
            [ attribute "src" "assets/lutra-logo.svg"
            , styles [ padding (px 10) ]
            , class [ LutraLogo ]
            ]
            []
        ]


viewPageContent model =
    let
        content =
            case model.route of
                AboutRoute ->
                    [ h3 [] [ text "About Lutra:" ]
                    , p [] [ text """
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

                ContactRoute ->
                    (showCard
                        [ grid [ maxWidth "660px" ]
                            [ cell [ size All 4 ] [ input [ id "contactFirstName", placeholder "First Name" ] [] ]
                            , cell [ size All 4 ] [ input [ id "contactLastName", placeholder "Last Name" ] [] ]
                            , cell [ size All 4 ] [ input [ id "contactCompany", placeholder "Company" ] [] ]
                            , cell [ size All 4 ] [ input [ id "contactEmail", placeholder "Email" ] [] ]
                            , cell [ size All 4 ] [ input [ id "contactMessage", placeholder "Your Message" ] [] ]
                            , cell [ size All 4 ] [ input [ attribute "type" "submit" ] [] ]
                            ]
                        ]
                    )
                        ++ (showCard
                                [ Textfield.render Models.Mdl
                                    [ 0 ]
                                    model.mdl
                                    [ Textfield.label "Email"
                                    , Textfield.floatingLabel
                                    , Textfield.value model.contact.email
                                    , Options.onInput ContactEmailMsg
                                    ]
                                    []
                                ]
                           )

                NotFoundRoute ->
                    [ h3 [] [ text "Route not found" ]
                    , a [ href ("#about") ] [ text "Take me home" ]
                    ]
    in
        div [ class [ PageContent ] ] content


showCard innerContent =
    [ Card.view [ Elevation.e8 ]
        [ Card.title
            [ css "flex-direction" "column" ]
            [ Card.head [] [ text "Let's Chat" ]
            , Card.subhead [] [ text "We'll build something great" ]
            ]
        , Card.actions []
            innerContent
        ]
    ]



--contactCard =
--    Card.view
--        [ css "width" "256px" ]
--        [ Card.title
--            [ css "flex-direction" "column" ]
--            [ Card.head [] [ text "Copenhagen" ]
--            , Card.subhead [] [ text "Wed, 14:55, mostly cloudy" ]
--              --        , Options.div
--              --            [ css "padding" "2rem 2rem 0 2rem" ]
--              --            [ Options.span
--              --                [ Typography.display4
--              --                , Color.text Color.primary
--              --                ]
--              --                [ text "21°" ]
--              --            ]
--            ]
--        ]


viewLink : String -> Html msg
viewLink name =
    a [ href ("#" ++ name) ] [ text name ]
