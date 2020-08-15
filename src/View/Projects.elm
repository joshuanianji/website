module View.Projects exposing
    ( Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Browser.Navigation as Nav
import Colours
import Data.Project as Data exposing (Project)
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import FeatherIcons
import Html.Attributes
import Icon
import Json.Decode as Decode
import Routes exposing (Route)
import SharedState exposing (SharedState)
import String



---- MODEL ----


type Model
    = Failed Decode.Error
    | Success SuccessData


type alias SuccessData =
    { projects : List Project }


init : String -> Model
init str =
    case Data.fromJson str of
        Ok projects ->
            Success
                { projects = projects }

        Err err ->
            Failed err



---- VIEW ----


view : Model -> Element Msg
view model =
    Element.column
        [ Element.width (Element.maximum 800 Element.fill)
        , Element.centerX
        , Element.spacing 32

        -- distinct id for us to jump to
        , Element.htmlAttribute <| Html.Attributes.id "projects"
        ]
        [ -- title
          Element.paragraph
            [ Element.htmlAttribute <| Html.Attributes.class "fat-underline"
            , Element.width Element.shrink
            , Element.paddingXY 0 4
            , Font.size 50
            , Font.family [ Font.typeface "Playfair Display SC" ]

            -- link thingy
            , Element.onLeft <|
                Icon.view
                    [ Element.centerY
                    , Element.paddingXY 16 0
                    ]
                    { icon = FeatherIcons.link
                    , strokeWidth = 2
                    , color = Colours.gray
                    , size = 25
                    , msg =
                        Just
                            { hoverColor = Just Colours.themeBlue
                            , msg = NavigateTo Routes.Projects
                            }
                    }
            ]
            [ Element.text "Projects" ]
        , case model of
            Failed err ->
                viewErr err

            Success data ->
                viewProjects data
        ]


viewErr : Decode.Error -> Element Msg
viewErr err =
    Element.text <| "error! " ++ Decode.errorToString err


viewProjects : SuccessData -> Element Msg
viewProjects data =
    Element.column
        [ Element.width Element.fill ]
        [ Element.column
            [ Element.spacing 16
            , Element.width Element.fill
            ]
          <|
            List.map viewProject data.projects
        ]



-- view a single project


viewProject : Project -> Element Msg
viewProject proj =
    let
        viewConcept concept =
            Element.el
                [ Element.paddingXY 6 3
                , Border.rounded 4
                , Background.color <| Colours.toElement Colours.themeBlue
                , Font.size 16
                , Font.color <| Colours.toElement Colours.white
                ]
            <|
                Element.text (Data.conceptToString concept)
    in
    Element.column
        [ Element.spacing 12
        , Element.padding 24
        , Element.width Element.fill
        , Border.width 1
        , Border.rounded 8
        , Border.color <| Colours.toElement Colours.gray
        , Element.mouseOver
            [ Border.color <| Colours.toElement Colours.black ]
        ]
        [ Element.el
            [ Font.bold
            ]
          <|
            Element.text proj.name

        -- year
        , Element.el
            [ Font.light
            , Font.size 12
            , Font.color <| Colours.toElement <| Colours.withAlpha 0.7 Colours.black
            ]
          <|
            Element.text (String.fromInt proj.year)
        , Element.paragraph
            [ Font.size 18 ]
            [ Element.text proj.blurb ]
        , case proj.concepts of
            Nothing ->
                Element.none

            Just concepts ->
                Element.row
                    [ Element.spacing 5 ]
                    (List.map viewConcept concepts)
        ]



---- UPDATE ----


type Msg
    = NavigateTo Route


update : SharedState -> Msg -> Model -> ( Model, Cmd Msg )
update sharedState msg model =
    case msg of
        NavigateTo route ->
            ( model, Nav.pushUrl sharedState.navKey (Routes.toUrlString route) )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
