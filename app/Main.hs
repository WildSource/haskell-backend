{-# LANGUAGE OverloadedStrings #-}
module Main where

import Env
import Server.Configuration (app)
import Network.Wai.Handler.Warp (run)

main :: IO ()
main = do
  loadEnv
  run 8081 app
   
