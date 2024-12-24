module Server.Configuration (
  app
  )
 where

import API
import Entities.Comic
import Control.Monad.IO.Class
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
import Database.Repository (getAllComics, getComicFromId, createComic)

server :: Server ComicAPI 
server = comics
  :<|> getComic 
  :<|> postComic 
  :<|> putComic 
  :<|> deleteComic
  :<|> staticFiles
  where
    comics :: Handler [Comic] 
    comics = liftIO getAllComics 

    getComic :: Integer -> Handler Comic
    getComic = (liftIO . getComicFromId)
 
    postComic :: ComicData -> Handler Comic 
    postComic = (liftIO . createComic)

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

