import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )
import String
import Maybe exposing (withDefault)

-- official 'Elm Architecture' package
-- https://github.com/evancz/start-app
import StartApp.Simple as StartApp

-- component import example
import Components.Hello exposing ( hello )


type alias ConferenceTalkR =
    { speaker : String
    , slug : String
    , location : String
    , date : String
    , talkTitle : Maybe String
    , conferenceName : String
    , conferenceLink : String
    , speakerPhotoFilename: String
    , conferenceLogoFilename: String
    -- , company: Maybe String
    }

type alias MeetupR =
    { meetupGroupName : String
    , meetupTitle : String
    , location : String
    , date : String
    , meetupPageLink : String
    }

type alias SuggestedConferenceR =
    { name : String
    , date : String
    , submissionDeadline: String
    , link : String
    , location : String
    }

type Event
    = ConferenceTalk ConferenceTalkR
    | Meetup MeetupR

-- APP KICK OFF!
main =
  StartApp.start { model = model, view = mainView, update = update }


-- MODEL
model = 0



upcomingEvents : List Event
upcomingEvents =
    [ ConferenceTalk
         { conferenceName = "Melb JS"
         , slug = "melbjs-seb-porto"
         , conferenceLink = "http://melbjs.com"
         , talkTitle = Just "Elm"
         , speaker = "Sebastian Porto"
         , date = "13 January 2016"
         , location = "Melbourne, Australia"
         , conferenceLogoFilename = "melbjs.png"
         , speakerPhotoFilename = "sebastian-porto.jpg"
         }
    , Meetup
         { meetupGroupName = "Elm Seattle"
         , meetupTitle = "Elm Seattle Hack Night"
         , meetupPageLink = "http://www.google.com/url?q=http%3A%2F%2Fwww.eventbrite.com%2Fe%2Felm-seattle-hack-night-tickets-20526978746%3Faff%3Dutm_source%253Deb_email%2526utm_medium%253Demail%2526utm_campaign%253Dnew_event_email%26utm_term%3Deventurl_text&sa=D&sntz=1&usg=AFQjCNHYiILREiXD-cBD0-PnIY4bwyGIZQ"
         , date = "20 January 2016"
         , location = "Seattle, USA"
         }
    , ConferenceTalk
         { conferenceName = "Forward 4 Web Technology Summit"
         , slug = "forward4-evan-cz"
         , conferenceLink = "http://forwardjs.com/summit"
         , talkTitle = Nothing
         , speaker = "Evan Czaplicki"
         , date = "10 February 2016"
         , location = "San Franciso, USA"
         , conferenceLogoFilename = "forward4.png"
         , speakerPhotoFilename = "evan-czaplicki.jpg"
        --  ,
         }
    , ConferenceTalk
         { conferenceName = "Bob Konferenz"
         , slug = "bob-2016"
         , conferenceLink = "http://bobkonf.de/2016/grosse-boelting.html"
         , talkTitle = Just "Elm im produktiven Einsatz"
         , speaker = "Gregor Große-Bölting"
         , date = "19 February 2016"
         , location = "Berlin, Germany"
         , conferenceLogoFilename = "bob-conf.png"
         , speakerPhotoFilename = "gregor.jpg"
        --  ,
         }
    , ConferenceTalk
      { conferenceName = "React.js Conf"
      , slug = "reactjs-jamison-dance"
      , conferenceLink = "http://conf.reactjs.com/schedule.html#rethinking-all-practices-building-applications-in-elm"
      , talkTitle = Just "Rethinking All Practices: Building Applications in Elm"
      , speaker = "Jamison Dance"
      , date = "23 February 2016"
      , location = "San Franciso, USA"
      , conferenceLogoFilename = "reactjs-conf.png"
      , speakerPhotoFilename = "jamison-dance.jpg"
      }
    ]

suggestedConferences : List SuggestedConferenceR
suggestedConferences =
    [
        { name = "ReactEurope"
        , date = "June 2-3, 2016"
        , location = "Paris, France"
        , submissionDeadline = "25 January, 2016"
        , link = "https://www.react-europe.org/"
        }
    ,
        { name = "LambdaConf"
        , date = "May 26-19, 2016"
        , location = "Bolder, CO, USA"
        , submissionDeadline = "1 February, 2016"
        , link = "http://lambdaconf.us/"
        }
    ,
        { name = "Strange Loop"
        , date = "Sept 15-17th, 2016"
        , location = "St. Louis, USA"
        , submissionDeadline = "TBA"
        , link = "http://thestrangeloop.com/"
        }
    ]


