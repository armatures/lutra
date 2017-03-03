module View exposing (root)

import Css exposing (class, padding, px)
import HomepageCss exposing (CssClasses(..))
import Html exposing (Html, a, div, form, h1, h3, img, input, label, li, p, span, text)
import Html.Attributes exposing (attribute, for, href, placeholder, style)
import Material
import Stylesheets exposing (..)
import Html.CssHelpers
import Models exposing (Msg(SelectTab), Route(AboutRoute, ContactRoute, NotFoundRoute))
import Material.Layout as Layout
import Models


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
        , tabs = ( [ text "About", text "Contact" ], [] )
        , main =
            [ viewPageContent model
            ]
        }



--        div
--        [ class [ PageWrapper ] ]
--        [ viewHeader model
--        , viewPageContent model
--        ]


viewHeader model =
    div [ class [ Header ] ]
        [ img
            [ attribute "src" "assets/lutra-logo.svg"
            , styles [ padding (px 10) ]
            , class [ LutraLogo ]
            ]
            []
        , div [ styles [ Css.flexGrow (Css.num 1) ] ] []
        , div [ class [ HeaderLinks ] ]
            [ viewLink "about"
            , viewLink "contact"
            ]
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
                    [ h3 [] [ text "Contact" ]
                      --                    , div [ class [ Buffer ] ] []
                    , form [ class [ ContactForm ] ]
                        [ input [ id "contactFirstName", placeholder "First Name" ] []
                        , input [ id "contactLastName", placeholder "Last Name" ] []
                        , input [ id "contactCompany", placeholder "Company" ] []
                        , input [ id "contactEmail", placeholder "Email" ] []
                        , input [ id "contactMessage", placeholder "Your Message" ] []
                        , input [ attribute "type" "submit" ] []
                        ]
                    ]

                NotFoundRoute ->
                    [ h3 [] [ text "Route not found" ]
                    , a [ href ("#about") ] [ text "Take me home" ]
                    ]
    in
        div [ class [ PageContent ] ] content


viewLink : String -> Html msg
viewLink name =
    a [ href ("#" ++ name) ] [ text name ]
