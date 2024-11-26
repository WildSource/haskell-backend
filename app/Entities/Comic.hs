module Entities.Comic where

import Data.Aeson

data Comic = Comic {
  title :: String,
  cover :: String,
  pages :: [String]
} deriving (Show, Generic)

instance ToJSON Comic
