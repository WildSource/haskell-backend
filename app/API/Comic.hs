{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Comic where

import Servant
import Entities.Comic
import Data.Int (Int64)
import Entities.Page (Page)

type ImgAPI = "imgs" :> Raw

type ComicID = Capture "id" Integer :> (ComicOperations :<|> PageAPI)

type ComicOperations = 
  (    Get '[JSON] Comic 
  :<|> ReqBody '[JSON] ComicData :> Put '[JSON] Int64 
  :<|> Delete '[JSON] Int64
  )

type ComicAPI = Get '[JSON] [Comic] 
  :<|> ReqBody '[JSON] ComicData :> Post '[JSON] Int64 
  :<|> ComicID

type PageAPI = Get '[JSON] Page

type ServerAPI = ImgAPI
  :<|> "comics" :> ComicAPI 
