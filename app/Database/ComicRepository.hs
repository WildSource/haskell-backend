{-# LANGUAGE OverloadedStrings #-}
module Database.ComicRepository where 

import Text.Read
import Data.Int (Int64)
import Data.Word (Word16)
import System.Environment
import Entities.Comic (
  Comic (..), 
  ComicData (..)
  )
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

connection :: IO ConnectInfo
connection = do 
  portStr <- getEnv "PORT"
  port <- maybe (fail "Invalid PORT environment variable") pure (stringToInt portStr)
  user <- getEnv "USER"
  pass <- getEnv "PASS"
  db <- getEnv "DB"

  let conn = defaultConnectInfo {
    connectPort = port,
    connectUser = user,
    connectPassword = pass,
    connectDatabase = db
  }
  
  pure conn
  where
    stringToInt :: String -> Maybe Word16
    stringToInt = readMaybe
  

-- GET
getComicFromId :: Integer -> IO Comic
getComicFromId id' = do
  connRecord <- connection
  conn <- connect connRecord
  [comic] <- query conn "SELECT * FROM comic  WHERE comic_id = ?" (Only id')
  close conn
  pure comic

-- GET ALL
getAllComics :: IO [Comic]
getAllComics = do
  connRecord <- connection
  conn <- connect connRecord
  comics <- query_ conn "SELECT * FROM comic" 
  close conn
  pure comics 

-- POST 
createComic :: ComicData -> IO Int64 
createComic (ComicData { d_title = t, d_cover = c, d_description = d}) = do
  connRecord <- connection
  conn <- connect connRecord
  nbrRows <- execute conn "INSERT INTO comic (comic_title, comic_cover, comic_desc) VALUES (?, ?, ?)" (t, c, d)
  close conn
  pure nbrRows

-- DELETE
deleteComicById :: Integer -> IO Int64
deleteComicById deleteId = do
  connRecord <- connection
  conn <- connect connRecord
  nbrDeletedRow <- execute conn "DELETE FROM comic where comic_id = ?" (Only deleteId)
  close conn
  pure nbrDeletedRow

-- PUT 
replaceComicById :: Integer -> ComicData -> IO Int64 
replaceComicById modifyId (ComicData t c d) = do
  connRecord <- connection
  conn <- connect connRecord
  modifiedRow <- execute conn "UPDATE comic SET comic_title = ?, comic_cover = ?, comic_desc = ? where comic_id = ?" (t, c, d, modifyId)
  close conn
  pure modifiedRow
