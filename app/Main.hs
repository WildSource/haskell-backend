{-# LANGUAGE OverloadedStrings #-}
module Main where

import Network.Wai.Handler.Warp (run)
import Server.Configuration (app)

main :: IO ()
main = do
  
  -- run 8081 app
   
