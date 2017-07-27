module ViewAboutRoute exposing (viewAboutRoute)

import Html exposing (div, h3, h4, p, text, img, li, ul, span)
import Css exposing (class)
import Html.Attributes exposing (attribute)
import HomepageCss exposing (CssClasses(..))
import Html.CssHelpers
import Material.Grid exposing (Device(All), cell, grid, size)

{ id, class, classList } =
    Html.CssHelpers.withNamespace "lutra"

viewAboutRoute model =
    div []
        <| List.concat
        [ landingImage
        , customerTypeList
        , bottomAboutContent
        ]

captionedListIcon image caption =
    li [class [ ColoredListItem ] ]
        [  img
               [ attribute "src" ("assets/" ++ image)
               , class [ DrawerIcon ]
               ]
               []
            , span [class[ Caption ]][text caption]
        ]


customerTypeList =
    [ grid []
        [
            cell [size All 2] [
                ul []
                    [ captionedListIcon "lutra_customer_new_project.svg" "I have a new project"
                    , captionedListIcon "lutra_customer_existing_project.svg" "I have an existing project"
                    , captionedListIcon "lutra_customer_out_of_hand.svg" "My problem, er, project is getting out of hand"
                    , captionedListIcon "lutra_customer_sentient.svg" "My project may have become sentient"
                    ]
                ]
            , cell [ size All 10 ] customerTypeContent
        ]
    ]

customerTypeContent = [h3 [class [CustomerTypeContent]][text """
                                  whether you have an existing codebase that has gotten out of hand, or a new idea
                                  you'd like built from scratch,
                                  you can trust us to deliver software your business can rely on.
                                  """]]

landingImage =
    [ div [ class [ LandingImage ] ][ div
        [ class [ SideMargins, LandingImageContent ] ]
        [ h3[][ text "writing software is a craft – project management is a science. We are experts at both."]
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
