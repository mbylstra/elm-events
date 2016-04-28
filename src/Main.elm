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

-- APP KICK OFF!
main =
  StartApp.start { model = model, view = mainView, update = update }


-- MODEL
model = 0



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
    -- , Meetup
    --      { meetupGroupName = "Sydney Elixir Meetup"
    --      , meetupTitle = "Intro to Elm by Igor Kaplov"
    --      , meetupPageLink = "http://www.meetup.com/sydney-ex/events/227813634/"
    --      , date = "13 January 2016"
    --      , location = "Sydney, Australia"
    --      , logoUrl = Nothing
    --      }
    -- , Meetup
    --      { meetupGroupName = "Utah Elm Users"
    --      , meetupTitle = "January Meetup"
    --      , meetupPageLink = "http://www.meetup.com/Utah-Elm-Users/events/227368585/"
    --      , date = "14 January 2016"
    --      , location = "Seattle, USA"
    --      , logoUrl = Nothing
    --      }
    --   Meetup
    --      { meetupGroupName = "Elm Seattle"
    --      , meetupTitle = "Elm Seattle Hack Night"
    --      , meetupPageLink = "http://www.google.com/url?q=http%3A%2F%2Fwww.eventbrite.com%2Fe%2Felm-seattle-hack-night-tickets-20526978746%3Faff%3Dutm_source%253Deb_email%2526utm_medium%253Demail%2526utm_campaign%253Dnew_event_email%26utm_term%3Deventurl_text&sa=D&sntz=1&usg=AFQjCNHYiILREiXD-cBD0-PnIY4bwyGIZQ"
    --      , date = "20 January 2016"
    --      , location = "Seattle, USA"
    --      , logoUrl = Just "https://pbs.twimg.com/profile_images/644980018049748992/WUpRrRTI_400x400.png"
    --      }
    -- , Meetup
    --      { meetupGroupName = "Elm User Group Dublin"
    --      , meetupTitle = "Elm Meetup and Hackathon"
    --      , meetupPageLink = "http://www.meetup.com/Elm-User-Group-Dublin/events/227979749/"
    --      , date = "20 January 2016"
    --      , location = "Dublin, Ireland"
    --      , logoUrl = Just "http://photos4.meetupstatic.com/photos/event/7/a/1/3/global_444751251.jpeg"
    --      }
    -- , Meetup
    --      { meetupGroupName = "Elm user group SF"
    --      , meetupTitle = "Elm Hackathon"
    --      , meetupPageLink = "http://www.meetup.com/Elm-user-group-SF/events/227613696/"
    --      , date = "20 January 2016"
    --      , location = "San Francisco, USA"
    --      , logoUrl = Nothing
    --      }
    -- , Meetup
    --      { meetupGroupName = "Elm Copenhagen"
    --      , meetupTitle = "January Meetup"
    --      , meetupPageLink = "http://www.meetup.com/Elm-Copenhagen/events/227807583/"
    --      , date = "27 January 2016"
    --      , location = "Copenhagen, Denmark"
    --      , logoUrl = Nothing
    --      }
    -- , Meetup
    --      { meetupGroupName = "STL Elm"
    --      , meetupTitle = "Jessitron + Elm = <3"
    --      , meetupPageLink = "http://www.meetup.com/STLElm/events/227852077/"
    --      , date = "1 February 2016"
    --      , location = "Saint Louis, MO, USA"
    --      , logoUrl = Nothing
    --      }
    -- , Meetup
    --      { meetupGroupName = "Chicago Elm"
    --      , meetupTitle = "First Meetup!"
    --      , meetupPageLink = "http://www.meetup.com/chicago-elm/events/226994513/"
    --      , date = "2 February 2016"
    --      , location = "Chicago, USA"
    --      , logoUrl = Just "http://photos4.meetupstatic.com/photos/event/6/0/2/a/global_444504618.jpeg"
    --      }
      -- ConferenceTalk
      --    { conferenceName = "Forward 4 Web Technology Summit"
      --    , slug = "forward4-evan-cz"
      --    , conferenceLink = "http://forwardjs.com/summit"
      --    , talkTitle = Nothing
      --    , speaker = "Evan Czaplicki"
      --    , date = "10 February 2016"
      --    , location = "San Franciso, USA"
      --    , conferenceLogoFilename = "forward4.png"
      --    , speakerPhotoFilename = "evan-czaplicki.jpg"
      --   --  ,
      --    }
    -- , Meetup
    --   { meetupGroupName = "Elm London Meetup"
    --   , meetupTitle = "Elm London Meetup - First Set of Talks"
    --   , meetupPageLink = "http://www.meetup.com/Elm-London-Meetup/events/228549749/"
    --   , date = " 10 February 2016"
    --   , location = "London, UK"
    --   , logoUrl = Nothing
    --   }
    -- , Meetup
    --   { meetupGroupName = "Stockholm Elm"
    --   , meetupTitle = "Initial Meetup - Sprouting Season!"
    --   , meetupPageLink = "http://www.meetup.com/Stockholm-Elm/events/228463568/"
    --   , date = "17 February 2016"
    --   , location = "Stockholm, Sweden"
    --   , logoUrl = Nothing
    --   }
    -- , ConferenceTalk
    --      { conferenceName = "Bob Konferenz"
    --      , slug = "bob-2016"
    --      , conferenceLink = "http://bobkonf.de/2016/grosse-boelting.html"
    --      , talkTitle = Just "Elm im produktiven Einsatz"
    --      , speaker = "Gregor Große-Bölting"
    --      , date = "19 February 2016"
    --      , location = "Berlin, Germany"
    --      , conferenceLogoFilename = "bob-conf.png"
    --      , speakerPhotoFilename = "gregor.jpg"
    --     --  ,
    --      }
    -- , ConferenceTalk
    --   { conferenceName = "React.js Conf"
    --   , slug = "reactjs-jamison-dance"
    --   , conferenceLink = "http://conf.reactjs.com/schedule.html#rethinking-all-practices-building-applications-in-elm"
    --   , talkTitle = Just "Rethinking All Practices: Building Applications in Elm"
    --   , speaker = "Jamison Dance"
    --   , date = "23 February 2016"
    --   , location = "San Franciso, USA"
    --   , conferenceLogoFilename = "reactjs-conf.png"
    --   , speakerPhotoFilename = "jamison-dance.jpg"
    --   }
    -- , Meetup
    --   { meetupGroupName = "Tokyo Elm Programming Meetup"
    --   , meetupTitle = "ELM Meetup（日本初？）"
    --   , meetupPageLink = "http://www.meetup.com/Tokyo-Elm-Programming-Meetup/events/228097244/"
    --   , date = "24 February 2016"
    --   , location = "Ebisu, Tokyo, Japan"
    --   , logoUrl = Nothing
    --   }
      -- Meetup
      -- { meetupGroupName = "Elm NYC"
      -- , meetupTitle = "Elm NYC's First Meetup!"
      -- , meetupPageLink = "http://www.meetup.com/Elm-NYC/events/228564943/"
      -- , date = "1 March 2016"
      -- , location = "New York, USA"
      -- , logoUrl = Nothing
      -- }
      -- ConferenceTalk
      -- { conferenceName = "Erlang Factory"
      -- , slug = "erlang-factory-evan-cz"
      -- , conferenceLink = "http://www.erlang-factory.com/"
      -- , talkTitle = Just "Keynote"
      -- , speaker = "Evan Czaplicki"
      -- , date = "10-11 March 2016"
      -- , location = "San Franciso Bay Area, USA"
      -- , conferenceLogoFilename = "erlang-factory.png"
      -- , speakerPhotoFilename = "evan-czaplicki.jpg"
      -- }
    --   Meetup
    --   { meetupGroupName = "Chicago Elm"
    --   , meetupTitle = "Presentations by Yonatan Kogan, Jacob Matthews, and Brian Hicks"
    --   , meetupPageLink = "http://www.meetup.com/chicago-elm/events/229234216/"
    --   , date = "16 March 2016"
    --   , location = "Chicago, IL, USA"
    --   , logoUrl = Just "http://photos3.meetupstatic.com/photos/event/6/0/2/a/highres_444504618.jpeg"
    --   }
    -- , Meetup
    --   { meetupGroupName = "Elm Paris Meetup"
    --   , meetupTitle = "Elm Paris #1"
    --   , meetupPageLink = "http://www.meetup.com/fr-FR/Meetup-Elm-Paris/events/228722002/"
    --   , date = "23 March 2016"
    --   , location = "Paris, France"
    --   , logoUrl = Nothing
    --   }
    -- ConferenceTalk
    -- { conferenceName = "Flourish! 2016"
    -- , slug = "flourish-2016"
    -- , conferenceLink = "http://flourishconf.com/2016/speakers.php?id=12"
    -- , talkTitle = Just "Friendly Functional Programming For The Web"
    -- , speaker = "Luke Westby"
    -- , date = "2 April 2016"
    -- , location = "Chicago, IL, USA"
    -- , conferenceLogoFilename = "flourish-2016.png"
    -- , speakerPhotoFilename = "luke-westby.jpg"
    -- }
    ConferenceTalk
      { conferenceName = "ProgSCon"
      , slug = "progscon-2016"
      , conferenceLink = "http://progscon.co.uk/"
      , talkTitle = Just "Elm: Finding the Functional in Reactive Programming"
      , speaker = "Claudia Doppioslash"
      , date = "22 April 2016"
      , location = "London"
      , conferenceLogoFilename = "progscon.png"
      , speakerPhotoFilename = "claudia-doppioslash.jpg"
      }
    , Meetup
      { meetupGroupName = "Elmoin"
      , meetupTitle = "First Elmoin Meetup"
      , meetupPageLink = "http://www.meetup.com/de-DE/Elmoin/events/230416727/"
      , date = "03 May 2016"
      , location = "Hamburg, Germany"
      , logoUrl = Just "https://cdn.rawgit.com/sectore/elmoin-logo-media/master/elmoin-logo.svg"
      }
    ]

