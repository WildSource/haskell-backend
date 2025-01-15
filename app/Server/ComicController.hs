{-# LANGUAGE TypeOperators #-}

module Server.ComicController (
  app
  )
 where

import API.Comic
import Entities.Comic
import Entities.Page
import Data.Int (Int64)
import Control.Monad.IO.Class
import Servant.API ((:<|>) (..), NoContent (NoContent))
import Servant.Server.StaticFiles (serveDirectoryWebApp)
import Database.PageRepository
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

    comicsAPI = comics :<|> postComic :<|> comicId

    comicId cId = 
      comicOperations cId :<|> pageOperations cId

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

    pageOperations cId = 
      getPages cId :<|> postPage cId :<|> putPage cId :<|> deletePage cId

    getPages :: Integer -> Handler [Page] 
    getPages = liftIO . getPage  

    postPage :: Integer -> PagesData -> Handler NoContent  
    postPage cId pData= liftIO $ createPage cId pData >> pure NoContent

    putPage :: Integer -> PagesData -> Handler NoContent
    putPage cId pData = liftIO $ replacePageById cId pData >> pure NoContent 

    deletePage :: Integer -> Handler NoContent
    deletePage cId = liftIO $ deletePageById cId >> pure NoContent

serverAPI :: Proxy ServerAPI 
serverAPI = Proxy 

app :: Application
app = serve serverAPI server

