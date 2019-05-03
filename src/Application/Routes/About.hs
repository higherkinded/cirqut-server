{-# LANGUAGE OverloadedStrings #-}
module Application.Routes.About
  ( about
  ) where


import Application.Common.About
import Application.Common.Headers
import Application.Routes.About.Credits
import Data.ByteString.Lazy
import Network.Wai
import Network.HTTP.Types
import Util.Common.ByteString
import Util.Common.Request
import Util.Common.Response

aboutResponse :: Response
aboutResponse = responseLBS
  status200
  [server, cPlaintext]
  $ intercalate "\n"
  [ "Cirqut Server v." <> toLazy version
  , ""
  , "Cirqut Server is a backend for a Cirqut application, the project"
  , "management tool. It's open-sourced and is available for Git checkout at:"
  , ""
  , toLazy repoLoc
  , ""
  , "You are encouraged to contribute; cotributors end up in a hall of fame"
  , "(at /about/credits), which is bundled in every form of distribution."
  ]


about :: Application
about req res =
  let path = dissectPathInfo req
  in case path of
    PathChain "credits" _ -> credits (popPath req) res
    PathEmpty             -> res aboutResponse
    _                     -> res notFound
