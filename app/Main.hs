{-# LANGUAGE OverloadedStrings #-}

module Main where

import API
import Entities.Comic
import Network.Wai.Handler.Warp (run)
import Database.MySQL.Simple
import Servant.Server.StaticFiles (serveDirectoryWebApp)
import Servant.API (
  (:<|>) (..), 
  NoContent (NoContent)
  )
import Servant (
  Application, 
  Server, 
  serve, 
  Handler,
  Proxy
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
    comic comicId = return $ comicList !! (integerToInt comicId)

    createComic :: Comic -> Handler Comic
    createComic = return  

    modifyComic :: Integer -> Comic -> Handler Comic
    modifyComic cId _ = comic cId 

    deleteComic :: Integer -> Handler NoContent
    deleteComic _ = return NoContent

    staticFiles :: Server ImgAPI 
    staticFiles = serveDirectoryWebApp "img"
    
comicAPI :: Proxy ComicAPI
comicAPI = undefined 

app :: Application
app = serve comicAPI server

connection :: ConnectInfo
connection = 
  defaultConnectInfo {
    connectPort = 3306,
    connectUser = "test",
    connectPassword = "test",
    connectDatabase = "test"
  }

hello :: IO Int
hello = do
  conn <- connect $ connection
  [Only i] <- query_ conn "select 2 + 2"
  return i

main :: IO ()
main = do
  str <- hello
  putStrLn $ show str
  run 8081 app
   
