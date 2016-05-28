import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Maybe exposing (withDefault)
import Date exposing (Date)
import Task
import Date.Extra.Compare exposing (Compare2 (SameOrAfter), is)
import Result exposing (Result)


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

-- type alias MeetupEventR =
--     { meetupGroupName : String
--     , meetupTitle : String
--     , location : String
--     , date : String
--     , meetupPageLink : String
--     , logoUrl : Maybe String
--     }


type alias SuggestedConferenceR =
    { name : String
    , date : String
    , submissionDeadline: String
    , link : String
    , location : String
    }

type alias MeetupGroupR =
    { name : String
    , link : String
    }

type Event
    = ConferenceTalk ConferenceTalkR
    -- | Meetup MeetupEventR


getCurrentDateCmd : Cmd Msg
getCurrentDateCmd = Task.perform (\_ -> NoOp) TodayDateFetched Date.now


main =
  Html.App.program
    { init = init
    , view = mainView
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }


-- MODEL


type alias Model = { dateToday : Maybe Date }

model : Model
model = { dateToday = Nothing }

init = model ! [getCurrentDateCmd]



-- ype Msg = TheDate Date | NoOp
--
-- myCmd : Cmd Msg
-- myCmd = Task.perform (\_ -> NoOp) TheDate Date.now


type Msg
  = NoOp
  | TodayDateFetched Date


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case (Debug.log "msg" msg) of
    TodayDateFetched date ->
      { model | dateToday = Just date } ! []
    NoOp ->
      model ! []




