module DecodeExtra exposing (..)

import Json.Decode exposing (..)

nullOr : Decoder a -> Decoder (Maybe a)
nullOr decoder =
    oneOf
    [ null Nothing
    , map Just decoder
    ]
