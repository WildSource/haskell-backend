{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Comic where

import Servant
import Entities.Comic
import Entities.Page
import Data.Int (Int64)

type ImgAPI = "imgs" :> Raw

type ComicAPI = "comics" :> Get '[JSON] [Comic] 
  :<|> "comics" :> Capture "id" Integer :> 
  (    Get '[JSON] Comic 
  :<|> "pages" :> 
    (    Get '[JSON] [Page] 
    :<|> ReqBody '[JSON] PagesData :> Post '[JSON] NoContent
    )
  )
  :<|> "comics" :> ReqBody '[JSON] ComicData :> Post '[JSON] Int64 
  :<|> "comics" :> Capture "id" Integer :> ReqBody '[JSON] ComicData :> 
  (    Put '[JSON] Int64 
  :<|> Capture "id" Integer :> ReqBody '[JSON] PagesData :> Put '[JSON] NoContent
  ) 
  :<|> "comics" :> Capture "id" Integer :> 
  (    Delete '[JSON] Int64 
  :<|> "pages" :> Capture "id" Integer :> DeleteNoContent
  )
  :<|> "comics" :> ImgAPI
