{-# LANGUAGE OverloadedStrings #-}

module Database.PageRepository where

import Database.Configuration
import Data.Int (Int64)
import Entities.Page (Page, PagesData (PagesData, pages))
import Database.MySQL.Simple (
  connect,
  close,
  Only (..),
  query,
  query_,
  execute
  )

-- GET
getPageFromComicId :: Integer -> IO [Page]
getPageFromComicId comicId = do
  connRecord <- connection
  conn <- connect connRecord
  comic <- query conn "select page_id as Identification, \n\
                              \page_index as PageNumber, \n\
                              \page_path as FilePath, \n\
                              \fk_comic_id as ForeignKey \n\
                       \from page \n\
                       \where page.fk_comic_id = ?" (Only comicId)
  close conn
  pure comic

{-
-- POST 
createComic :: PagesData -> IO Int64 
createComic (PagesData { pages = p }) = do
  connRecord <- connection
  conn <- connect connRecord
  nbrRows <- execute conn "INSERT INTO comic (comic_title, comic_cover, comic_desc) VALUES (?, ?, ?)" (Only p)
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
replaceComicById :: Integer -> PagesData -> IO Int64 
replaceComicById modifyId (PagesData p') = do
  connRecord <- connection
  conn <- connect connRecord
  modifiedRow <- execute conn "UPDATE comic SET comic_title = ?, comic_cover = ?, comic_desc = ? where comic_id = ?" (p', modifyId)
  close conn
  pure modifiedRow
-}