confImage : String -> String -> Html
confImage filename idValue =
    div
        [ id idValue
        , class "conference-image"
        , style
            [ ("background-image", "url(media/" ++ filename ++ ")") ]
        ]
        []

speakerImage : String -> Html
speakerImage filename =
    img
        [ src ("media/" ++ filename)
        , style
            [ ("display", "inline")
            , ("width", "200px")
            , ("height", "200px")
            -- , ("height", "200px")
            ]
        ]
        []

talkView : ConferenceTalkR -> Html
talkView record =
    a [ class "event-card talk grow", href record.conferenceLink]
        [ div
            [ style [("display", "flex")]
            ]
            [ confImage record.conferenceLogoFilename (record.slug ++ "-conf-image")
            , speakerImage record.speakerPhotoFilename
            ]
        , div [class "talk-content"]
          [ h3 []
               [text (withDefault "Talk title to be announced" record.talkTitle)]
          , h4 [] [text ("by " ++ record.speaker)]
          , div [] [text record.date]
          , div [ class "location"] [text record.location]
          ]
        ]

meetupView : MeetupR -> Html
meetupView record =
    a [ class "event-card meetup grow", href record.meetupPageLink]
          [ div [ class "meetup-header"]
            [ h3 []
                [text record.meetupTitle]
            ]
          , div [ class "meetup-footer"]
            [ h4 []
                [text record.meetupGroupName]
            , div [] [text record.date]
            , div [ class "location"] [text record.location]
            ]
          ]

renderEvent : Event -> Html
renderEvent event =
    case event of
        ConferenceTalk record ->
            talkView record
        Meetup record ->
            meetupView record

renderEvents : List Event -> Html
renderEvents events =
    let
        eventViews = List.map renderEvent events
    in
        div [ class "upcoming-talks"]
            [ h2 [] [ text "Upcoming Conference Talks and Meetups" ]
            , div [ class "talks"]
                eventViews
            ]

renderSuggestedConference : SuggestedConferenceR -> Html
renderSuggestedConference conf =
    tr []
        [ td [] [text conf.name]
        , td [] [text conf.location]
        , td []  [text conf.date]
        , td [] [text conf.submissionDeadline]
        ]

renderSuggestedConferences : List SuggestedConferenceR -> Html
renderSuggestedConferences confs =
    let
        rows = List.map renderSuggestedConference confs
    in
        div [ class "suggested-conferences"]
            [ h2 [] [text "Suggested Conferences"]
            , p [] [text "Got some ideas or projects you want to tell people about?" ]
            , p [] [ text "Here are some upcoming conferences you might want to submit an application for."]
            , table []
                (
                    [ thead []
                        [ tr []
                            [ th [] [ text "Conference"]
                            , th [] [ text "Where"]
                            , th [] [ text "When"]
                            , th [] [ text "Submission Deadline"]
                            ]
                        ]
                    , tbody []
                        rows
                    ]
                )
            ]



-- mainView : Html
mainView address model =
    div []
        [ header []
            [ h1 [] [ text "Elm Events" ]
            ]
        , renderEvents upcomingEvents
        , renderSuggestedConferences suggestedConferences
        ]
-- VIEW
-- Examples of:
-- 1)  an externally defined component ('hello', takes 'model' as arg)
-- 2a) styling through CSS classes (external stylesheet)
-- 2b) styling using inlne style attribute (two variants)
view address model =
  div
    [ class "mt-palette-accent", style styles.wrapper ]
    [
      hello model,
      p [ style [( "color", "#FFF")] ] [ text ( "Elm Webpack Starter" ) ],
      button [ class "mt-button-sm", onClick address Increment ] [ text "FTW!" ]
    ]


-- UPDATE
type Action = Increment

update action model =
  case action of
    Increment -> model + 1


-- CSS STYLES
styles =
  {
    wrapper =
      [
        ( "padding-top", "10px" ),
        ( "padding-bottom", "20px" ),
        ( "text-align", "center" )
      ]
  }
