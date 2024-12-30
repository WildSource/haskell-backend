{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Database.PageRepository where

import Database.Configuration
import Entities.Page (Page, PagesData (PagesData, pages))
import Database.MySQL.Simple (
  connect,
  close,
  Only (..),
  query,
  query_,
  execute, ConnectInfo (ConnectInfo)
  )

-- GET
getPage :: Integer -> IO [Page]
getPage comicId = do
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

type ComicId = Integer

-- POST 
createPage :: ComicId -> PagesData -> IO () 
createPage comic_id (PagesData { pages = p }) = do
  connRecord <- connection
  conn <- connect connRecord
  let query' = \(c_id :: Integer) (path :: String) -> execute conn "INSERT INTO page (page_path, fk_comic_id) VALUES (?, ?)" (path, c_id)
  _ <- mapM (query' comic_id) p
  close conn

-- DELETE
deletePageById :: Integer -> IO () 
deletePageById deleteId = do
  connRecord <- connection
  conn <- connect connRecord
  _ <- execute conn "DELETE FROM page where fk_comic_id = ?" (Only deleteId)
  close conn

{-
-- PUT 
replaceComicById :: Integer -> PagesData -> IO Int64 
replaceComicById modifyId (PagesData p') = do
  connRecord <- connection
  conn <- connect connRecord
  modifiedRow <- execute conn "UPDATE comic SET comic_title = ?, comic_cover = ?, comic_desc = ? where comic_id = ?" (p', modifyId)
  close conn
  pure modifiedRow
-}
