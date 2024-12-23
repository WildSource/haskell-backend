{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE BangPatterns #-}

module Entities.Comic where

import Data.Aeson
import GHC.Generics
import Database.MySQL.Simple.Result (convert, Result (..), FromField)
import Database.MySQL.Simple.QueryResults (
  QueryResults, 
  convertError,
  convertResults
  )
import Data.Time (UTCTime, Day)
import Data.Data (Typeable)

data Comic = Comic {
  c_id :: Integer,
  title :: String,
  cover :: String,
  description :: String,
  creation_date :: Day,
  update_date :: UTCTime 
} deriving (Show, Generic, Typeable)

instance ToJSON Comic
instance FromJSON Comic

instance QueryResults Comic where
    convertResults [fa, fb, fc, fd, fe, ff]
                  [va, vb, vc, vd, ve, vf] =
        Comic
            { c_id  = a
            , title = b
            , cover = c
            , description = d
            , creation_date = e
            , update_date = f
            }
        where
            !a = convert fa va
            !b = convert fb vb
            !c = convert fc vc
            !d = convert fd vd
            !e = convert fe ve
            !f = convert ff vf
    convertResults fs vs = convertError fs vs 6 

