module MeetupEvents exposing (..)

import Json.Decode exposing (int, string, float, list, bool, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Http
import Task exposing (Task)
-- import ISO8601
import Date exposing (Date)
import Result exposing (toMaybe)

import DecodeExtra exposing (nullOr)

eventsUrl: String
eventsUrl = "https://api.elmlog.com/events"

type alias MeetupEvent =
    { meetupGroupName : String
    , meetupTitle : String
    , location : String
    , date : Maybe Date
    , meetupPageLink : String
    , logoUrl : Maybe String
    }

type alias RawEvent =
  { title : String
  , country : Maybe String
  , city : Maybe String
  , host : String
  , url : String
  , local_starts_at : String
  }

rawEventDecoder : Decoder RawEvent
rawEventDecoder =
  decode RawEvent
    |> required "title" string
    |> required "city" (nullOr string)
    |> required "country" (nullOr string)
    |> required "host" string
    |> required "url" string
    |> required "local_starts_at" string

rawEventsDecoder : Decoder (List RawEvent)
rawEventsDecoder =
    list rawEventDecoder

eventsDecoder : Decoder (List MeetupEvent)
eventsDecoder =
  Json.Decode.map
    (\rawEvents ->
      List.map toMeetupEvent rawEvents
    )
    rawEventsDecoder

toMeetupEvent : RawEvent -> MeetupEvent
toMeetupEvent e =
  let
    maybeDate = Date.fromString e.local_starts_at |> toMaybe
    city = case e.city of
      Just city' -> city'
      Nothing -> ""
    country = case e.country of
      Just location' -> location'
      Nothing -> ""
    location' = country ++ ", " ++ city
    location = if location' == ", " then "" else location'
  in
    { meetupGroupName = e.host
    , meetupTitle = e.title
    , location = location
    , date = maybeDate
    , meetupPageLink = e.url
    , logoUrl = Nothing
    }


getEvents : Task Http.Error (List MeetupEvent)
getEvents =
    Http.get eventsDecoder eventsUrl
