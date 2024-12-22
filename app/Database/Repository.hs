{-# LANGUAGE OverloadedStrings #-}
module Database.Repository where 

import Database.MySQL.Simple (
  ConnectInfo,
  defaultConnectInfo,
  connectPort,
  connectUser,
  connectPassword,
  connectDatabase,
  connect,
  query_
  )
import Entities.Comic (Comic (..))

connection :: ConnectInfo
connection = 
  defaultConnectInfo {
    connectPort = 3306,
    connectUser = "test",
    connectPassword = "test",
    connectDatabase = "test"
  }

getComicFromId :: Integer -> Comic
getComicFromId = undefined

-- TODO: implement this function and test it 
getAllComics :: IO [Comic]
getAllComics = do
  conn <- connect connection
  comics <- query_ conn "select * from comic" 
  pure comics 

