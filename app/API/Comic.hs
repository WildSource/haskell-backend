{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Comic where

import Servant
import Entities.Comic
import Data.Int (Int64)

type ImgAPI = "imgs" :> Raw

type ComicAPI = "comics" :> Get '[JSON] [Comic] 
  :<|> "comics" :> Capture "id" Integer :> Get '[JSON] Comic
  :<|> "comics" :> ReqBody '[JSON] ComicData :> Post '[JSON] Int64 
  :<|> "comics" :> Capture "id" Integer :> ReqBody '[JSON] ComicData :> Put '[JSON] Int64 
  :<|> "comics" :> Capture "id" Integer :> Delete '[JSON] Int64 
  :<|> "comics" :> ImgAPI
