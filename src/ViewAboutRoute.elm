module ViewAboutRoute exposing (viewAboutRoute)

import Html exposing (Html, a, button, div, h3, h4, img, li, p, span, text, ul)
import Css exposing (class)
import Html.Attributes exposing (attribute, href)
import HomepageCss exposing (CssClasses(..))
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Msg(SelectTab, UrlChange))
import Material.Grid exposing (Device(All), cell, grid, size)
import Models exposing (Msg(ChangeProjectType), ProjectType(..))
import Material.Options as Options
import Material.Button as Button
import Navigation

{ id, class, classList } =
    Html.CssHelpers.withNamespace "lutra"

viewAboutRoute model =
    div []
        <| List.concat
        [ landingImage
        , customerTypeList model.mdl model.projectType
--        , bottomAboutContent
        ]

captionedListIcon image caption onclick_ =
    li [class [ ColoredListItem ], onClick onclick_ ]
        [  img
               [ attribute "src" ("assets/" ++ image)
               , class [ DrawerIcon ]
               ]
               []
            , span [class[ Caption ]][text caption]
        ]

customerTypeList mdl projectType =
    [ grid []
        [
            cell [size All 4] [
                ul []
                    [ captionedListIcon "lutra_customer_new_project.svg" "I have a new project" (ChangeProjectType NewProject)
                    , captionedListIcon "lutra_customer_existing_project.svg" "I have an existing project" (ChangeProjectType ExistingProject)
                    , captionedListIcon "lutra_customer_out_of_hand.svg" "My project is getting out of hand" (ChangeProjectType OutOfHand)
                    , captionedListIcon "lutra_customer_sentient.svg" "My project may have become sentient" (ChangeProjectType Sentient)
                    ]
                ]
            , cell [ size All 8 ] <| [customerTypeContent mdl projectType]
        ]
    ]

customerTypeContent mdl projectType =
        case projectType of
        InitialProjectType -> div[class [CustomerTypeContent]]
            [
            h3 [][text "Help for all project types"]
            , h4 [][text "choose your project from the list on the left"]
            ]
        NewProject -> div[class [CustomerTypeContent]]
            [ h3 [][ text "A new project" ]
            , p [][ text """If you're unsure how to start development on your new project,
            we can help you manage your product: create a backlog, prioritize features,
            and validate hypotheses about your users' needs.
            """ ]
            , p [][ text "If you already know what you want, we can start building right away."]
            , contactButton mdl
            ]
        ExistingProject -> div[class [CustomerTypeContent]][
             h3 [][ text "An existing project"]
            , p [] [ text """Maybe you're getting more traffic than you can handle (good problems, right?),
                or maybe your existing project isn't as easy to add features to as it used to be."""]
            , p [] [ text "We've been there, and can help you with your problems, good or bad."]
            , contactButton mdl
            ]
        OutOfHand -> div[class [CustomerTypeContent]]
            [ h3 [][ text "A troublesome project" ]
            , p [] [ text """If your releases are lagging farther and farther back,
             or if you're accumulating bugs faster than you're fixing them, we can help.
            """]
            , contactButton mdl]
        Sentient -> div[class [CustomerTypeContent]]
            [ h3 [] [ text "Congratulations!"]
            , p [] [ text "Welcome to parenthood: contact me for advice on caring for your newly-hatched singularity." ]
            , contactButton mdl
            ]

contactButton mdl =
    a [ href ("#contact") ] [ Button.render Models.Mdl
          [ 1 ]
          mdl
          [ Button.raised
          , Button.colored
          ]
          [ text "contact me" ]
          ]

landingImage =
    [ div [ class [ LandingImage ] ][ div
        [ class [ SideMargins, LandingImageContent ] ]
        [ img
              [ attribute "src" "assets/lutra-logo.svg"
              , class [ LutraLogo ]
              ]
              []
        , h3[][ text "Build it Right the First Time"]
        ]
    ]]

bottomAboutContent =
    [ div [ class [ SideMargins ] ] [
        h3 [] [ text "About Lutra:" ]
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
    ]
