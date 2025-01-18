{-# LANGUAGE OverloadedStrings #-}

module Database.ComicRepository where 

import Data.Int (Int64)
import Database.Configuration
import Entities.Comic 
import Entities.DTR.ComicDTR
import Database.MySQL.Simple (
  connect,
  close,
  Only (..),
  query,
  query_,
  execute
  )

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
createComic :: ComicDTR -> IO Int64 
createComic (ComicDTR { d_title = t, d_cover = c, d_description = d}) = do
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
replaceComicById :: Integer -> ComicDTR -> IO Int64 
replaceComicById modifyId (ComicDTR t c d) = do
  connRecord <- connection
  conn <- connect connRecord
  modifiedRow <- execute conn "UPDATE comic SET comic_title = ?, comic_cover = ?, comic_desc = ? where comic_id = ?" (t, c, d, modifyId)
  close conn
  pure modifiedRow
