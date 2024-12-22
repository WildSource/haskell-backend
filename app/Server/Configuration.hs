module Server.Configuration (
  app
  )
 where

import API
import Entities.Comic
import Servant.Server.StaticFiles (serveDirectoryWebApp)
import Servant (
  Application,
  Server,
  serve,
  Handler,
  Proxy (Proxy)
  ) 
import Servant.API (
  (:<|>) (..), 
  NoContent (NoContent)
  )
import Database.Repository (getAllComics)

server :: Server ComicAPI 
server = comics
  :<|> getComic 
  :<|> postComic 
  :<|> putComic 
  :<|> deleteComic
  :<|> staticFiles
  where
    comics :: Handler [Comic] 
    comics = do
      comics' <- getAllComics 
      pure (comics') 

    getComic :: Integer -> Handler Comic
    getComic comicId = undefined
 
    postComic :: Comic -> Handler Comic
    postComic = undefined 

    putComic :: Integer -> Comic -> Handler Comic
    putComic cId _ = undefined 

    deleteComic :: Integer -> Handler NoContent
    deleteComic _ = return NoContent

    staticFiles :: Server ImgAPI 
    staticFiles = serveDirectoryWebApp "img"
    
comicAPI :: Proxy ComicAPI
comicAPI = Proxy 

app :: Application
app = serve comicAPI server

