{-# LANGUAGE OverloadedStrings #-}
module Database.Repository where 

import Data.Int (Int64)
import Entities.Comic (Comic (..), ComicData (..))
import Database.MySQL.Simple (
  ConnectInfo,
  defaultConnectInfo,
  connectPort,
  connectUser,
  connectPassword,
  connectDatabase,
  connect,
  close,
  Only (..),
  query,
  query_,
  execute
  )

-- TODO: support env variables
connection :: ConnectInfo
connection = 
  defaultConnectInfo {
    connectPort = 3306,
    connectUser = "test",
    connectPassword = "test",
    connectDatabase = "test"
  }

-- GET
getComicFromId :: Integer -> IO Comic
getComicFromId id' = do
  conn <- connect connection
  [comic] <- query conn "SELECT * FROM comic  WHERE comic_id = ?" (Only id')
  close conn
  pure comic

-- GET ALL
getAllComics :: IO [Comic]
getAllComics = do
  conn <- connect connection
  comics <- query_ conn "SELECT * FROM comic" 
  close conn
  pure comics 

-- POST 
createComic :: ComicData -> IO Int64 
createComic (ComicData { d_title = t, d_cover = c, d_description = d}) = do
  conn <- connect connection
  nbrRows <- execute conn "INSERT INTO comic (comic_title, comic_cover, comic_desc) VALUES (?, ?, ?)" (t, c, d)
  close conn
  pure nbrRows
