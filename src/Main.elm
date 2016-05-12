import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Maybe exposing (withDefault)


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

type alias MeetupEventR =
    { meetupGroupName : String
    , meetupTitle : String
    , location : String
    , date : String
    , meetupPageLink : String
    , logoUrl : Maybe String
    }


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
    | Meetup MeetupEventR

main =
  Html.App.beginnerProgram
    { model = model
    , view = mainView
    , update = update
    }


-- MODEL
model = ()

update msg model =
  model



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
        , location = "Chicago"
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
        , location = "Copenhagen"
        , conferenceLogoFilename = "at-the-frontend-2016.png"
        , speakerPhotoFilename = "jose.jpg"
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

confImage : String -> String -> Html ()
confImage filename idValue =
    div
        [ id idValue
        , class "conference-image"
        , style
            [ ("background-image", "url(img/" ++ filename ++ ")") ]
        ]
        []

speakerImage : String -> Html ()
speakerImage filename =
    img
        [ src ("img/" ++ filename)
        , style
            [ ("display", "inline")
            , ("width", "200px")
            , ("height", "200px")
            ]
        ]
        []

talkView : ConferenceTalkR -> Html ()
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

meetupView : MeetupEventR -> Html ()
meetupView record =

  let
    logoEl =
      case record.logoUrl of
        Just url ->
          img [ src url ] []
        Nothing -> span [] []

  in
    a [ class "event-card meetup grow", href record.meetupPageLink]
          [ div [ class "meetup-header"]
            [ h3 []
                [text record.meetupTitle]
            , logoEl
            ]
          , div [ class "meetup-footer"]
            [ h4 []
                [text record.meetupGroupName]
            , div [] [text record.date]
            , div [ class "location"] [text record.location]
            ]
          ]

renderEvent : Event -> Html ()
renderEvent event =
    case event of
        ConferenceTalk record ->
            talkView record
        Meetup record ->
            meetupView record

renderEvents : List Event -> Html ()
renderEvents events =
    let
        eventViews = List.map renderEvent events
    in
        div [ class "upcoming-talks"]
            [ h2 [] [ text "Upcoming Conference Talks and Meetups" ]
            , div [ class "talks"]
                eventViews
            ]

renderSuggestedConference : SuggestedConferenceR -> Html ()
renderSuggestedConference conf =
    tr []
        [ td [] [text conf.name]
        , td [] [text conf.location]
        , td []  [text conf.date]
        , td [] [text conf.submissionDeadline]
        ]

renderSuggestedConferences : List SuggestedConferenceR -> Html ()
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


renderNewMeetupGroup : MeetupGroupR -> Html ()
renderNewMeetupGroup group =
  li [] [ a [href group.link] [ text group.name ]]

renderNewMeetupGroups : List MeetupGroupR -> Html ()
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

mainView model =
    div []
        [ header []
            [ h1 [] [ text "Elm Events" ]
            ]
        , renderEvents upcomingEvents
        -- , renderNewMeetupGroups newMeetupGroups
        , renderSuggestedConferences suggestedConferences
        ]

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
