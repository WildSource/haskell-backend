{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Comic where

import Servant
import Entities.Comic
import Data.Int (Int64)

type ImgAPI = "imgs" :> Raw

type ComicOperations = Capture "id" Integer :>
  (    Get '[JSON] Comic 
  :<|> ReqBody '[JSON] ComicData :> Put '[JSON] Int64 
  :<|> Delete '[JSON] Int64
  )

type ComicAPI = Get '[JSON] [Comic] 
  :<|> ReqBody '[JSON] ComicData :> Post '[JSON] Int64 
  :<|> ComicOperations

type ServerAPI = ImgAPI
  :<|> "comics" :> ComicAPI 
