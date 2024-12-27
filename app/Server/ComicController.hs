module Server.ComicController (
  app
  )
 where

import API.Comic
import Entities.Comic
import Data.Int (Int64)
import Control.Monad.IO.Class
import Servant.API ((:<|>) (..))
import Servant.Server.StaticFiles (serveDirectoryWebApp)
import Database.ComicRepository (
  getAllComics,
  getComicFromId,
  createComic,
  replaceComicById, deleteComicById
  )
import Servant (
  Application,
  Server,
  serve,
  Handler,
  Proxy (Proxy)
  ) 

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
    getComic = liftIO . getComicFromId
 
    postComic :: ComicData -> Handler Int64 
    postComic = liftIO . createComic

    putComic :: Integer -> ComicData -> Handler Int64 
    putComic cId modifications = liftIO $ replaceComicById cId modifications

    deleteComic :: Integer -> Handler Int64 
    deleteComic = liftIO . deleteComicById  

    staticFiles :: Server ImgAPI 
    staticFiles = serveDirectoryWebApp "img"
    
comicAPI :: Proxy ComicAPI
comicAPI = Proxy 

app :: Application
app = serve comicAPI server

