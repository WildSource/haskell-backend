{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Page where 

import Servant 
import Entities.Page (PagesData)
import Data.Int (Int64)

type PageAPI = 
  "comics" :> ReqBody '[JSON] PagesData :> Post '[JSON] Int64

