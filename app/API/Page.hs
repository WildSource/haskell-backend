{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Page where 

import Servant 
import Entities.Page (PagesData)

type PageAPI = 
  "comics" :> Capture "id" Integer :> "pages" :> ReqBody '[JSON] PagesData :> Post '[JSON] NoContent

