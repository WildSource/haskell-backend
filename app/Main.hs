module Main where

import API
import Entities.Comic
import Data.Data (Proxy(Proxy))
import Network.Wai.Handler.Warp (run)
import Servant.Server.StaticFiles (serveDirectoryWebApp)
import Servant.API (
  (:<|>) (..), 
  NoContent (NoContent)
  )
import Servant (
  Application, 
  Server, 
  serve, 
  Handler
  ) 

comicList :: [Comic]
comicList = [
    Comic 1 "comic1" "title1" ["page1", "page2"],
    Comic 2 "comic2" "title2" ["page1", "page2", "page3"],
    Comic 3 "comi3" "title3" ["page1"]
  ] 

server :: Server ComicAPI 
server = comics
  :<|> comic 
  :<|> createComic
  :<|> modifyComic 
  :<|> deleteComic
  :<|> staticFiles
  where
    comics :: Handler [Comic] 
    comics = return comicList

    comic :: Integer -> Handler Comic
    comic = undefined 
  
    createComic :: Comic -> Handler Comic
    createComic = return  

    modifyComic :: Integer -> Comic -> Handler Comic
    modifyComic id comic = undefined

    deleteComic :: Integer -> Handler NoContent
    deleteComic _ = return NoContent

    staticFiles = serveDirectoryWebApp "static-files"
    
comicAPI :: Proxy ComicAPI
comicAPI = Proxy

app :: Application
app = serve comicAPI server

main :: IO ()
main = do
  run 8081 app
   
