{-# LANGUAGE TypeOperators #-}

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

server :: Server ServerAPI 
server = staticFiles :<|> comicsAPI
  where
    staticFiles :: Server ImgAPI 
    staticFiles = serveDirectoryWebApp "img"

    comicsAPI = comics :<|> (\comicData -> postComic comicData) :<|> comicOperations

    comics :: Handler [Comic]
    comics = liftIO getAllComics

    comicOperations cId = 
      getComic cId :<|> putComic cId :<|> deleteComic cId

    getComic :: Integer -> Handler Comic
    getComic = liftIO . getComicFromId

    postComic :: ComicData -> Handler Int64 
    postComic = liftIO . createComic

    putComic :: Integer -> ComicData -> Handler Int64 
    putComic cId modifications = liftIO $ replaceComicById cId modifications

    deleteComic :: Integer -> Handler Int64 
    deleteComic = liftIO . deleteComicById  

serverAPI :: Proxy ServerAPI 
serverAPI = Proxy 

app :: Application
app = serve serverAPI server

