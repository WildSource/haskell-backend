{-# LANGUAGE DeriveGeneric #-}

module Entities.DTR.PageDTR where

import Data.Aeson
import GHC.Generics
import Data.Data (Typeable)

data PageDTR = PageDTR {
  pages :: [String]
} deriving (Show, Generic, Typeable)

instance ToJSON PageDTR
instance FromJSON PageDTR
