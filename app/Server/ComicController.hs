module Server.ComicController (
  app
  )
 where

import API.Comic
import Entities.Page 
import Entities.Comic
import Data.Int (Int64)
import Control.Monad.IO.Class
import Servant.API ((:<|>) (..), NoContent (NoContent))
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
import Database.PageRepository (getPage, createPage, deletePageById, replacePageById)

server :: Server ComicAPI 
server = comics
  :<|> getComic 
  :<|> postComic 
  :<|> putComic 
  :<|> deleteComic
  :<|> staticFiles
  :<|> getPages 
  :<|> postPage
  :<|> deletePage
  :<|> putPage
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

    getPages :: Integer -> Handler [Page]
    getPages = liftIO . getPage 

    postPage :: Integer -> PagesData -> Handler NoContent
    postPage comic_id pagesData = liftIO $ createPage comic_id pagesData >> pure NoContent

    deletePage :: Integer -> Handler NoContent
    deletePage pageId = liftIO $ deletePageById pageId >> pure NoContent

    putPage :: Integer -> PagesData -> Handler NoContent
    putPage comic_id pagesData = liftIO $ replacePageById comic_id pagesData >> pure NoContent
    
    
comicAPI :: Proxy ComicAPI
comicAPI = Proxy 

app :: Application
app = serve comicAPI server