upcomingEvents : List Event
upcomingEvents =
    [
    -- Note: the following will show up in a future Past Events section.
    -- This will actually use computer dates and some point too!
    --[ ConferenceTalk
    --      { conferenceName = "Melb JS"
    --      , slug = "melbjs-seb-porto"
    --      , conferenceLink = "http://melbjs.com"
    --      , talkTitle = Just "Elm"
    --      , speaker = "Sebastian Porto"
    --      , date = "13 January 2016"
    --      , location = "Melbourne, Australia"
    --      , conferenceLogoFilename = "melbjs.png"
    --      , speakerPhotoFilename = "sebastian-porto.jpg"
    --      }
      ConferenceTalk
        { conferenceName = "goto; Chicago 2016"
        , slug = "goto-chicago-2016"
        , conferenceLink = "http://gotocon.com/chicago-2016"
        , talkTitle = Just "Adventures in Elm"
        , speaker = "Jessica Kerr"
        , date = "24 May 2016"
        , location = "Chicago, USA"
        , conferenceLogoFilename = "goto-conference.jpg"
        , speakerPhotoFilename = "jessica-kerr.jpg"
        }
   , ConferenceTalk
        { conferenceName = "At The Frontend"
        , slug = "at-the-frontend-2016"
        , conferenceLink = "http://atthefrontend.dk/"
        , talkTitle = Just "Stepping out of the chaos with Elm"
        , speaker = "José Lorenzo Rodríguez"
        , date = "25 May 2016"
        , location = "Copenhagen, Denmark"
        , conferenceLogoFilename = "at-the-frontend-2016.png"
        , speakerPhotoFilename = "jose.jpg"
    }
    , ConferenceTalk
        { conferenceName = "Chicago Coder Conference"
        , slug = "chicago-coder-conf-2016"
        , conferenceLink = "http://chicagocoderconference.com/cccsession/session-5-testability-maintainability-reliability-building-apps-with-elm/"
        , talkTitle = Just "Testability, Maintainability, Reliability: Building apps with Elm"
        , speaker = "Luke Westby"
        , date = "7 June 2016"
        , location = "Chicago, USA"
        , conferenceLogoFilename = "chicago-coder-conf.jpg"
        , speakerPhotoFilename = "luke.jpg"
        }
    , ConferenceTalk
        { conferenceName = "Joy of Coding"
        , slug = "joy-of-coding-2016"
        , conferenceLink = "http://joyofcoding.org/speakers/andrea-magnorsky-claudia-doppiolash.html"
        , talkTitle = Just "Learn to make games with Elm and cats"
        , speaker = "Andrea Magnorsky & Claudia Doppiolash"
        , date = "17 June 2016"
        , location = "Rotterdam, Netherlands"
        , conferenceLogoFilename = "joy-of-coding-2016.png"
        , speakerPhotoFilename = "claudia-and-andrea.png"
        }
    , ConferenceTalk
        { conferenceName = "Curry On Rome!"
        , slug = "curry-on-rome-2016"
        , conferenceLink = "http://www.curry-on.org/2016/sessions/creating-a-fun-game-with-elm.html"
        , talkTitle = Just "Creating a Fun Game with Elm"
        , speaker = "Andrey Kuzmin & Kolja Wilcke"
        , date = "18 July 2016"
        , location = "Rome, Italy"
        , conferenceLogoFilename = "curry-on-rome-2016.png"
        , speakerPhotoFilename = "curry-on-rome-2016-people.png"
        }
    , ConferenceTalk
        { conferenceName = "Abstractions"
        , slug = "abstractions-2016"
        , conferenceLink = "http://abstractions.io/"
        , talkTitle = Just "Friendly Functional Programming For The Web"
        , speaker = "Luke Westby"
        , date = "18 August 2016"
        , location = "Pittsburgh, USA"
        , conferenceLogoFilename = "abstractions-2016.jpg"
        , speakerPhotoFilename = "luke.jpg"
        }
    , ConferenceTalk
        { conferenceName = "goto; Copenhagen"
        , slug = "goto-copenhagen-2016"
        , conferenceLink = "http://gotocon.com/cph-2016/"
        , talkTitle = Just "Friendly Functional Programming For The Web"
        , speaker = "Luke Westby"
        , date = "3 October 2016"
        , location = "Copenhagen, Denmark"
        , conferenceLogoFilename = "goto-conference.jpg"
        , speakerPhotoFilename = "luke.jpg"
        }
    , ConferenceTalk
        { conferenceName = "XT16"
        , slug = "xt16"
        , conferenceLink = "https://juxt.pro/XT16.html"
        , talkTitle = Just "Adventures in User Interfaces"
        , speaker = "Kris Jenkins"
        , date = "6 October 2016"
        , location = "Millbrook, UK"
        , conferenceLogoFilename = "xt16.png"
        , speakerPhotoFilename = "kris-jenkins.jpg"
        }
    -- , Meetup
    --     { meetupGroupName = "Elmoin"
    --     , meetupTitle = "First Elmoin Meetup"
    --     , meetupPageLink = "http://www.meetup.com/de-DE/Elmoin/events/230416727/"
    --     , date = "03 May 2016"
    --     , location = "Hamburg, Germany"
    --     , logoUrl = Just "https://cdn.rawgit.com/sectore/elmoin-logo-media/master/elmoin-logo.svg"
    --     }
    ]

suggestedConferences : List SuggestedConferenceR
suggestedConferences =
    [
    --     { name = "ReactEurope"
    --     , date = "June 2-3, 2016"
    --     , location = "Paris, France"
    --     , submissionDeadline = "PAST"
    --     , link = "https://www.react-europe.org/"
    --     }
    -- ,
        { name = "LambdaConf"
        , date = "May 26-19, 2016"
        , location = "Boulder, CO, USA"
        , submissionDeadline = "PAST"
        , link = "http://lambdaconf.us/"
        }
    ,
        { name = "Strange Loop"
        , date = "Sept 15-17th, 2016"
        , location = "St. Louis, USA"
        , submissionDeadline = "PAST"
        , link = "http://thestrangeloop.com/"
        }
    ]

newMeetupGroups : List MeetupGroupR
newMeetupGroups =
    [
    --     { name = "Elmoin Hamburg / Schleswig Holstein"
    --     , link = "http://www.meetup.com/Elmoin/"
    --     }
    -- ,    { name = "Elm Warsaw"
    --     , link = "http://www.meetup.com/Elm-Warsaw/"
    --     }
    -- ,   { name = "Vienna Elm Meetup"
    --     , link = "http://www.meetup.com/Vienna-Elm-Meetup/"
    --     }
    -- ,   { name = "Boston Elmlang Meetup"
    --     , link = "http://www.meetup.com/Boston-Elm-Lang-Meetup/"
    --     }
    -- ,   { name = "Elm Portland (Maine)"
    --     , link = "http://www.meetup.com/Elm-Portland-Maine/"
    --     }
    ]

confImage : String -> String -> Html Msg
confImage filename idValue =
    div
        [ id idValue
        , class "conference-image"
        , style
            [ ("background-image", "url(img/" ++ filename ++ ")") ]
        ]
        []

speakerImage : String -> Html Msg
speakerImage filename =
    img
        [ class "speaker-image"
        , src ("img/" ++ filename)
        , style
            [ ("display", "inline")
            , ("width", "200px")
            , ("height", "200px")
            ]
        ]
        []

talkView : ConferenceTalkR -> Html Msg
talkView record =
    a [ class ("event-card talk grow " ++ record.slug), href record.conferenceLink]
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

-- meetupView : MeetupEventR -> Html Msg
-- meetupView record =
--
--   let
--     logoEl =
--       case record.logoUrl of
--         Just url ->
--           img [ src url ] []
--         Nothing -> span [] []
--
--   in
--     a [ class "event-card meetup grow", href record.meetupPageLink]
--           [ div [ class "meetup-header"]
--             [ h3 []
--                 [text record.meetupTitle]
--             , logoEl
--             ]
--           , div [ class "meetup-footer"]
--             [ h4 []
--                 [text record.meetupGroupName]
--             , div [] [text record.date]
--             , div [ class "location"] [text record.location]
--             ]
--           ]

renderEvent : Event -> Html Msg
renderEvent event =
    case event of
        ConferenceTalk record ->
            talkView record
        -- Meetup record ->
        --     meetupView record

renderEvents : List Event -> Html Msg
renderEvents events =
    let
        eventViews = List.map renderEvent events
    in
        div [ class "upcoming-talks"]
            [ h2 [] [ text "Upcoming Talks and Workshops" ]
            , div [ class "talks"]
                eventViews
            ]

renderSuggestedConference : SuggestedConferenceR -> Html Msg
renderSuggestedConference conf =
    tr []
        [ td [] [text conf.name]
        , td [] [text conf.location]
        , td []  [text conf.date]
        , td [] [text conf.submissionDeadline]
        ]

renderSuggestedConferences : List SuggestedConferenceR -> Html Msg
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


renderNewMeetupGroup : MeetupGroupR -> Html Msg
renderNewMeetupGroup group =
  li [] [ a [href group.link] [ text group.name ]]

renderNewMeetupGroups : List MeetupGroupR -> Html Msg
renderNewMeetupGroups groups =
    let
        lis = List.map renderNewMeetupGroup groups
    in
        div [ class "new-meetup-groups"]
            [ h2 [] [text "New Meetup Groups"]
            , p [] [ text "These groups are in a formative stage and don't have any events planned yet." ]
            , p [] [ text "If you live in these areas, or are passing by, make sure you join up to get notified about the first meetup!"]
            , ul [] lis
            ]


getFutureEvents : List Event -> Model -> List Event
getFutureEvents events model =
  let
    isFutureEvent : Event -> Bool
    isFutureEvent event =
      case event of
        ConferenceTalk data ->
          case Date.fromString data.date of
            Ok eventDate ->
              case model.dateToday of
                Just todayDate ->
                  is SameOrAfter eventDate todayDate
                Nothing ->
                  False
            Err msg ->
              Debug.crash ("Invalid date: " ++ msg)

  in
    List.filter isFutureEvent events

mainView : Model -> Html Msg
mainView model =
  case model.dateToday of
    Just date ->
      div []
          [ header []
              [ h1 [] [ text "Elm Events" ]
              ]
          , renderEvents (getFutureEvents upcomingEvents model)
          -- , renderNewMeetupGroups newMeetupGroups
          , renderSuggestedConferences suggestedConferences
          ]
    Nothing ->
      div [] []



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
