{-# LANGUAGE OverloadedStrings #-}
module Database.Repository where 

import Entities.Comic (Comic (..))
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
  query_
  )

connection :: ConnectInfo
connection = 
  defaultConnectInfo {
    connectPort = 3306,
    connectUser = "test",
    connectPassword = "test",
    connectDatabase = "test"
  }

getComicFromId :: Integer -> IO Comic
getComicFromId id' = do
  conn <- connect connection
  [comic] <- query conn "select * from comic where comic_id = ?" (Only id')
  close conn
  pure comic

getAllComics :: IO [Comic]
getAllComics = do
  conn <- connect connection
  comics <- query_ conn "select * from comic" 
  close conn
  pure comics 

