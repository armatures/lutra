module View exposing (root)

import Char
import Css exposing (class, padding, px)
import HomepageCss exposing (CssClasses(..))
import Html exposing (Html, a, div, form, h1, h3, h4, img, input, label, li, p, span, text)
import Html.Attributes exposing (attribute, for, href, placeholder, style)
import List.Extra exposing (findIndex)
import Material
import Material.Grid exposing (Device(All), cell, grid, maxWidth, size)
import Material.Options exposing (css)
import Stylesheets exposing (..)
import Html.CssHelpers
import Models exposing (Msg(..), ContactMsg(..), Route(AboutRoute, ContactRoute, NotFoundRoute))
import Material.Layout as Layout
import Models
import Material.Card as Card
import Material.Elevation as Elevation
import Material.Textfield as Textfield
import Material.Options as Options
import Routing exposing (routeList, routeStrings)
import Material.Color as Color
import Material.Scheme
import Material.Button as Button


{ id, class, classList } =
    Html.CssHelpers.withNamespace "lutra"


styles =
    Css.asPairs >> Html.Attributes.style


root model =
    Material.Scheme.topWithScheme Color.Cyan Color.Indigo <|
        Layout.render Models.Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.onSelectTab SelectTab
            , Layout.selectedTab <| Maybe.withDefault -1 <| findIndex ((==) model.route) routeList
            ]
            { header =
                [ viewHeader model ]
            , drawer =
                []
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
                    viewAboutRoute model

                ContactRoute ->
                    viewContactRoute model

                NotFoundRoute ->
                    [ h3 [] [ text "Route not found" ]
                    , a [ href ("#about") ] [ text "Take me home" ]
                    ]

        contentClass =
            case model.route of
                ContactRoute ->
                    [ ContactContent ]

                otherwise ->
                    [ PageContent ]
    in
        div [ class contentClass ] content


viewAboutRoute model =
    [ h3 [] [ text "About Lutra:" ]
    , p [] [ text """
                    Lutra is a software consultancy that aims to enable clients as they improve their
                    software development process. If you own a software product you need help building,
                    or have an idea for one, we can help you build your team and your product.
                    Using modern agile tools and practices, features will be predictably delivered
                    on time, with no surprises for developers or product owners.
                    """ ]
    , h3 [] [ text "About Charlie:" ]
    , p [] [ text """
                    Charlie has experience consulting in Ruby on Rails,
                    C#, Java, and many flavors of JavaScript, and has been writing software for clients ranging from startups to
                    Fortune 500 companies for over 5 years.
                    In his spare time, Charlie develops applications in opinionated languages like Elm and Haskell.
                    He is interested in helping you develop and deliver your project on schedule and in a sustainable way
                    for your team.
                    """ ]
    , h4 [] [ text "Charlie on Front-end Development:" ]
    , p [] [ text """
                    I have developed application front ends using Angular, Angular 2, Elm, BackboneJS, React and Ember.
                     I have also rendered things to a page in production applications using Ruby/Rails/ERB,
                     or Razor and ASP.NET, but when people talk about the front-end in 2017, I assume we're talking
                     about Javascript frontends for the most part. I prefer Elm (with React coming in second) because
                     of its compile-time assurance of correctness, elegant type system, and time-traveling debugging.
                     It is much more pleasant than raw Javascript (or typescript), but I understand most shops are not
                     sold on it yet. If not Elm, I prefer React, because its unidirectional data flow makes for more
                     maintainable applications.
                    """ ]
    , h4 [] [ text "Charlie on Source Control and Branching Strategies:" ]
    , p [] [ text """
                    I prefer Git. Git is powerful, simple, and flexible. I've also used TFS and Perforce,
                     each of which seems less powerful and less simple from my experience of ~9 months with each of them.
                     I've done feature branches and pull requests for larger teams, or just pushed things to master on
                     smaller teams. I've worked on teams ranging from 1 pair of developers to upwards of 20 developers
                     working across different countries, and smaller teams obviously don't need to bother with the same
                     processes that larger teams have.
                    """ ]
    ]


viewContactRoute model =
    showCard
        [ form
            [ attribute "action" "https://formspree.io/charlie@lutra.tech"
            , attribute "method" "POST"
            , attribute "padding" "10px"
            ]
            [ showContactFormField 0
                model.mdl
                "Email"
                model.contact.email
                "email"
                (ContactFormMsg << ContactEmailMsg)
            , showContactFormField 1
                model.mdl
                "First Name"
                model.contact.firstName
                "text"
                (ContactFormMsg << ContactFirstNameMsg)
            , showContactFormField 2
                model.mdl
                "Last Name"
                model.contact.lastName
                "text"
                (ContactFormMsg << ContactLastNameMsg)
            , Textfield.render Models.Mdl
                [ 3 ]
                model.mdl
                [ Textfield.textarea
                , Textfield.label "Message"
                , Textfield.floatingLabel
                , Textfield.value model.contact.message
                , Options.onInput (ContactFormMsg << ContactMessageMsg)
                , Options.attribute <| Html.Attributes.style [ ( "minHeight", "150px" ) ]
                , Options.attribute <| Html.Attributes.attribute "name" "message"
                ]
                []
            , Button.render Mdl
                [ 4 ]
                model.mdl
                [ Button.raised
                , Button.colored
                , Options.onClick (ContactFormMsg ContactSubmit)
                ]
                [ text "Submit" ]
            , Textfield.render Models.Mdl
                [ 5 ]
                model.mdl
                [ css "display" "none"
                , Textfield.value model.contact.email
                , Options.attribute <| Html.Attributes.attribute "name" "_replyto"
                ]
                []
            ]
        ]


showContactFormField index mdl label field inputType msg =
    Textfield.render Models.Mdl
        [ index ]
        mdl
        [ Textfield.label label
        , Textfield.floatingLabel
        , Textfield.value field
        , Options.onInput msg
        , Options.attribute <| Html.Attributes.type_ inputType
        , Options.attribute <| Html.Attributes.attribute "name" <| String.filter Char.isLower <| String.toLower label
        ]
        []


showCard innerContent =
    [ Card.view
        [ Elevation.e8
        , css "margin" "0px auto"
        , css "min-width" "400px"
        , css "padding" "20px"
        ]
        [ Card.title
            [ css "flex-direction" "column" ]
            [ Card.head [] [ text "Let's Chat" ]
            , Card.subhead [] [ text "We'll build something great" ]
            ]
        , Card.actions []
            innerContent
        ]
    ]


viewLink : String -> Html msg
viewLink name =
    a [ href ("#" ++ name) ] [ text name ]
