{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API where

import Servant
import Entities.Comic

type ImgAPI = "imgs" :> Raw

type ComicAPI = "comics" :> Get '[JSON] [Comic] 
  :<|> "comics" :> Capture "id" Integer :> Get '[JSON] Comic
  :<|> "comics" :> ReqBody '[JSON] Comic :> Post '[JSON] Comic
  :<|> "comics" :> Capture "id" Integer :> ReqBody '[JSON] Comic :> Put '[JSON] Comic
  :<|> "comics" :> Capture "id" Integer :> DeleteNoContent 
  :<|> "comics" :> ImgAPI
