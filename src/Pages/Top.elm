port module Pages.Top exposing (Model, Msg, Params, page)

import Css
import Css.Global
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import Html.Styled.Events exposing (..)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Tailwind.Breakpoints exposing (..)
import Tailwind.Utilities exposing (..)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


port startCamera : () -> Cmd msg


port takePicture : () -> Cmd msg


port clearPicture : () -> Cmd msg



-- INIT


type alias Params =
    ()


type alias Model =
    {}


init : Url Params -> ( Model, Cmd Msg )
init { params } =
    ( {}, startCamera () )



-- UPDATE


type Msg
    = ClickedButton
    | ClickedClear


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedButton ->
            ( model, takePicture () )

        ClickedClear ->
            ( model, clearPicture () )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Top"
    , body =
        [ div []
            [ Css.Global.global globalStyles
            , div [ css [ flex, justify_end ] ]
                [ button
                    [ onClick ClickedClear
                    , css
                        [ bg_blue_200
                        , text_blue_700
                        , p_4
                        , rounded
                        ]
                    ]
                    [ text "Clear Picture" ]
                , button
                    [ onClick ClickedButton
                    , css
                        [ bg_red_200
                        , text_red_700
                        , p_4
                        , rounded
                        ]
                    ]
                    [ text "Take Picture" ]
                ]
            , div
                [ css [ flex, justify_between ]
                ]
                [ div [ class "container" ]
                    [ node "video" [ attribute "autoplay" "true", id "videoElement" ] []
                    ]
                , node "canvas" [ id "canvas" ] []
                , div [ id "photo" ] []
                ]
            ]
        ]
    }
