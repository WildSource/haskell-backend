{-# LANGUAGE DeriveGeneric #-}

module Entities.DTR.ComicDTR where

import Data.Aeson
import GHC.Generics
import Data.Data (Typeable)

data ComicDTR = ComicDTR {
  d_title :: String,
  d_cover :: String,
  d_description :: String
} deriving (Show, Generic, Typeable) 

instance ToJSON ComicDTR
instance FromJSON ComicDTR
