{-# LANGUAGE OverloadedStrings #-}
module Main where

import Application.Common.Headers (server)
import Application.Configuration.Discover
import Application.Configuration.Network
import Application.Routes
import Data.Text
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp (run)
import Util.Common.Request
import Util.Log


main :: IO ()
main = do
  netConf <- getResult <$> loadConfig defaultNC "network.json"
  let serverPort = _port netConf
  logEvent $ "Server is listening on :" <> (pack $ show serverPort)
  run serverPort routes
