module Database.Configuration where

import Data.Word
import Text.Read (readMaybe)
import Database.MySQL.Simple
import System.Environment (getEnv) 

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

