module ViewAboutRoute exposing (viewAboutRoute)

import Html exposing (Html, a, button, div, h3, h4, img, li, p, span, text, ul)
import Html.Attributes exposing (attribute, href)
import HomepageCss exposing (CssClasses(..))
import Html.CssHelpers
import Html.Events exposing (onClick)
import Material
import Models exposing (Model, Msg(SelectTab, UrlChange))
import Material.Grid exposing (Device(All, Tablet), cell, grid, size)
import Models exposing (Msg(ChangeProjectType), ProjectType(..))
import Material.Button as Button


{ id, class, classList } =
    Html.CssHelpers.withNamespace "lutra"


viewAboutRoute : Model -> Html Msg
viewAboutRoute model =
    div [] <|
        List.concat
            [ landingImage
            , aboutContent
            , customerTypeList model.mdl model.projectType
            ]


customerTypeList : Material.Model -> ProjectType -> List (Html Msg)
customerTypeList mdl projectType =
    [ grid []
        [ cell [ size All 4, size Tablet 8 ]
            [ ul [] <|
                List.concat
                    [ captionedListIcon mdl "lutra_customer_new_project.svg" "I have a new project" NewProject projectType
                    , captionedListIcon mdl "lutra_customer_existing_project.svg" "I have an existing project" ExistingProject projectType
                    , captionedListIcon mdl "lutra_customer_out_of_hand.svg" "My project is getting out of hand" OutOfHand projectType
                    , captionedListIcon mdl "lutra_customer_sentient.svg" "My project may have become sentient" Sentient projectType
                    ]
            ]
        , cell [ size All 8, size Tablet 8] [ div [ class [ CustomerTypeContent, CustomerTypeContentNotPhone ] ] <| customerTypeContent mdl projectType ]
        ]
    ]


captionedListIcon : Material.Model -> String -> String -> ProjectType -> ProjectType -> List (Html Msg)
captionedListIcon mdl image caption projectMsg currentProjectType =
    let
        mainContent =
            li [ class [ ColoredListItem ], onClick onClick_ ]
                [ img
                    [ attribute "src" ("assets/" ++ image)
                    , class [ DrawerIcon ]
                    ]
                    []
                , span [ class [ Caption ] ] [ text caption ]
                ]

        onClick_ =
            if currentProjectType == projectMsg then
                    ChangeProjectType InitialProjectType
                else
                    ChangeProjectType projectMsg

        optionalContent =
            li [ class [ CustomerTypeContent, CustomerTypeContentPhone ] ] <| customerTypeContent mdl projectMsg

        node =
            if currentProjectType == projectMsg then
                [ mainContent, optionalContent ]
            else
                [ mainContent ]
    in
        node


customerTypeContent : Material.Model -> ProjectType -> List (Html Msg)
customerTypeContent mdl projectType =
    let
        content =
            case projectType of
                InitialProjectType ->
                    [ h3 [] [ text "Help for all project types" ]
                    , h4 [] [ text "choose your project from the list on the left" ]
                    ]

                NewProject ->
                    [ h3 [] [ text "A new project" ]
                    , p [] [ text """If you're unsure how to start development on your new project,
            we can help you manage your product: create a backlog, prioritize features,
            and validate hypotheses about your users' needs.
            """ ]
                    , p [] [ text "If you already know what you want, we can start building right away." ]
                    , contactButton mdl
                    ]

                ExistingProject ->
                    [ h3 [] [ text "An existing project" ]
                    , p [] [ text """Maybe you're getting more traffic than you can handle (good problems, right?),
                or your existing project isn't as easy to add features to as it used to be.""" ]
                    , p [] [ text "We've been there, and can help you with your problems, good or bad." ]
                    , contactButton mdl
                    ]

                OutOfHand ->
                    [ h3 [] [ text "A troublesome project" ]
                    , p [] [ text """If your releases are lagging farther and farther back,
             or if you're accumulating bugs faster than you're fixing them, we can help.
            """ ]
                    , contactButton mdl
                    ]

                Sentient ->
                    [ h3 [] [ text "Congratulations!" ]
                    , p [] [ text "Welcome to parenthood: contact me for advice on caring for your newly-hatched singularity." ]
                    , contactButton mdl
                    ]
    in
        content


contactButton : Material.Model -> Html Msg
contactButton mdl =
    a [ href ("#contact") ]
        [ Button.render Models.Mdl
            [ 1 ]
            mdl
            [ Button.raised
            , Button.colored
            ]
            [ text "contact me" ]
        ]


landingImage : List (Html msg)
landingImage =
    [ div [ class [ LandingImage ] ]
        [ div
            [ class [ SideMargins, LandingImageContent ] ]
            [ img
                [ attribute "src" "assets/lutra-logo.svg"
                , class [ LutraLogo ]
                ]
                []
            , h3 [] [ text "Build it Right the First Time" ]
            ]
        ]
    ]


aboutContent : List (Html msg)
aboutContent =
    [ div [ class [ SideMargins ] ]
        [ p [] [ text """
             Lutra is a software consultancy that aims to enable clients as they improve their
             software development process. If you own a software product you need help building,
             or have an idea for one, we can help you build your team and your product.
             Using modern agile tools and practices, features will be predictably delivered
             on time, with no surprises for developers or product owners.
             """ ]
        , p [] [ text """
            Lutra was founded by Charlie Bevis, who has been writing software for clients ranging from startups to
            Fortune 500 companies for nearly 8 years.

            Charlie has experience consulting in Ruby on Rails, C#, Java, and many flavors of JavaScript
             (Elm, React, Angular, Angular 2, BackboneJS and Ember),
             and is passionate about strongly-typed, maintainable languages like Elm.
            """ ]
        ]
    ]
