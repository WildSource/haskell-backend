{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Comic where

import Servant
import Entities.Comic
import Data.Int (Int64)
import Entities.Page (Page, PagesData)

type ImgAPI = "imgs" :> Raw

type ComicOperations = 
  (    Get '[JSON] Comic 
  :<|> ReqBody '[JSON] ComicData :> Put '[JSON] Int64 
  :<|> Delete '[JSON] Int64
  )

type PageAPI = "pages" :> 
  (    Get '[JSON] [Page]
  :<|> ReqBody '[JSON] PagesData :> Post '[JSON] NoContent
  :<|> ReqBody '[JSON] PagesData :> Put '[JSON] NoContent 
  :<|> Delete '[JSON] NoContent 
  )

type ComicID = Capture "id" Integer :> (ComicOperations :<|> PageAPI)

type ComicAPI = Get '[JSON] [Comic] 
  :<|> ReqBody '[JSON] ComicData :> Post '[JSON] Int64 
  :<|> ComicID

type ServerAPI = ImgAPI
  :<|> "comics" :> ComicAPI 
