module Main where

import API
import Data.Data (Proxy(Proxy))
import Servant (Application)

comics :: [Comic]
comics = [
    Comic "comic1" "title1" ["page1", "page2"],
    Comic "comic2" "title2" ["page1", "page2", "page3"],
    Comic "comi3" "title3" ["page1"]
  ] 

server :: Server ComicAPI 
server = return comics 

comicAPI :: Proxy ComicAPI
comicAPI = Proxy

app :: Application
app = serve comicAPI server

main :: IO ()
main = do
  run 8081 app
   
