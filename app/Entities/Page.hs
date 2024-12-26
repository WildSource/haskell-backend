{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE BangPatterns #-}

module Entities.Page where

data PagesData = PagesData {
  pages :: [String]
}

instance ToJSON Comic
instance FromJSON Comic

data Page = Page {
  page_id :: Integer,
  page_index :: Int,
  page_path :: String,
  fk_comic_id :: Integer 
} deriving (Show, Generic, Typeable)

instance ToJSON Comic
instance FromJSON Comic

instance QueryResults Page where
    convertResults [fa, fb, fc, fd]
                   [va, vb, vc, vd] =
        Page 
            { page_id  = a
            , page_index = b
            , page_path = c
            , fk_comic_id = d
            }
        where
            !a = convert fa va
            !b = convert fb vb
            !c = convert fc vc
            !d = convert fd vd
    convertResults fs vs = convertError fs vs 4 

