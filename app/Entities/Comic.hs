{-# LANGUAGE DeriveGeneric #-}

module Entities.Comic where

import Data.Aeson
import GHC.Generics

data Comic = Comic {
  id :: Integer,
  title :: String,
  cover :: String,
  pages :: [String]
} deriving (Show, Generic)

instance ToJSON Comic
instance FromJSON Comic
