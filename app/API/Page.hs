{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.Page where 

import Servant 
import Entities.Page (Page, PagesData)

type PageAPI = "comics" :> Capture "id" Integer :> "pages" :> Get '[JSON] [Page] 
  :<|> "comics" :> Capture "id" Integer :> "pages" :> ReqBody '[JSON] PagesData :> Post '[JSON] NoContent
  :<|> "comics" :> Capture "id" Integer :> DeleteNoContent
  :<|> "comics" :> Capture "id" Integer :> ReqBody '[JSON] PagesData :> Put '[JSON] NoContent
