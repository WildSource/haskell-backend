{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Server where

import Servant
import Entities.Comic
import Data.Int (Int64)
import Entities.Page 
import Entities.DTR.PageDTR 
import Entities.DTR.ComicDTR

type PageAPI = "pages" :> 
  (    Get '[JSON] [Page]
  :<|> ReqBody '[JSON] PageDTR :> Post '[JSON] NoContent
  :<|> ReqBody '[JSON] PageDTR :> Put '[JSON] NoContent 
  :<|> Delete '[JSON] NoContent 
  )

type ComicOperations = 
  (    Get '[JSON] Comic 
  :<|> ReqBody '[JSON] ComicDTR :> Put '[JSON] Int64 
  :<|> Delete '[JSON] Int64
  )

type ComicID = Capture "id" Integer :> (ComicOperations :<|> PageAPI)

type ComicAPI = Get '[JSON] [Comic] 
  :<|> ReqBody '[JSON] ComicDTR :> Post '[JSON] Int64 
  :<|> ComicID

type ImgAPI = "imgs" :> Raw

type ServerAPI = ImgAPI
  :<|> "comics" :> ComicAPI 
