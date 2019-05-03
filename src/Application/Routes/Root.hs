{-# LANGUAGE OverloadedStrings #-}
module Application.Routes.Root
  ( root
  ) where


import Application.Common.Headers
import Network.HTTP.Types
import Network.Wai
import Util.Common.ByteString


root :: Application
root req respond = respond . responseLBS status200 [server, cPlaintext]
  $ (toLazy $ requestMethod req) <> " / - 200"