suggestedConferences : List SuggestedConferenceR
suggestedConferences =
    [
        { name = "ReactEurope"
        , date = "June 2-3, 2016"
        , location = "Paris, France"
        , submissionDeadline = "PAST"
        , link = "https://www.react-europe.org/"
        }
    ,
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
        , submissionDeadline = "TBA"
        , link = "http://thestrangeloop.com/"
        }
    ]

newMeetupGroups : List MeetupGroupR
newMeetupGroups =
    [
        { name = "Elmoin Hamburg / Schleswig Holstein"
        , link = "http://www.meetup.com/Elmoin/"
        }
    ,    { name = "Elm Warsaw"
        , link = "http://www.meetup.com/Elm-Warsaw/"
        }
    ,   { name = "Vienna Elm Meetup"
        , link = "http://www.meetup.com/Vienna-Elm-Meetup/"
        }
    ,   { name = "Boston Elmlang Meetup"
        , link = "http://www.meetup.com/Boston-Elm-Lang-Meetup/"
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

meetupView : MeetupEventR -> Html
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


renderNewMeetupGroup : MeetupGroupR -> Html
renderNewMeetupGroup group =
  li [] [ a [href group.link] [ text group.name ]]

renderNewMeetupGroups : List MeetupGroupR -> Html
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

-- mainView : Html
mainView address model =
    div []
        [ header []
            [ h1 [] [ text "Elm Events" ]
            ]
        , renderEvents upcomingEvents
        , renderNewMeetupGroups newMeetupGroups
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
