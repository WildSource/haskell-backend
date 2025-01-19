{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Database.PageRepository where

import Database.Configuration
import Entities.Page 
import Entities.DTR.PageDTR 
import Database.MySQL.Simple (
  connect,
  close,
  Only (..),
  query,
  execute
  )

-- GET
getPage :: Integer -> IO [Page]
getPage comicId = do
  connRecord <- connection
  conn <- connect connRecord
  comic <- query conn "select page_id,\n\
                              \page_path,\n\
                              \fk_comic_id\n\
                       \from page \n\
                       \where page.fk_comic_id = ?" (Only comicId)
  close conn
  pure comic

type ComicId = Integer

-- POST 
createPage :: ComicId -> PageDTR -> IO () 
createPage comic_id (PageDTR { pages = p }) = do
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

-- PUT 
replacePageById :: Integer -> PageDTR -> IO ()
replacePageById modifyId (PageDTR p') = do
  connRecord <- connection
  conn <- connect connRecord
  -- First get the page IDs for this comic in order
  pageIds <- query conn "SELECT page_id FROM page WHERE fk_comic_id = ? ORDER BY page_id" [modifyId] :: IO [Only Integer]
  -- Zip the page IDs with the new paths and update each one
  let updates = zip (map fromOnly pageIds) p'
  let update = \(pageId :: Integer, path :: String) -> 
        execute conn "UPDATE page SET page_path = ? WHERE page_id = ?" (path, pageId)
  _ <- mapM update updates
  close conn
