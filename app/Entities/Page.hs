
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE BangPatterns #-}

module Entities.Page where

import Data.Aeson
import GHC.Generics
import Data.Data (Typeable)
import Database.MySQL.Simple.Result (
  convert, 
  Result (..)
  )
import Database.MySQL.Simple.QueryResults (
  QueryResults, 
  convertError,
  convertResults
  )

data PagesData = PagesData {
  pages :: [String]
} deriving (Show, Generic, Typeable)

instance ToJSON PagesData
instance FromJSON PagesData

data Page = Page {
  page_id :: Integer,
  page_path :: String,
  fk_comic_id :: Integer 
} deriving (Show, Generic, Typeable)

instance ToJSON Page 
instance FromJSON Page

instance QueryResults Page where
    convertResults [fa, fc, fd]
                   [va, vc, vd] =
        Page 
            { page_id  = a
            , page_path = c
            , fk_comic_id = d
            }
        where
            !a = convert fa va
            !c = convert fc vc
            !d = convert fd vd
    convertResults fs vs = convertError fs vs 4 

