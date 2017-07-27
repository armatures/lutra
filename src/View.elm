module View exposing (root)

import Char
import Css exposing (class, padding, px)
import HomepageCss exposing (CssClasses(..))
import ViewAboutRoute exposing (viewAboutRoute)
import Html exposing (Html, a, div, form, h1, h3, h4, img, input, label, li, p, span, text)
import Html.Attributes exposing (attribute, for, href, placeholder, style)
import List.Extra exposing (findIndex)
import Material
import Material.Grid exposing (Cell, Device(All), cell, grid, maxWidth, size)
import Material.Options exposing (Style, css)
import Stylesheets exposing (..)
import Html.CssHelpers
import Models exposing (ContactMsg(..), Msg(..), Route(AboutRoute, ContactRoute, NotFoundRoute, ThanksRoute))
import Material.Layout as Layout
import Models
import Material.Card as Card
import Material.List as Lists
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
            , class [ LutraLogo ]
            ]
            []
        ]


viewPageContent model =
    case model.route of
        AboutRoute ->
            viewAboutRoute model

        ContactRoute ->
            viewContactRoute model.mdl model.contact

        ThanksRoute ->
            viewThanksRoute model

        NotFoundRoute ->
            div [ class [ SideMargins ] ]
                [ h3 [] [ text "Route not found" ]
                , a [ href ("#about") ] [ text "Take me home" ]
                ]


viewContactRoute mdl contact =
    div [ class [ CardBackground ] ]
        [ showCard
            "Let's Chat"
            "We'll build something great"
            [ form
                [ attribute "action" "https://formspree.io/charlie@lutra.tech"
                , attribute "method" "POST"
                , attribute "padding" "10px"
                ]
                [ showContactFormField 0
                    mdl
                    "Email"
                    contact.email
                    "email"
                    (ContactFormMsg << ContactEmailMsg)
                , showContactFormField 1
                    mdl
                    "First Name"
                    contact.firstName
                    "text"
                    (ContactFormMsg << ContactFirstNameMsg)
                , showContactFormField 2
                    mdl
                    "Last Name"
                    contact.lastName
                    "text"
                    (ContactFormMsg << ContactLastNameMsg)
                , Textfield.render Models.Mdl
                    [ 3 ]
                    mdl
                    [ Textfield.textarea
                    , Textfield.label "Message"
                    , Textfield.floatingLabel
                    , Textfield.value contact.message
                    , Options.onInput (ContactFormMsg << ContactMessageMsg)
                    , Options.attribute <| Html.Attributes.style [ ( "minHeight", "150px" ) ]
                    , Options.attribute <| Html.Attributes.attribute "name" "message"
                    ]
                    []
                , Button.render Mdl
                    [ 4 ]
                    mdl
                    [ Button.raised
                    , Button.colored
                    , Options.onClick (ContactFormMsg ContactSubmit)
                    ]
                    [ text "Submit" ]
                , hiddenField 5 mdl contact.email "_replyto"
                , hiddenField 6 mdl "#thanks" "_next"
                , hiddenField 7 mdl "New contact through Lutra.tech" "_subject"
                ]
            ]
        ]


viewThanksRoute model =
    div [ class [ CardBackground ] ] <|
        [ showCard
            "Thanks for reaching out!"
            "We'll be in touch in the next day or so."
            []
        ]


hiddenField index mdl value fieldName =
    Textfield.render Models.Mdl
        [ index ]
        mdl
        [ css "display" "none"
        , Textfield.value value
        , Options.attribute <| Html.Attributes.attribute "name" fieldName
        ]
        []


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


showCard head subhead innerContent =
    Card.view
        [ Elevation.e8
        , Options.attribute <| class [ CenteredCard ]
        ]
        [ Card.title
            [ css "flex-direction" "column" ]
            [ Card.head [] [ text head ]
            , Card.subhead [] [ text subhead ]
            ]
        , Card.actions []
            innerContent
        ]


viewLink : String -> Html msg
viewLink name =
    a [ href ("#" ++ name) ] [ text name ]
